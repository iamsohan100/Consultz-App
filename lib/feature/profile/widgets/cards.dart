import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:flutter/material.dart';

class Cards extends StatelessWidget {
  const Cards({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final List<String> cards = [
      AppImages.masterCard,
      AppImages.visa,
      AppImages.americanExpress,
    ];
    return Row(
      spacing: width * 0.02,
      children: [
        for (int i = 0; i < cards.length; i++)
          Container(
            height: height * 0.035,
            width: width * 0.11,
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.02,
              vertical: height * 0.01,
            ),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: AppColors.grey),
              borderRadius: BorderRadius.circular(scaleFactor * 4),
            ),
            child: Image.asset(
              cards[i],
              width: scaleFactor * 22,
              fit: BoxFit.contain,
            ),
          ),
      ],
    );
  }
}
