import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/feature/Auth/controller/upload_profile_picture_controller.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/widgets/adjust_photo.dart';
import 'package:consultz/feature/Auth/widgets/chose_image_option_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadProfilePictureScreen extends StatelessWidget {
  const UploadProfilePictureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final uploadProfilePictureController =
        Get.find<UploadProfilePictureController>();
    return Scaffold(
      appBar: customAppBar(title: '', context: context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SafeArea(
        bottom: true,
        top: false,
        left: false,
        right: false,
        child: Padding(
          padding: EdgeInsets.all(scaleFactor * 20),
          child: Row(
            spacing: width * 0.04,
            children: [
              Expanded(
                child: PrimaryButton(
                  onPressed: () async {
                    final response = await uploadProfilePictureController
                        .updateProfile(context);
                    if (response) {
                      Get.toNamed(RoutesConstant.profileSoFarScreen);
                    }
                  },
                  title: 'Skip for now',
                  backgroundColor: AppColors.white,
                  borderColor: AppColors.primaryColor,
                  textColor: AppColors.primaryColor,
                ),
              ),
              Expanded(
                child: PrimaryButton(
                  onPressed: () => continu(context),
                  title: 'Continue', //Upload an image
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.only(
              top: scaleFactor * 8,
              left: scaleFactor * 20,
              right: scaleFactor * 20,
              bottom: scaleFactor * 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: height * 0.01,
              children: [
                CustomText(
                  text: 'Upload a profile picture',
                  color: AppColors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                CustomText(
                  text: 'A line of copy about how an image will be beneficial.',
                  color: AppColors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  lineHeight: 1.6,
                ),
                SizedBox(height: height * 0.005),
                ChoseImageOptionContainer(),
                SizedBox(height: height * 0.005),
                AdjustPhoto(),
                SizedBox(height: height * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> continu(BuildContext context) async {
  final uploadProfilePictureController =
      Get.find<UploadProfilePictureController>();
  if (uploadProfilePictureController.profileImge.value == null) {
    bottomMessage(msg: "Please select your profile picture");
    return;
  }
  final response = await uploadProfilePictureController.updateProfile(context);
  if (response) {
    Get.toNamed(RoutesConstant.profileSoFarScreen);
  }
}
