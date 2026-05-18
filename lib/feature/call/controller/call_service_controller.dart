// ignore_for_file: library_prefixes

// import 'package:audioplayers/audioplayers.dart';
import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:consultz/core/constants/app_audio.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/core/utils/share_preference/auth_preference.dart';
import 'package:consultz/core/utils/share_preference/call_preference.dart';
import 'package:consultz/feature/call/controller/call_controller.dart';
import 'package:consultz/feature/call/pages/video_call_page.dart';
import 'package:consultz/feature/call/widgets/call_incoming_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class CallServiceController extends GetxController {
  final AudioPlayer _incomingRingPlayer = AudioPlayer();
  final Rxn<Map<String, dynamic>> incomingCall = Rxn<Map<String, dynamic>>();
  final Rxn<Map<String, dynamic>> pendingCall = Rxn<Map<String, dynamic>>();

  RxBool isLoading = false.obs;

  IO.Socket? _socket;
  final RxBool callDeclinedSignal = false.obs;
  final RxBool callEndedSignal = false.obs;
  final Map<String, Map<String, dynamic>> _callInfoCache = {};
  final Set<String> _callkitShownKeys = {};

  bool callkitShowing = false;

  final RxMap<int, Map<String, String>> participantInfo =
      <int, Map<String, String>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _incomingRingPlayer.setReleaseMode(ReleaseMode.loop);
  }

  Future<void> _startIncomingRingtone() async {
    try {
      log('🔊 Attempting to play ringtone: ${AppAudio.incomingCallRingtone}');
      
      await _incomingRingPlayer.setReleaseMode(ReleaseMode.loop);
      await _incomingRingPlayer.setVolume(1.0);
      await _incomingRingPlayer.play(
        AssetSource(AppAudio.incomingCallRingtone),
      );
      log('✅ Ringtone playback command sent');
    } catch (e) {
      log('❌ Ringtone playback failed: $e');
    }
  }

  void setSocket(IO.Socket socket) {
    _socket = socket;
  }

  // Phase 1: Call Start (Caller)
  Future<void> startCall({
    required String bookingId,
    bool isVideo = true,
  }) async {
    if (_socket == null || !_socket!.connected) {
      bottomMessage(msg: 'Socket not connected');
      return;
    }

    isLoading.value = true;
    _socket!.emitWithAck(
      'call-start',
      {'bookingId': bookingId, 'isVideo': isVideo},
      ack: (response) {
        isLoading.value = false;
        log('📞 call-start response: $response');
        if (response != null && response['success'] == true) {
          final data = response['data'];
          final callController = Get.find<CallController>();
          callController.setCallData(data);
          
          // Ensure bookingId is set (either from server response or from the parameter)
          if (callController.bookingId.value.isEmpty) {
            callController.bookingId.value = bookingId;
          }

          // Caller joins Agora immediately
          Get.to(
            () => VideoCallPage(
              name:
                  '', // Will be updated by participantInfo or handled in VideoCallPage
              photoUrl: '',
              chatId: '',
              channelName: callController.channelName.value,
              token: callController.token.value,
              uid: callController.uid.value,
              callId: callController.callId.value,
              isGroupCall: false,
              callerName: AuthPreference.cachedUserName,
              isCaller: true,
            ),
            transition: Transition.fadeIn,
          );
        } else {
          bottomMessage(msg: response?['message'] ?? 'Failed to start call');
        }
      },
    );
  }

  // Phase 2: Receiver Incoming Call পায়
  void handleCallIncoming(dynamic data) async {
    log('📞 Incoming call: $data');
    incomingCall.value = Map<String, dynamic>.from(data);

    final callController = Get.find<CallController>();
    callController.bookingId.value = (data?['bookingId'] ?? data?['booking_id'])?.toString() ?? '';

    final appState = SchedulerBinding.instance.lifecycleState;
    final isAppForeground = appState == AppLifecycleState.resumed;

    if (isAppForeground) {
      _startIncomingRingtone();
      _showIncomingCallOverlay();
    } else {
      // Background handling logic (FCM or CallKit if used)
    }
  }

  void _showIncomingCallOverlay() {
    if (Get.isDialogOpen ?? false) Get.back();

    final data = incomingCall.value;
    final String name = data?['callerName']?.toString() ?? 'Unknown';
    final String image = (data?['callerPhoto'] ?? data?['callerImage'])?.toString() ?? '';

    Get.dialog(
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.7),
      IncomingCallDialog(
        isGroup: false,
        callerName: name,
        callerImage: image,
        onAccept: () => _handleAcceptCall(),
        onReject: () => _handleRejectCall(),
      ),
    );
  }

  // Phase 3: Receiver Accept করে
  Future<void> _handleAcceptCall() async {
    final callController = Get.find<CallController>();
    final data = incomingCall.value;
    final callId = data?['callId'] ?? data?['call_id'];
    final channelName = data?['channelName'] ?? data?['channel_name'];
    final callerName = data?['callerName'] ?? data?['caller_name'] ?? '';
    final callerImage = data?['callerImage'] ?? data?['caller_photo'] ?? '';

    isLoading.value = true;

    // Check if we already have token and UID from notification
    bool hasCredentials = false;
    if (data != null && 
        (data.containsKey('agora_token') || data.containsKey('token')) && 
        (data.containsKey('agora_uid') || data.containsKey('uid'))) {
      
      final String token = (data['agora_token'] ?? data['token']).toString();
      final dynamic rawUid = data['agora_uid'] ?? data['uid'];
      final int uid = rawUid is int ? rawUid : int.tryParse(rawUid.toString()) ?? 0;
      
      if (token.isNotEmpty && uid != 0) {
        log('✅ Using Agora credentials from notification data');
        callController.token.value = token;
        callController.uid.value = uid;
        hasCredentials = true;
      }
    }

    bool isSuccess = true;
    if (!hasCredentials) {
      log('🌐 Fetching Agora token from API...');
      isSuccess = await callController.getToken(callId: callId);
    }

    if (isSuccess) {
      _socket?.emitWithAck(
        'call-accept',
        {'callId': callId},
        ack: (response) {
          isLoading.value = false;
          log('📞 call-accept response: $response');
          if (response != null && response['success'] == true) {
            _stopIncomingRingtone();
            if (Get.isDialogOpen ?? false) Get.back();

            resetCallSignals();
            log('🚀 Navigating to VideoCallPage. Channel: $channelName, UID: ${callController.uid.value}, Token length: ${callController.token.value.length}');
            
            Get.to(
              () => VideoCallPage(
                name: callerName,
                photoUrl: callerImage,
                chatId: '',
                channelName: channelName ?? '',
                token: callController.token.value,
                uid: callController.uid.value,
                callId: callId,
                isGroupCall: false,
                callerName: callerName,
                isCaller: false,
              ),
              transition: Transition.fadeIn,
            );
          } else {
            bottomMessage(msg: response?['message'] ?? 'Failed to accept call');
          }
        },
      );
    } else {
      isLoading.value = false;
    }
  }

  // Phase 4: Receiver Decline করে
  void _handleRejectCall() {
    final callId = incomingCall.value?['callId'];
    log('❌ Rejecting call. callId: $callId');

    if (_socket?.connected == true) {
      _socket!.emitWithAck(
        'call-decline',
        {'callId': callId},
        ack: (response) {
          log('📞 call-decline response: $response');
          _clearCallStates();
        },
      );
    } else {
      _clearCallStates();
    }
  }

  // Handlers for socket events
  void handleCallAccepted(dynamic data) {
    log('📞 Call Accepted by remote: $data');
    if (data != null && data['participants'] != null) {
      final participants = data['participants'] as List;
      log('📊 Participants from Server:');
      for (var p in participants) {
        final uid = p['agoraUid'] ?? p['uid'];
        final role = p['role'] ?? 'unknown';
        log('   - Role: $role, UID: $uid');
        
        final int? pUid = uid is int
            ? uid
            : int.tryParse(uid?.toString() ?? '');
        if (pUid != null) {
          participantInfo[pUid] = {
            'name': p['name']?.toString() ?? '',
            'image': p['image']?.toString() ?? '',
          };
        }
      }
    }
  }

  void handleCallDeclined(dynamic data) {
    log('📞 Call Declined: $data');
    callDeclinedSignal.value = true;
    _clearCallStates();
  }

  void handleCallCanceled(dynamic data) {
    log('📞 Call Canceled: $data');
    if (Get.isDialogOpen ?? false) Get.back();
    _clearCallStates();
    // Signal for active call screen to close
    callEndedSignal.value = true;
  }

  void handleCallEnded(dynamic data) {
    log('📞 Call Ended: $data');
    callEndedSignal.value = true;
    _clearCallStates();
  }

  void handleBookingComplete(dynamic data) {
    log('✅ Booking Complete Received: $data');
    // You can add logic here if you need to show a success message or navigate
    // For now, we'll just log it as the call state is already cleared by endCall/leaveAndPop
  }

  // Emission methods for manual calling UI
  void cancelCall(String callId) {
    _socket?.emit('call-cancel', {'callId': callId});
  }

  void endCall(String callId, {int? duration}) {
    Map<String, dynamic> payload = {'callId': callId};

    if (duration != null) {
      payload['duration'] = duration;
    }

    _socket?.emit('call-end', payload);
  }

  void completeBooking({
    required String bookingId,
    required String callId,
    required int duration,
  }) {
    log('📤 Emitting booking-complete: bookingId: $bookingId, callId: $callId, duration: $duration');
    _socket?.emit('booking-complete', {
      'bookingId': bookingId,
      'callId': callId,
      'duration': duration,
    });
  }

  // Handlers for CallKit events
  Future<void> handleCallKitAccept(dynamic data) async {
    log('📞 Handling CallKit Accept: $data');
    if (data == null) return;

    final callController = Get.find<CallController>();
    final String callId = data['call_id']?.toString() ?? '';
    final String channelName = data['channel_name']?.toString() ?? '';
    final String token = data['agora_token']?.toString() ?? '';
    final int uid = data['agora_uid'] is int 
        ? data['agora_uid'] 
        : int.tryParse(data['agora_uid']?.toString() ?? '0') ?? 0;
    final String callerName = data['caller_name']?.toString() ?? '';
    final String callerImage = data['caller_photo']?.toString() ?? '';

    // Set data in controller
    callController.callId.value = callId;
    callController.bookingId.value = (data['bookingId'] ?? data['booking_id'])?.toString() ?? '';
    callController.channelName.value = channelName;
    callController.token.value = token;
    callController.uid.value = uid;
    
    // Save to preferences for persistence across app start (terminated state)
    final Map<String, dynamic> persistentData = Map<String, dynamic>.from(data);
    persistentData['accepted_at'] = DateTime.now().millisecondsSinceEpoch;
    await CallPreference.savePendingCall(persistentData);
    log('💾 Call data saved to preferences with timestamp: ${persistentData['accepted_at']}');

    // Navigate to Video Call Page
    // Using a slight delay to ensure GetX navigation is ready
    // Navigate to Video Call Page
    // If we are already in the app (background/foreground), we can navigate faster.
    // If we just started (Terminated), we might need a small delay for GetX initialization.
    final bool isOnSplash = Get.currentRoute == '/splashScreen' || Get.currentRoute == '/SplashScreen';
    final int delayMs = isOnSplash ? 500 : 100;

    Future.delayed(Duration(milliseconds: delayMs), () {
      // Re-check route inside the timer
      if (Get.currentRoute == '/splashScreen' || Get.currentRoute == '/SplashScreen') {
        log('⏳ App is still in Splash screen, letting Splash handle persistent navigation');
        return;
      }

      log('🚀 Navigating to VideoCallPage from CallKit handler');
      Get.to(
        () => VideoCallPage(
          name: callerName,
          photoUrl: callerImage,
          chatId: '',
          channelName: channelName,
          token: token,
          uid: uid,
          callId: callId,
          isGroupCall: false,
          callerName: callerName,
          isCaller: false,
        ),
        transition: Transition.fadeIn,
      );
      
      // Also emit call-accept to socket if connected
      if (_socket?.connected == true) {
        _socket?.emit('call-accept', {'callId': callId});
      }
    });
  }

  // Handle navigation for a call that was accepted while app was terminated/background
  void handlePendingCallNavigation(Map<String, dynamic> data) {
    log('🚀 Handling pending call navigation: $data');
    final String callId = data['call_id']?.toString() ?? '';
    final String channelName = data['channel_name']?.toString() ?? '';
    final String token = data['agora_token']?.toString() ?? '';
    final int uid = data['agora_uid'] is int 
        ? data['agora_uid'] 
        : int.tryParse(data['agora_uid']?.toString() ?? '0') ?? 0;
    final String callerName = data['caller_name']?.toString() ?? '';
    final String callerImage = data['caller_photo']?.toString() ?? '';
    final int acceptedAt = data['accepted_at'] is int ? data['accepted_at'] : 0;

    // If the call was accepted more than 2 minutes ago, it's likely expired
    if (acceptedAt != 0) {
      final now = DateTime.now().millisecondsSinceEpoch;
      if (now - acceptedAt > 120000) { // 2 minutes
        log('⚠️ Pending call is too old (> 2 mins), clearing.');
        CallPreference.clearPendingCall();
        return;
      }
    }

    if (callId.isEmpty || channelName.isEmpty) {
      log('⚠️ Pending call data incomplete, clearing.');
      CallPreference.clearPendingCall();
      return;
    }

    final callController = Get.find<CallController>();
    callController.callId.value = callId;
    callController.bookingId.value = (data['bookingId'] ?? data['booking_id'])?.toString() ?? '';
    callController.channelName.value = channelName;
    callController.token.value = token;
    callController.uid.value = uid;

    log('🔥 Navigating to VideoCallPage from Splash check');
    Get.offAll(
      () => VideoCallPage(
        name: callerName,
        photoUrl: callerImage,
        chatId: '',
        channelName: channelName,
        token: token,
        uid: uid,
        callId: callId,
        isGroupCall: false,
        callerName: callerName,
        isCaller: false,
      ),
      transition: Transition.fadeIn,
    );
    
    // Also emit call-accept to socket if connected
    if (_socket?.connected == true) {
      _socket?.emit('call-accept', {'callId': callId});
    }
    
    // We keep the preference until the call actually ends or is cleared in VideoCallPage
    // Or we can clear it now since we've already navigated
    CallPreference.clearPendingCall();
  }

  Future<void> handleCallKitDecline(dynamic data) async {
    log('❌ Handling CallKit Decline: $data');
    if (data == null) return;
    
    final String callId = data['call_id']?.toString() ?? '';
    
    // If socket is not connected, wait up to 10 seconds for it to connect
    if (_socket == null || !_socket!.connected) {
      log('⏳ Socket not connected, waiting for connection to decline call (up to 10s)...');
      for (int i = 0; i < 20; i++) {
        await Future.delayed(const Duration(milliseconds: 500));
        if (_socket != null && _socket!.connected) {
          log('✅ Socket connected! Proceeding with decline.');
          break;
        }
      }
    }

    if (_socket?.connected == true) {
      _socket?.emit('call-decline', {'callId': callId});
      log('📤 Sent call-decline for callId: $callId');
    } else {
      log('❌ Failed to decline call via socket: Socket not connected after timeout.');
    }
    _clearCallStates();
  }

  void _clearCallStates() {
    log('Clearing all call states');
    pendingCall.value = null;
    incomingCall.value = null;
    CallPreference.clearPendingCall();
    _callInfoCache.clear();
    _callkitShownKeys.clear();
    callkitShowing = false;
    _stopIncomingRingtone();
    FlutterCallkitIncoming.endAllCalls();
    clearParticipantInfo();
    if (Get.isDialogOpen ?? false) {
      // Check if it's a dialog and not a page
      // But Get.back() is fine usually
      Get.back();
    }
  }

  Future<void> _stopIncomingRingtone() async {
    try {
      await _incomingRingPlayer.stop();
      log('🔕 Ringtone stopped');
    } catch (e) {
      log('Stop ringtone error: $e');
    }
  }

  void clearParticipantInfo() {
    participantInfo.clear();
  }

  void resetCallSignals() {
    callDeclinedSignal.value = false;
    callEndedSignal.value = false;
  }
}
