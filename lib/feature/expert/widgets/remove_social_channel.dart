import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/feature/expert/controller/update_social_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RemoveSocialChannel extends StatelessWidget {
  const RemoveSocialChannel( {super.key, required this.index});

  final int index;
  @override
  Widget build(BuildContext context) {
    // double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final updateSocialProfileController =
        Get.find<UpdateSocialProfileController>();
    return GestureDetector(
      behavior: .opaque,
      onTap: () {
        updateSocialProfileController.socialChannels.removeAt(index);
      },
      child: Container(
        width: scaleFactor * 40,
        height: scaleFactor * 40,
        margin: .only(top: 20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(scaleFactor * 8),
          boxShadow: [
            BoxShadow(
              color: AppColors.grey.withValues(alpha: 0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Icon(
          Icons.delete_forever,
          color: AppColors.darkGrey,
          size: scaleFactor * 20,
        ),
      ),
    );
  }
}
