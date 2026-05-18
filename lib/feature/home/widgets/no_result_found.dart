import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';

class NoResultFound extends StatelessWidget {
  const NoResultFound({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AppImages.noResult),
        CustomText(
          text: 'No results',
          color: AppColors.black,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: height * 0.01),
        CustomText(
          text: 'We couldn’t find what you’re\nlooking for, try another search',
          color: AppColors.darkGrey,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
