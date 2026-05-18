import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/controller/browse_first_controller.dart';

import 'package:consultz/feature/Auth/controller/upload_profile_picture_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompletedPart extends StatelessWidget {
  const CompletedPart({super.key});

  @override
  Widget build(BuildContext context) {
    final height = Screen.screenHeight(context);
    final width = Screen.screenWidth(context);
    final scaleFactor = width / Screen.designWidth;
    final browseFirstController = Get.find<BrowseFirstController>();
    final uploadProfilePictureController =
        Get.find<UploadProfilePictureController>();

    featureContainer({
      required String title,
      required String image,
      required bool isCompleted,
    }) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: height * 0.02),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border(bottom: BorderSide(color: AppColors.midGrey)),
        ),
        child: Row(
          spacing: width * 0.025,
          children: [
            SizedBox(),
            Image.asset(
              image,
              width: scaleFactor * 19,
              color: AppColors.darkGrey,
            ),
            SizedBox(),
            CustomText(
              text: title,
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            Spacer(),
            Container(
              height: scaleFactor * 24,
              width: scaleFactor * 24,
              decoration: BoxDecoration(
                color: isCompleted ? AppColors.black : AppColors.midGrey,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: isCompleted
                  ? Icon(
                      Icons.check_rounded,
                      color: AppColors.white,
                      size: scaleFactor * 15,
                    )
                  : null,
            ),
          ],
        ),
      );
    }

    return Obx(() {
      final expertData =
          uploadProfilePictureController.expertSetProfileModel.value.data;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (browseFirstController.isConsultee.value) ...[
            featureContainer(
              title: 'Profile picture',
              image: AppImages.person,
              isCompleted: true,
            ),
            featureContainer(
              title: 'Interests',
              image: AppImages.interests,
              isCompleted: false,
            ),
            featureContainer(
              title: 'Time zone',
              image: AppImages.timeZone,
              isCompleted: true,
            ),
            featureContainer(
              title: 'Price range',
              image: AppImages.priceRange,
              isCompleted: true,
            ),
            featureContainer(
              title: 'Learning style',
              image: AppImages.learningStyle,
              isCompleted: false,
            ),
          ] else ...[
            featureContainer(
              title: 'Profile picture',
              image: AppImages.person,
              isCompleted: (expertData?.photoUrl != null),
            ),

            featureContainer(
              title: 'Bio',
              image: AppImages.interests,
              isCompleted: false,
            ),
            featureContainer(
              title: 'Availability',
              image: AppImages.timeZone,
              isCompleted: false,
            ),
            featureContainer(
              title: 'Pricing',
              image: AppImages.priceRange,
              isCompleted: true,
            ),
            featureContainer(
              title: 'Social profile',
              image: AppImages.learningStyle,
              isCompleted:
                  (expertData != null && expertData.socialProfiles!.isNotEmpty),
            ),
          ],
        ],
      );
    });
  }
}
