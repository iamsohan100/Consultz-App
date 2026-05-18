import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:flutter/material.dart';

class AddSocialChannel extends StatelessWidget {
  const AddSocialChannel({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    return Container(
      width: width * 0.1,
      height: height * 0.044,
      padding: EdgeInsets.all(scaleFactor * 4),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(scaleFactor * 10),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withValues(alpha: 0.08),
            blurRadius: 10,
            spreadRadius: 0.5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      alignment: Alignment.center,

      child: Icon(Icons.add, size: scaleFactor * 25, color: AppColors.darkGrey),
    );
  }
}
