import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/image/display_network_image.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/controller/browse_first_controller.dart';
import 'package:consultz/feature/Auth/controller/upload_profile_picture_controller.dart';
import 'package:consultz/feature/Auth/widgets/progress_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileCompletationProgress extends StatelessWidget {
  ProfileCompletationProgress({super.key});
  final browseFirstController = Get.find<BrowseFirstController>();
  final uploadProfilePictureController =
      Get.find<UploadProfilePictureController>();
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    return Obx(() {
      final expertData =
          uploadProfilePictureController.expertSetProfileModel.value.data;
      return Row(
        spacing: width * 0.035,
        children: [
          Stack(
            // fit: StackFit.expand,
            children: [
              Container(
                height: scaleFactor * 70,
                width: scaleFactor * 70,
                alignment: Alignment.center,
                child: CustomPaint(
                  painter: ProgressBorder(
                    progress: expertData?.profileSetupProgress / 100,
                  ),
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    height: scaleFactor * 56,
                    width: scaleFactor * 56,
                    alignment: Alignment.center,

                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: (expertData?.photoUrl != null)
                        ? DisplayNetworkImage(
                            imageUrl: expertData?.photoUrl,
                            imageWidth: scaleFactor * 56,
                            imageHeight: scaleFactor * 56,
                            imageFit: .cover,
                          )
                        : Image.asset(AppImages.profileImage),
                  ),
                ),
              ),
              completedPercent(width, height, scaleFactor),
              editProfilePhoto(width, height, scaleFactor),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text:
                    "${expertData?.firstName ?? 'Sam'} ${expertData?.lastName ?? 'Jones'}",
                color: AppColors.black,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
              CustomText(
                text:
                    'Profile ${expertData?.profileSetupProgress?.toString() ?? 0}% complete',
                color: AppColors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              // CustomText(
              //   text: 'Signed up 2mins ago',
              //   color: AppColors.darkGrey,
              //   fontSize: 12,
              //   fontWeight: FontWeight.w500,
              //   lineHeight: 1.6,
              // ),
            ],
          ),
        ],
      );
    });
  }
}

Positioned completedPercent(double width, double height, double scaleFactor) {
  final uploadProfilePictureController =
      Get.find<UploadProfilePictureController>();

  return Positioned(
    bottom: 0,
    right: width * 0.03,
    child: Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.022,
        vertical: height * 0.0027,
      ),
      decoration: BoxDecoration(
        color: Color(0xFF333333),
        borderRadius: BorderRadius.circular(scaleFactor * 40),
        border: Border.all(color: AppColors.white, width: 2),
      ),
      alignment: Alignment.center,
      child: Obx(() {
        final expertData =
            uploadProfilePictureController.expertSetProfileModel.value.data;
        return CustomText(
          text: "${expertData?.profileSetupProgress?.toString() ?? 0}%",
          color: AppColors.white,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        );
      }),
    ),
  );
}

Positioned editProfilePhoto(double width, double height, double scaleFactor) {
  return Positioned(
    top: height * 0.003,
    right: width * 0.015,
    child: Container(
      padding: EdgeInsets.all(scaleFactor * 4),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(scaleFactor * 40),
      ),
      alignment: Alignment.center,
      child: Icon(
        Icons.camera_alt_rounded,
        color: AppColors.white,
        size: scaleFactor * 12,
      ),
    ),
  );
}
