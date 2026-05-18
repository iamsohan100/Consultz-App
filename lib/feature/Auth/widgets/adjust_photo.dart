import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/feature/Auth/controller/upload_profile_picture_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdjustPhoto extends StatelessWidget {
  const AdjustPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    // double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final uploadProfilePictureController = Get.find<UploadProfilePictureController>();

    return Obx(() {
      if (uploadProfilePictureController.profileImge.value == null) {
        return SizedBox();
      }
      return AspectRatio(
        aspectRatio: 1,
        child: Container(
          padding: EdgeInsets.all(scaleFactor * 10),
          decoration: BoxDecoration(
            color: Color(0xFFF8F3FA).withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(scaleFactor * 8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(scaleFactor * 8),
            child: Image.file(
              uploadProfilePictureController.profileImge.value!,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    });
  }
}
