import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/image/display_network_image.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:consultz/feature/expert/controller/expert_profile_controller.dart';
import 'package:consultz/feature/main/controller/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpertCoverPhoto extends StatelessWidget {
  const ExpertCoverPhoto({super.key, this.isProfile});
  final bool? isProfile;
  @override
  Widget build(BuildContext context) {
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final profileController = Get.find<ProfileController>();
    final expertProfileController = Get.find<ExpertProfileController>();
    return Obx(() {
      final profileData = profileController.expertProfileModel.value.data;
      final expertProfileData =
          expertProfileController.expertProfileModel.value.data;
      return Stack(
        alignment: Alignment.topLeft,
        children: [
          AspectRatio(
            aspectRatio: 16 / 6,
            child: DisplayNetworkImage(
              imageUrl: isProfile == true
                  ? profileData?.coverPhoto
                  : expertProfileData?.coverPhoto,
              imageFit: .cover,
              imageSize: width,
            ),
          ),
          SafeArea(
            child: GestureDetector(
              onTap: () {
                if (isProfile == true) {
                  Get.find<MainController>().changeIndex(index: 0);
                } else {
                  Navigator.pop(context);
                }
              },
              child: Container(
                padding: .only(
                  left: scaleFactor * 4,
                  right: scaleFactor * 6,
                  top: scaleFactor * 4,
                  bottom: scaleFactor * 4,
                ),
                margin: .only(left: scaleFactor * 10),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: AppColors.black,
                  size: scaleFactor * 20,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
