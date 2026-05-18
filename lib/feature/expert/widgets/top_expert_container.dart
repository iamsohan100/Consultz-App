import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_rich_text.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';

class TopExpertContainer extends StatelessWidget {
  const TopExpertContainer({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    return Container(
      width: width,

      padding: EdgeInsets.all(scaleFactor * 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(scaleFactor * 16),

        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.08),
            spreadRadius: 0.2,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        spacing: width * 0.04,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(AppImages.topExpert, width: scaleFactor * 58),

          Container(
            height: height * 0.08,
            width: width * 0.0027,
            color: AppColors.midGrey,
          ),
          Expanded(
            child: Column(
              spacing: height * 0.008,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Top Expert',
                  color: AppColors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                CustomRichText(
                  text1: 'This expert has been in the top ',
                  color1: AppColors.black,
                  fontSize1: 10,
                  fontWeight: FontWeight.w600,
                  text2: '5%',
                  color2: AppColors.primaryColor,
                  fontSize2: 10,
                  fontWeight2: FontWeight.w700,
                  text3: ' of experts for sessions completed',
                  fontWeight3: FontWeight.w600,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
