import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    // double height = Screen.screenHeight(context);
    // double width = Screen.screenWidth(context);
    // double scaleFactor = width / Screen.designWidth;
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          Get.toNamed(RoutesConstant.forgetPasswordScreen);
        },
        child: CustomText(
          text: 'Forgot Password',
          color: AppColors.primaryColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
