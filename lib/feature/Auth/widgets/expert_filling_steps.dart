import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';

class ExpertFillingSteps extends StatelessWidget {
  final int currentScreen;
  const ExpertFillingSteps({super.key, required this.currentScreen});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (int i = 1; i < 4; i++)
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: height * 0.008,
            children: [
              Container(
                height: scaleFactor * 8,
                width: scaleFactor * 8,
                decoration: BoxDecoration(
                  color: currentScreen >= i ? AppColors.black : AppColors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: currentScreen != i
                        ? AppColors.black
                        : Colors.transparent,
                  ),
                ),
              ),
              CustomText(
                text: i == 1
                    ? 'Time Zone'
                    : i == 2
                    ? 'Schedule'
                    : 'Calendar',

                color: AppColors.black,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
      ],
    );
  }
}
