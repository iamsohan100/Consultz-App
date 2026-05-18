import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';

class ExpertLevel extends StatelessWidget {
  const ExpertLevel({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: height * 0.01,
          child: LinearProgressIndicator(
            value: 0.75,
            backgroundColor: AppColors.warmGrey,
            color: AppColors.mutePink,
            borderRadius: BorderRadius.circular(scaleFactor * 46),
          ),
        ),
        SizedBox(height: height * 0.012),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: 'Lvl2',
              color: AppColors.darkGrey,
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
            CustomText(
              text: 'Complete 2 calls to reach lvl 3',
              color: Color(0xFF8C8C8C),
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
            CustomText(
              text: 'Lvl2',
              color: AppColors.darkGrey,
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
        SizedBox(height: height * 0.025),
      ],
    );
  }
}
