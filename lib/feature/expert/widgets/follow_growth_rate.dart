import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FollowGrowthRate extends StatelessWidget {
  const FollowGrowthRate({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final profileController = Get.find<ProfileController>();

    return Obx(() {
      final expertProfile = profileController.expertProfileModel.value.data;

      return Container(
        width: width,

        margin: EdgeInsets.only(top: height * 0.02),
        padding: EdgeInsets.all(scaleFactor * 12),
        decoration: BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(scaleFactor * 8),
        ),
        child: Row(
          children: [
            CustomText(
              text: 'Follower count growth rate',
              color: AppColors.darkGrey,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            Spacer(),
            CustomText(
              text: '${expertProfile?.followerGrowthRate ?? 0}%',
              color: AppColors.darkGrey,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(width: width * 0.02),
            Image.asset(AppImages.arrowCurve, width: scaleFactor * 12),
            SizedBox(width: width * 0.02),
            CustomText(
              text: '7d',
              color: AppColors.grey,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
      );
    });
  }
}
