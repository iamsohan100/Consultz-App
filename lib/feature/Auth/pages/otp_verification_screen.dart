import 'package:consultz/feature/Auth/controller/sign_up_controller.dart';
import 'package:consultz/feature/Auth/widgets/resend_otp.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/widgets/filling_steps.dart';
import 'package:consultz/feature/Auth/widgets/mobile_verification_progress_container.dart';
import 'package:consultz/feature/Auth/widgets/otp_field.dart';
import 'package:consultz/feature/Auth/controller/browse_first_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final signUpController = Get.find<SignUpController>();

    return Scaffold(
      appBar: customAppBar(title: '', context: context),

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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: height * 0.016,
              children: [
                FillingSteps(currentScreen: 1),
                SizedBox(),
                MobileVerificationProgressContainer(
                  progress: 0.47,
                  image: AppImages.verifyYou,
                  imageSize: 30,
                ),
                SizedBox(),
                CustomText(
                  text: "Verify it’s you",
                  color: AppColors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.center,
                ),
                CustomText(
                  text:
                      'Please enter 4 digit verification code that have been sent to your mobile phone\n${signUpController.initCountryCode.value}${signUpController.phoneNumberController.text}',
                  color: AppColors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.center,
                  lineHeight: 1.6,
                ),
                SizedBox(height: height * 0.01),

                OtpField(
                  isOtpComplete: signUpController.isOtpComplete,
                  otp: signUpController.otp,
                ),

                ResendOtp(
                  isSignUp: true,
                  phone:
                      "${signUpController.initCountryCode.value}${signUpController.phoneNumberController.text}",
                ),
                SizedBox(height: height * 0.02),
                Obx(() {
                  return PrimaryButton(
                    onPressed: () {
                      verify(context);
                    },
                    title: 'Verify',
                    backgroundColor: signUpController.isOtpComplete.value
                        ? null
                        : AppColors.primaryColor.withValues(alpha: 0.4),
                  );
                }),
                SizedBox(height: height * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> verify(BuildContext context) async {
  final signUpController = Get.find<SignUpController>();

  final browseFirstController = Get.find<BrowseFirstController>();
  if (!signUpController.isOtpComplete.value) {
    return;
  }
  final response = await signUpController.verifySignUpOtp(context);
  if (response) {
    if (browseFirstController.isConsultee.value) {
      Get.toNamed(RoutesConstant.timeZoneScreen);
    } else {
      Get.offNamed(RoutesConstant.socialProfileScreen);
    }
  }
}
