import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';

class DiscoverAiPower extends StatelessWidget {
  const DiscoverAiPower({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    unlockIcon() {
      return Transform.rotate(
        angle: 2.8,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: height * 0.003,
            horizontal: width * 0.02,
          ),
          decoration: BoxDecoration(
            color: Color(0xFFFFE8E8),
            borderRadius: BorderRadius.circular(scaleFactor * 33),
            border: Border.all(
              color: Color(0xFFFFBCBC).withValues(alpha: 0.68),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [Image.asset(AppImages.icon, width: scaleFactor * 14)],
          ),
        ),
      );
    }

    return Container(
      width: width,
      // height: 90,
      padding: EdgeInsets.all(scaleFactor * 20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(scaleFactor * 8),
        border: Border.all(color: Color(0xFFE6E8EC)),
      ),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Image.asset(AppImages.unlock, width: scaleFactor * 48),
              unlockIcon(),
            ],
          ),

          Container(
            margin: EdgeInsets.symmetric(horizontal: width * 0.03),
            width: width * 0.003,
            height: height * 0.07,
            color: AppColors.midGrey,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: height * 0.002,
              children: [
                CustomText(
                  text:
                      'Discover more Ai Powered profile insights by using Consultz Pointz',
                  color: AppColors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),

                CustomText(
                  text: 'Learn How',
                  color: AppColors.primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
