import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';

class DebitCreditCard extends StatelessWidget {
  const DebitCreditCard({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    return Container(
      width: width,

      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.012,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(scaleFactor * 14),
        border: Border.all(color: AppColors.midGrey),
      ),
      alignment: Alignment.center,
      child: Row(
        children: [
          Image.asset(AppImages.card, width: scaleFactor * 19),
          SizedBox(width: width * 0.03),
          CustomText(
            text: 'Debit / credit card',
            color: AppColors.black,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          Spacer(),
          Container(
            width: scaleFactor * 18,
            height: scaleFactor * 18,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Container(
              width: scaleFactor * 14,
              height: scaleFactor * 14,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
                border: Border.all(width: 2, color: AppColors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
