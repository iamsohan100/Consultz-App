
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/feature/Auth/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GoogleAppleLogin extends StatelessWidget {
  final VoidCallback? onSocialLoginSuccess;
  const GoogleAppleLogin({super.key, this.onSocialLoginSuccess});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    return Column(
      children: [
        PrimaryButton(
          onPressed: () async {
            final isSuccess =
                await Get.find<LoginController>().googleLogin(context);
            if (isSuccess && onSocialLoginSuccess != null) {
              onSocialLoginSuccess!();
            }
          },
          title: 'Continue with Google',
          fontWeight: FontWeight.w400,
          icon: Image.asset(AppImages.google, width: scaleFactor * 16),
          textColor: AppColors.darkGrey,
          backgroundColor: AppColors.white,
          borderColor: AppColors.midGrey,
        ),
        SizedBox(height: height * 0.016),
        PrimaryButton(
          onPressed: () async {
            final isSuccess =
                await Get.find<LoginController>().appleLogin(context);
            if (isSuccess && onSocialLoginSuccess != null) {
              onSocialLoginSuccess!();
            }
          },
          title: 'Continue with Apple',
          textColor: AppColors.darkGrey,
          fontWeight: FontWeight.w400,
          icon: Image.asset(AppImages.apple, width: scaleFactor * 16),
          backgroundColor: AppColors.white,
          borderColor: AppColors.midGrey,
        ),

        SizedBox(height: height * 0.01),
      ],
    );
  }
}