import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/text/custom_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HaveAccount extends StatelessWidget {
  const HaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    // double height = Screen.screenHeight(context);
    // double width = Screen.screenWidth(context);
    // double scaleFactor = width / Screen.designWidth;
    return GestureDetector(
      onTap: () {
        Get.toNamed(RoutesConstant.loginScreen);
      },
      child: CustomRichText(
        text1: 'I already have an account, ',
        text2: 'log in.',
        color1: AppColors.darkGrey,
        color2: AppColors.primaryColor,
        fontSize1: 14,
        fontSize2: 14,
        fontWeight: FontWeight.w400,
        fontWeight2: FontWeight.w500,
      ),
    );
  }
}
