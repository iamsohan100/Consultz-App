import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class OnbaordBackground extends StatelessWidget {
  const OnbaordBackground({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    // double scaleFactor = width / Screen.designWidth;
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Image.asset(AppImages.onboardBackground, width: width),
        Positioned(
          top: height * 0.06,
          right: width * 0.075,
          child: GestureDetector(
            onTap: () {
              Get.offNamed(RoutesConstant.signUpScreen);
            },
            child: CustomText(
              text: 'Skip',
              color: AppColors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        child,
      ],
    );
  }
}
