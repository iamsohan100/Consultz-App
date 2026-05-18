import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:flutter/material.dart';

class ConfirmDateTimeButton extends StatelessWidget {
  const ConfirmDateTimeButton({super.key, this.onTap, this.title});
final VoidCallback? onTap;
final String? title;
  @override
  Widget build(BuildContext context) {
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    return Container(
      padding: EdgeInsets.only(
        top: scaleFactor * 15,
        left: scaleFactor * 20,
        right: scaleFactor * 20,
        bottom: scaleFactor * 30,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            spreadRadius: 0.12,
            offset: Offset(0, -20),
          ),
        ],
      ),
      child: PrimaryButton(
        onPressed:onTap ,
        title:title?? 'Confirm',
      ),
    );
  }
}
