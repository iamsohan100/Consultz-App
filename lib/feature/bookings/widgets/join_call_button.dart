
import 'package:camera/camera.dart';
import 'package:consultz/feature/bookings/controller/socket_service_controller.dart';
import 'package:consultz/feature/call/controller/call_controller.dart';
import 'package:consultz/feature/call/controller/call_service_controller.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JoinCallButton extends StatefulWidget {
  const JoinCallButton({
    super.key,
    required this.name,
    required this.receiverUserId,
    required this.image,
    required this.bookingId,
  });
  final String name;
  final String image;
  final String receiverUserId;
  final String bookingId;
  @override
  State<JoinCallButton> createState() => _JoinCallButtonState();
}

class _JoinCallButtonState extends State<JoinCallButton> {
  List<CameraDescription>? cameras;
  final callController = CallController();
  final socketService = Get.find<SocketServiceController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeCamera();
    });
  }

  Future<void> _initializeCamera() async {
    final availableCamerasList = await availableCameras();
    setState(() {
      cameras = availableCamerasList;
    });
  }

  void startCall() async {
    final callServiceController = Get.find<CallServiceController>();
    callServiceController.startCall(bookingId: widget.bookingId, isVideo: true);
  }

  @override
  Widget build(BuildContext context) {
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    return Container(
      padding: EdgeInsets.only(
        top: scaleFactor * 15,
        left: scaleFactor * 20,
        right: scaleFactor * 20,
        bottom: scaleFactor * 30,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            spreadRadius: 0.12,
            offset: Offset(0, -20),
          ),
        ],
      ),
      child: PrimaryButton(
        onPressed: () {
          startCall();
        },
        padding: 0.1,
        title: 'Join call with ${widget.name}',
      ),
    );
  }
}
