import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';

class CallDuration extends StatelessWidget {
  const CallDuration({super.key});

  @override
  Widget build(BuildContext context) {
    // double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    return Row(
      spacing: width * 0.02,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.white,
            size: scaleFactor * 20,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'Discussion with Kim',
              color: AppColors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
            CustomText(
              text: '00:02',
              color: AppColors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              lineHeight: 1.5,
            ),
          ],
        ),
      ],
    );
  }
}
