import 'dart:developer';
import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_callkit_incoming/entities/entities.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:get/get.dart';
import 'package:consultz/feature/notification/controller/notification_controller.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationHelper {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const String channelId = 'high_importance_channel';
  static const String channelName = 'High Importance Notifications';

  static Future<void> init() async {
    try {
      final messaging = FirebaseMessaging.instance;

      // Request permission for Android 13+ and iOS
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        log('User granted permission');
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        log('User granted provisional permission');
      } else {
        log('User declined or has not accepted permission');
      }

      await messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      // Get FCM Token and send to backend
      String? fcmToken = await messaging.getToken();
      log("FCM Token: $fcmToken");
      if (fcmToken != null) {
        await _sendTokenToBackend(fcmToken: fcmToken);
      }

      // Listen for FCM token refresh
      messaging.onTokenRefresh.listen((newToken) async {
        log("FCM Token Refreshed: $newToken");
        await _sendTokenToBackend(fcmToken: newToken);
      });

      // iOS: APNs Token + VoIP Push Token
      if (GetPlatform.isIOS) {
        // APNs Token (needed for FCM on iOS)
        String? apnsToken;
        int retryCount = 0;
        while (apnsToken == null && retryCount < 10) {
          apnsToken = await messaging.getAPNSToken();
          if (apnsToken == null) {
            log("Waiting for APNs token... (Attempt ${retryCount + 1})");
            await Future.delayed(const Duration(seconds: 2));
            retryCount++;
          }
        }
        if (apnsToken != null) {
          log("APNs Token: $apnsToken");
        } else {
          log("Failed to get APNs token after 10 attempts.");
        }

        // VoIP Push Token — আসে AppDelegate.swift থেকে PushKit-এর মাধ্যমে
        // flutter_callkit_incoming এই token expose করে
        FlutterCallkitIncoming.getDevicePushTokenVoIP().then((voipToken) async {
          if (voipToken != null && voipToken.toString().isNotEmpty) {
            log("📱 VoIP Push Token (Flutter): $voipToken");
            await _sendTokenToBackend(voipToken: voipToken.toString());
          }
        }).catchError((e) {
          log("VoIP token error: $e");
        });
      }

      // Initialize local notifications
      const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
      const iosInit = DarwinInitializationSettings();
      const initSettings = InitializationSettings(
        android: androidInit,
        iOS: iosInit,
      );

      // Android: high importance channel
      await _notificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(const AndroidNotificationChannel(
            channelId,
            channelName,
            importance: Importance.max,
            playSound: true,
            enableVibration: true,
          ));

      await _notificationsPlugin.initialize(
        settings: initSettings,
        onDidReceiveNotificationResponse: (details) {
          log('Notification clicked');
        },
      );

      // Foreground FCM message handler
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        log('Foreground FCM message: ${message.data}');

        final isCallMessage = message.data['type'] == 'incoming_call' ||
            message.data['call_id'] != null;

        if (isCallMessage) {
          // iOS: PushKit handles incoming calls — skip FCM-based CallKit here
          // Android: foreground calls are handled by socket dialog, skip here too
          log('Call FCM in foreground — handled by socket/PushKit, skipping.');
          return;
        }

        // Refresh in-app notification list
        try {
          if (Get.isRegistered<NotificationController>()) {
            Get.find<NotificationController>().getNotifications();
          }
        } catch (e) {
          log('Error refreshing notifications: $e');
        }

        if (message.notification != null) {
          _showLocalNotification(message);
        }
      });
    } catch (e) {
      log('NotificationHelper init error: $e');
    }
  }

  // Backend-এ FCM token এবং VoIP token পাঠানো
  static Future<void> _sendTokenToBackend({
    String? fcmToken,
    String? voipToken,
  }) async {
    try {
      final Map<String, dynamic> body = {};
      if (fcmToken != null) body['fcmToken'] = fcmToken;
      if (voipToken != null) body['voipToken'] = voipToken;
      if (body.isEmpty) return;

      final response = await ApiCaller.patchRequest(
        url: ApiUrls.updateDeviceToken,
        body: body,
      );
      log('Device token update: ${response?.isSuccess} — ${response?.message}');
    } catch (e) {
      log('Failed to send device token to backend: $e');
    }
  }

  // Android background/terminated-এ FCM call notification দেখানো
  // iOS-এ এটা call করা উচিত নয় — PushKit দিয়ে হয়
  static Future<void> showCallkitIncoming(RemoteMessage message) async {
    // iOS-এ PushKit দিয়ে CallKit দেখানো হয় (AppDelegate.swift)
    // এই function শুধু Android-এর জন্য
    if (GetPlatform.isIOS) {
      log('iOS: CallKit is handled by PushKit in AppDelegate, skipping FCM CallKit.');
      return;
    }

    final data = message.data;
    final String callId = data['call_id']?.toString() ?? '';

    CallKitParams params = CallKitParams(
      id: callId,
      nameCaller: data['caller_name'] ?? 'Unknown',
      appName: 'Consultz',
      avatar: data['caller_photo'] ?? '',
      handle: (data['is_video'] == 'true' || data['is_video'] == true)
          ? 'Video Call'
          : 'Audio Call',
      type: (data['is_video'] == 'true' || data['is_video'] == true) ? 1 : 0,
      duration: 30000,
      textAccept: 'Accept',
      textDecline: 'Decline',
      extra: <String, dynamic>{
        'call_id': data['call_id'],
        'channel_name': data['channel_name'],
        'agora_token': data['agora_token'],
        'agora_uid': data['agora_uid'],
        'caller_name': data['caller_name'],
        'caller_photo': data['caller_photo'],
      },
      android: AndroidParams(
        isCustomNotification: false,
        isShowLogo: false,
        ringtonePath: 'ringtone_incoming',
        backgroundColor: '#09121F',
        actionColor: '#4CAF50',
        incomingCallNotificationChannelName: 'Incoming Call Service v2',
        isShowFullLockedScreen: true,
      ),
      ios: IOSParams(
        iconName: 'AppIcon',
        handleType: 'generic',
        supportsVideo: true,
        maximumCallGroups: 2,
        maximumCallsPerCallGroup: 1,
        audioSessionMode: 'default',
        audioSessionActive: true,
        audioSessionPreferredSampleRate: 44100.0,
        audioSessionPreferredIOBufferDuration: 0.005,
        supportsDTMF: true,
        supportsHolding: true,
        supportsGrouping: true,
        supportsUngrouping: true,
        ringtonePath: '',
      ),
      missedCallNotification: NotificationParams(
        showNotification: true,
        isShowCallback: true,
        subtitle: 'Missed call',
        callbackText: 'Call back',
      ),
    );

    await FlutterCallkitIncoming.showCallkitIncoming(params);
  }

  static Future<void> _showLocalNotification(RemoteMessage message) async {
    const androidDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notificationsPlugin.show(
      id: message.hashCode,
      title: message.notification?.title,
      body: message.notification?.body,
      notificationDetails: notificationDetails,
    );
  }

  static Future<String?> getFCMToken() async {
    return await FirebaseMessaging.instance.getToken();
  }

  static Future<bool> checkPermission() async {
    PermissionStatus status = await Permission.notification.status;
    return status.isGranted;
  }

  static Future<bool> requestNotificationPermission() async {
    if (await checkPermission()) return true;

    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional) {
      return true;
    }

    PermissionStatus status = await Permission.notification.request();
    if (status.isPermanentlyDenied) {
      await openAppSettings();
    }

    return await checkPermission();
  }
}
