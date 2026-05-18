import 'dart:async';
import 'dart:developer';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:consultz/core/constants/app_audio.dart';
import 'package:consultz/core/utils/share_preference/auth_preference.dart';
import 'package:consultz/core/utils/share_preference/call_preference.dart';
import 'package:consultz/feature/bookings/controller/socket_service_controller.dart';
import 'package:consultz/feature/call/controller/call_controller.dart';
import 'package:consultz/feature/call/controller/call_service_controller.dart';
import 'package:consultz/core/utils/image/display_network_image.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/route/route_constant.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:permission_handler/permission_handler.dart';

class VideoCallPage extends StatefulWidget {
  final String name;
  final String photoUrl;
  final String chatId;
  final String channelName;
  final String token;
  final int uid;
  final String callId;
  final String? groupId;
  final String? classId;
  final bool isGroupCall;
  final String? callerName;
  final bool isCaller;

  const VideoCallPage({
    super.key,
    required this.name,
    required this.photoUrl,
    required this.chatId,
    required this.channelName,
    required this.token,
    required this.uid,
    required this.callId,
    this.groupId,
    this.classId,
    this.isGroupCall = false,
    this.callerName,
    this.isCaller = true,
  });

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  final AudioPlayer _player = AudioPlayer();
  final appBarId = dotenv.env['agoraAppId'];
  RtcEngine? _engine;
  final _engineInitialized = false.obs;
  final _remoteUids = <int>[].obs;

  final _remoteVideoMuted = <int>{}.obs;


  final localUserJoined = false.obs;
  final _micEnabled = true.obs;
  final _cameraEnabled = true.obs;
  final _speakerEnabled = true.obs;
  bool _isLeavingCall = false;


  DateTime? _callStartTime;
  final socketService = Get.find<SocketServiceController>();
  final callService = Get.isRegistered<CallServiceController>()
      ? Get.find<CallServiceController>()
      : Get.put(CallServiceController());
  final _callController = Get.find<CallController>();

  Worker? _declinedWorker;
  Worker? _endedWorker;
  Worker? _participantInfoWorker;

  Timer? _noAnswerTimer;
  RxString durationString = '00:00'.obs;
  String _currentToken = '';

