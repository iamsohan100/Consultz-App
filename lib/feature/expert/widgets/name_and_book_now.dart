import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:consultz/feature/expert/controller/expert_profile_controller.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NameAndBookNow extends StatelessWidget {
  const NameAndBookNow({super.key, this.isProfile});
  final bool? isProfile;
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final profileController = Get.find<ProfileController>();
    final expertProfileController = Get.find<ExpertProfileController>();

    return Expanded(
      child: Obx(() {
        final profileData = profileController.expertProfileModel.value.data;
        final expertProfileData =
            expertProfileController.expertProfileModel.value.data;

        final activeData = isProfile == true ? profileData : expertProfileData;

        return Column(
          spacing: height * 0.004,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: width * 0.01,
              children: [
                Flexible(
                  child: CustomText(
                    text:
                        "${activeData?.firstName ?? ''} ${activeData?.lastName ?? ''}",
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    lineHeight: 1.2,
                  ),
                ),
                Container(
                  height: scaleFactor * 6,
                  width: scaleFactor * 6,
                  decoration: BoxDecoration(
                    color: AppColors.midGrey,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            if (isProfile == true)
              Row(
                spacing: width * 0.015,
                children: [
                  CustomText(
                    text: 'Dashboard',
                    color: AppColors.darkGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    textDecoration: TextDecoration.underline,
                    textDecorationColor: AppColors.darkGrey,
                  ),
                  Image.asset(AppImages.arrow, width: scaleFactor * 9),
                ],
              )
            else
              PrimaryButton(
                onPressed: () {
                  Get.toNamed(
                    RoutesConstant.selectSessionScreen,
                    arguments: activeData?.sId,
                  );
                },
                title: 'Book now',
                fontSize: 12,
                buttonWidth: width * 0.22,
                buttonHeight: height * 0.037,
                radius: 8,
              ),
          ],
        );
      }),
    );
  }
}
