import 'package:consultz/feature/bookings/controller/socket_service_controller.dart';
import 'package:consultz/core/services/deep_link_service.dart';
import 'package:consultz/core/utils/share_preference/auth_preference.dart';
import 'package:consultz/feature/call/controller/call_controller.dart';
import 'package:consultz/feature/call/controller/call_service_controller.dart';
import 'package:consultz/firebase_options.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/route/routes.dart';
import 'package:consultz/core/constants/app_theme.dart';
import 'package:consultz/core/constants/init_dependency_binding.dart';
import 'package:consultz/core/utils/helpers/notification_helper.dart';
import 'package:consultz/core/utils/share_preference/call_preference.dart';
import 'package:consultz/feature/call/pages/video_call_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_callkit_incoming/entities/call_event.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'dart:developer';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log('Handling a background message: ${message.messageId}');
  log('Background message data: ${message.data}');

  final data = message.data;
  final String type = data['type']?.toString() ?? '';

  // If it's a cancellation or end message, dismiss CallKit
  if (type == 'call_cancelled' ||
      type == 'call_canceled' ||
      type == 'call_ended' ||
      data['status'] == 'cancelled') {
    log(
      'Call canceled/ended received in background. Ending all CallKit sessions.',
    );
    await FlutterCallkitIncoming.endAllCalls();
    await CallPreference.clearPendingCall();
    return;
  }

  if (type == 'incoming_call' || data['call_id'] != null) {
    await NotificationHelper.showCallkitIncoming(message);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Put core controllers immediately (Sync)
  Get.put(SocketServiceController());
  Get.put(CallServiceController());
  Get.put(CallController());
  await Get.putAsync(() => DeepLinkService().init());

  // 2. Register CallKit listener ASAP
  FlutterCallkitIncoming.onEvent.listen((event) {
    if (event == null) return;
    switch (event.event) {
      case Event.actionCallAccept:
        log('📞 CallKit: Call Accepted');
        final data = event.body['extra'];
        if (Get.isRegistered<CallServiceController>()) {
          Get.find<CallServiceController>().handleCallKitAccept(data);
        }
        break;
      case Event.actionCallDecline:
        log('❌ CallKit: Call Declined');
        final data = event.body['extra'];
        if (Get.isRegistered<CallServiceController>()) {
          Get.find<CallServiceController>().handleCallKitDecline(data);
        }
        break;
      default:
        break;
    }
  });

  // 3. Start initializations
  // We MUST await these before running the app to ensure dotenv and Firebase are ready
  await AuthPreference().initializeToken();
  await dotenv.load(fileName: "consultz.env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationHelper.init();

  // Background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Start Socket connection (Async)
  Get.find<SocketServiceController>().init();

  Stripe.publishableKey = dotenv.env['publishableKey'] ?? '';
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // 4. Quick check for accepted call (Instant search)
  Map<String, dynamic>? pendingCall = await CallPreference.getPendingCall();

  // If no saved call, check if there's any active call in the system first
  if (pendingCall == null) {
    final initialCalls = await FlutterCallkitIncoming.activeCalls();
    if (initialCalls is List && initialCalls.isNotEmpty) {
      log('⏳ Startup: Active call detected. Monitoring for "Accept" status...');
      for (int i = 0; i < 30; i++) {
        pendingCall = await CallPreference.getPendingCall();
        if (pendingCall != null) break;

        final currentCalls = await FlutterCallkitIncoming.activeCalls();
        if (currentCalls is List && currentCalls.isNotEmpty) {
          final firstCall = currentCalls.first;
          if (firstCall['accepted'] == true ||
              firstCall['isAccepted'] == true) {
            if (firstCall['extra'] != null) {
              pendingCall = Map<String, dynamic>.from(firstCall['extra']);
              pendingCall['accepted_at'] =
                  DateTime.now().millisecondsSinceEpoch;
              break;
            }
          }
        } else {
          break;
        }
        await Future.delayed(const Duration(milliseconds: 100));
      }
    }
  }

  if (pendingCall != null) {
    final int acceptedAt = pendingCall['accepted_at'] is int
        ? pendingCall['accepted_at']
        : 0;
    final now = DateTime.now().millisecondsSinceEpoch;

    if (acceptedAt != 0 && (now - acceptedAt < 120000)) {
      log('🔥 Startup: Accepted call found! Launching VideoCallPage.');

      final callController = Get.find<CallController>();
      callController.callId.value = pendingCall['call_id']?.toString() ?? '';
      callController.channelName.value =
          pendingCall['channel_name']?.toString() ?? '';
      callController.token.value = pendingCall['agora_token']?.toString() ?? '';
      callController.uid.value = pendingCall['agora_uid'] is int
          ? pendingCall['agora_uid']
          : int.tryParse(pendingCall['agora_uid']?.toString() ?? '0') ?? 0;

      runApp(Consultz(pendingCall: pendingCall));
      return;
    }
  }

  runApp(const Consultz(pendingCall: null));
}

class Consultz extends StatelessWidget {
  final Map<String, dynamic>? pendingCall;
  const Consultz({super.key, this.pendingCall});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Consultz',
      debugShowCheckedModeBanner: false,
      initialRoute: pendingCall == null ? RoutesConstant.splashScreen : null,
      home: pendingCall != null
          ? VideoCallPage(
              name: pendingCall!['caller_name']?.toString() ?? '',
              photoUrl: pendingCall!['caller_photo']?.toString() ?? '',
              chatId: '',
              channelName: pendingCall!['channel_name']?.toString() ?? '',
              token: pendingCall!['agora_token']?.toString() ?? '',
              uid: pendingCall!['agora_uid'] is int
                  ? pendingCall!['agora_uid']
                  : int.tryParse(
                          pendingCall!['agora_uid']?.toString() ?? '0',
                        ) ??
                        0,
              callId: pendingCall!['call_id']?.toString() ?? '',
              isGroupCall: false,
              callerName: pendingCall!['caller_name']?.toString() ?? '',
              isCaller: false,
            )
          : null,
      getPages: Routes.routes,
      theme: AppTheme.lightTheme,
      initialBinding: InitDependencyBinding(),
      builder: (context, child) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