  @override
  void initState() {
    super.initState();
    _currentToken = widget.token;
    callService.resetCallSignals();
    _player.setReleaseMode(ReleaseMode.loop);

    _initWorkers();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (await _ensurePermissions()) {
        _joinCall();
      } else {
        if (mounted) Navigator.pop(context);
      }
    });
  }

  void _initWorkers() {
    _declinedWorker = ever(callService.callDeclinedSignal, (bool value) {
      if (value && mounted && !_isLeavingCall) _handleRemoteExit();
    });

    _endedWorker = ever(callService.callEndedSignal, (bool value) {
      if (value && mounted && !_isLeavingCall) _handleRemoteExit();
    });

    _participantInfoWorker = ever(callService.participantInfo, (_) {
      if (mounted) setState(() {});
    });
  }

  Future<bool> _ensurePermissions() async {
    final statuses = await [Permission.microphone, Permission.camera].request();
    return (statuses[Permission.microphone]?.isGranted ?? false) &&
        (statuses[Permission.camera]?.isGranted ?? false);
  }

  void _handleRemoteExit() {
    _cancelNoAnswerTimer();
    _leaveAndPop();
  }

  void _joinCall() async {
    await initAgora();
  }

  Future<void> initAgora() async {
    try {
      _engine = createAgoraRtcEngine();
      log('🚀 Agora App ID: $appBarId');
      
      await _engine!.initialize(
        RtcEngineContext(
          appId: appBarId,
          channelProfile: ChannelProfileType.channelProfileCommunication,
        ),
      );

      _setupEventHandlers();
      await _engine!.enableVideo();
      _engineInitialized.value = true;

      final int joinUid = widget.uid & 0xFFFFFFFF;
      log('🚀 Agora: Joining channel: ${widget.channelName} with UID: $joinUid');
      log('🚀 Agora: Token: ${_currentToken.trim().substring(0, 10)}...');

      await _engine!.joinChannel(
        token: _currentToken.trim(),
        channelId: widget.channelName.trim(),
        uid: joinUid,
        options: const ChannelMediaOptions(
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
          publishMicrophoneTrack: true,
          publishCameraTrack: true,
          autoSubscribeAudio: true,
          autoSubscribeVideo: true,
        ),
      );

      if (widget.isCaller) {
        _playRingtone();
      }
    } catch (e) {
      log('Agora Init Error: $e');
    }
  }

  void _setupEventHandlers() {
    _engine?.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (connection, elapsed) {
          log('✅ Agora: Joined successfully! Channel: ${connection.channelId}, UID: ${connection.localUid}');
          if (mounted) {
            localUserJoined.value = true;
            _startNoAnswerTimer();
          }
        },

        onRejoinChannelSuccess: (connection, elapsed) {
          log('🔄 Agora: Rejoined channel successfully');
        },

        onUserJoined: (connection, rUid, elapsed) {
          log('👥 Agora: Remote user joined: $rUid');
          if (mounted) {
            _cancelNoAnswerTimer();
            _stopRingtone();
            if (!_remoteUids.contains(rUid)) _remoteUids.add(rUid);
            if (_remoteUids.length == 1) {
              _callStartTime = DateTime.now();
              _startTimer();
            }
          }
        },
        onUserOffline: (connection, rUid, reason) {
          log('👥 Agora: Remote user offline: $rUid, Reason: $reason');
          if (mounted) {
            _remoteUids.remove(rUid);
            _remoteVideoMuted.remove(rUid);
            if (_remoteUids.isEmpty && !_isLeavingCall) {
              _leaveAndPop(emitCallEnd: true);
            }
          }
        },

        onRemoteVideoStateChanged: (connection, rUid, state, reason, elapsed) {
          log('📹 Agora: Remote video state changed for $rUid: $state, Reason: $reason');
          if (!mounted) return;
          final isMuted = state == RemoteVideoState.remoteVideoStateStopped ||
              state == RemoteVideoState.remoteVideoStateFrozen;
          if (isMuted) {
            _remoteVideoMuted.add(rUid);
          } else {
            _remoteVideoMuted.remove(rUid);
          }
        },

        onLocalVideoStateChanged: (source, state, error) {
          log('📹 Agora: Local video state changed: $state, Error: $error, Source: $source');
        },

        onConnectionStateChanged: (connection, state, reason) {
          log('🌐 Agora: Connection state: ${state.name}, Reason: ${reason.name}');
        },

        onError: (err, msg) {
          log('❌ Agora: Error: $err - $msg');
          if (err == ErrorCodeType.errInvalidToken || err == ErrorCodeType.errTokenExpired) {
            _refreshToken();
          }
        },
      ),
    );
  }

  Future<void> _refreshToken() async {
    final ok = await _callController.getToken(callId: widget.callId);
    if (ok) {
      _currentToken = _callController.token.value;
      await _engine?.renewToken(_currentToken);
    }
  }

  void _startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted || _isLeavingCall || _remoteUids.isEmpty) {
        timer.cancel();
        return;
      }
      final duration = DateTime.now().difference(_callStartTime!);
      final m = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
      final s = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
      durationString.value = '$m:$s';
    });
  }

  void _startNoAnswerTimer() {
    _noAnswerTimer = Timer(const Duration(seconds: 45), () {
      if (_remoteUids.isEmpty && mounted && !_isLeavingCall) {
        _leaveAndPop(emitCallEnd: true);
      }
    });
  }

  void _cancelNoAnswerTimer() => _noAnswerTimer?.cancel();

  Future<void> _playRingtone() async {
    try { await _player.play(AssetSource(AppAudio.ringtone)); } catch (_) {}
  }

  Future<void> _stopRingtone() async {
    try { await _player.stop(); } catch (_) {}
  }

  Future<void> _leaveAndPop({bool emitCallEnd = false}) async {
    if (_isLeavingCall) return;
    _isLeavingCall = true;
    _cancelNoAnswerTimer();
    _stopRingtone();

    if (emitCallEnd) {
      final duration = _callStartTime != null 
          ? DateTime.now().difference(_callStartTime!).inSeconds 
          : 0;
      
      log('📞 Ending call: ${widget.callId}, Duration: $duration');
      
      // Standard call-end signal
      callService.endCall(widget.callId, duration: duration);
      
      // Booking complete signal
      final bId = _callController.bookingId.value;
      if (bId.isNotEmpty) {
        callService.completeBooking(
          bookingId: bId,
          callId: widget.callId,
          duration: duration,
        );
      } else {
        log('⚠️ Cannot emit booking-complete: bookingId is empty');
      }
    }

    try { await _engine?.leaveChannel(); } catch (_) {}
    await CallPreference.clearPendingCall();
    if (mounted) {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      } else {
        // If we can't pop, we were likely launched directly into this page from a terminated state.
        // Navigate to splash screen to handle normal app flow/auth check.
        Get.offAllNamed(RoutesConstant.splashScreen);
      }
    }
  }

  @override
  void dispose() {
    _cancelNoAnswerTimer();
    _declinedWorker?.dispose();
    _endedWorker?.dispose();
    _participantInfoWorker?.dispose();
    _player.dispose();
    _engine?.leaveChannel();
    _engine?.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      body: Obx(() => Stack(
        children: [
          // Background - Remote Video or Avatar
          _buildMainVideoView(),

          // Top Info Bar
          _buildTopBar(),

          // Floating Local Video (WhatsApp Style Pip)
          if (localUserJoined.value) _buildFloatingLocalVideo(),

          // Fixed Bottom Control Bar
          _buildControlBar(),
        ],
      )),
    );
  }

  Widget _buildMainVideoView() {
    if (_remoteUids.isEmpty) {
      // Waiting screen - Show local video preview as background
      return Stack(
        children: [
          Positioned.fill(
            child: (_cameraEnabled.value && _engine != null)
                ? AgoraVideoView(
                    controller: VideoViewController(
                      rtcEngine: _engine!,
                      canvas: const VideoCanvas(uid: 0),
                    ),
                  )
                : Container(color: const Color(0xFF1C1C1E)), // Clean dark background
          ),
          _buildWaitingOverlay(),
        ],
      );
    }

    // Call connected - Show remote video full screen
    final remoteUid = _remoteUids[0];
    if (_remoteVideoMuted.contains(remoteUid)) {
      return _buildAvatarView(remoteUid, isFull: true);
    }

    if (_engine == null) {
      return _buildAvatarView(remoteUid, isFull: true);
    }

    return Positioned.fill(
      child: AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine!,
          canvas: VideoCanvas(uid: remoteUid),
          connection: RtcConnection(channelId: widget.channelName),
        ),
      ),
    );
  }

  Widget _buildWaitingOverlay() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withValues(alpha: 0.6),
            Colors.transparent,
            Colors.black.withValues(alpha: 0.6)
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!_cameraEnabled.value) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: DisplayNetworkImage(
                imageUrl: widget.photoUrl,
                imageHeight: 120,
                imageWidth: 120,
                radius: 60,
              ),
            ),
            const SizedBox(height: 24),
          ],
          CustomText(
            text: widget.isCaller ? 'Calling...' : 'Joining...',
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 8),
          CustomText(
            text: widget.isCaller ? 'Waiting for answer...' : 'Connecting to expert...',
            color: Colors.white70,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }


  Widget _buildFloatingLocalVideo() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 60,
      right: 16,
      child: Container(
        width: 110,
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],

          border: Border.all(color: Colors.white24, width: 1),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: (_cameraEnabled.value && _engine != null) 
              ? AgoraVideoView(
                  controller: VideoViewController(
                    rtcEngine: _engine!,
                    canvas: const VideoCanvas(uid: 0),
                  ),
                )
              : _buildAvatarView(0, isFull: false),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10, bottom: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black.withValues(alpha: 0.6), Colors.transparent],
          ),

        ),
        child: Column(
          children: [
            CustomText(
              text: widget.name,
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 4),
            CustomText(
              text: _remoteUids.isEmpty 
                  ? (widget.isCaller ? 'Calling...' : 'Joining...') 
                  : durationString.value,
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),



          ],
        ),
      ),
    );
  }

  Widget _buildControlBar() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + 20,
          top: 20,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black.withValues(alpha: 0.8), Colors.transparent],
          ),

        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _actionButton(
              icon: _speakerEnabled.value ? Icons.volume_up : Icons.volume_off,
              onPressed: () {
                _speakerEnabled.value = !_speakerEnabled.value;
                _engine?.setEnableSpeakerphone(_speakerEnabled.value);
              },
            ),
            _actionButton(
              icon: _cameraEnabled.value ? Icons.videocam : Icons.videocam_off,
              onPressed: () {
                _cameraEnabled.value = !_cameraEnabled.value;
                _engine?.muteLocalVideoStream(!_cameraEnabled.value);
              },
            ),
            _actionButton(
              icon: _micEnabled.value ? Icons.mic : Icons.mic_off,
              onPressed: () {
                _micEnabled.value = !_micEnabled.value;
                _engine?.muteLocalAudioStream(!_micEnabled.value);
              },
            ),

            _actionButton(
              icon: Icons.flip_camera_ios,
              onPressed: () => _engine?.switchCamera(),
            ),
            _actionButton(
              icon: Icons.call_end,
              color: Colors.red,
              onPressed: () => _leaveAndPop(emitCallEnd: true),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required VoidCallback onPressed,
    Color? color,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 54,
        width: 54,
        decoration: BoxDecoration(
          color: color ?? Colors.white.withValues(alpha: 0.2),
          shape: BoxShape.circle,
        ),

        child: Icon(icon, color: Colors.white, size: 28),
      ),
    );
  }


  Widget _buildAvatarView(int uid, {required bool isFull}) {
    final String name = uid == 0 ? 'Me' : _nameForUid(uid);
    final String image = uid == 0 ? (AuthPreference.cachedUserImage ?? '') : _imageForUid(uid);
    
    return Container(
      color: const Color(0xFF1C1C1E),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(isFull ? 60 : 30),
          child: image.isNotEmpty 
              ? DisplayNetworkImage(
                  imageUrl: image,
                  imageWidth: isFull ? 120 : 60,
                  imageHeight: isFull ? 120 : 60,
                  radius: isFull ? 60 : 30,
                  imageFit: BoxFit.cover,
                )
              : Container(
                  width: isFull ? 120 : 60,
                  height: isFull ? 120 : 60,
                  color: Colors.white12,
                  child: Center(
                    child: CustomText(
                      text: name.isNotEmpty ? name[0] : '?',
                      color: Colors.white,
                      fontSize: isFull ? 40 : 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
        ),
      ),
    );

  }

  String _nameForUid(int uid) => callService.participantInfo[uid]?['name'] ?? widget.name;
  String _imageForUid(int uid) => callService.participantInfo[uid]?['image'] ?? widget.photoUrl;
}
