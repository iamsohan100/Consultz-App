import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';

class NotAvailable extends StatelessWidget {
  const NotAvailable({
    super.key,
    required this.title,
    this.icon,
  });
  final String title;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    final height = Screen.screenHeight(context);
    final width = Screen.screenWidth(context);
    final scalefactor = width / Screen.designWidth;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: height * 0.01,
      children: [
        SizedBox(height: height * 0.2),
        Center(
          child: Icon(
            icon ?? Icons.do_not_disturb,
            color: AppColors.darkGrey,
            size: scalefactor * 40,
          ),
        ),
        CustomText(
          text: '$title ',
          color: AppColors.darkGrey,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}