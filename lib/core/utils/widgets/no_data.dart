import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  const NoData({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    // double width = Screen.screenWidth(context);
    // double scaleFactor = width / Screen.designWidth;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.02),
      child: Center(
        child: CustomText(
          text: text,
          color: AppColors.grey,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
