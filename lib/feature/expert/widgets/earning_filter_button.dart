import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EarningFilterButton extends StatelessWidget {
  const EarningFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    RxBool isAug = false.obs;
    RxBool isSep = true.obs;
    return Padding(
      padding: EdgeInsets.only(
        left: scaleFactor * 14,
        right: scaleFactor * 14,
        top: scaleFactor * 8,
      ),
      child: Obx(() {
        return Row(
          spacing: width * 0.03,
          children: [
            PrimaryButton(
              onPressed: () {
                isAug.value = true;
                isSep.value = false;
              },
              title: 'Aug 2024',
              buttonWidth: width * 0.25,
              buttonHeight: height * 0.04,
              fontSize: 12,
              textColor: isAug.value
                  ? AppColors.primaryColor
                  : AppColors.darkGrey,
              fontWeight: FontWeight.w400,
              radius: 4,
              backgroundColor: isAug.value
                  ? AppColors.warmGrey
                  : Color(0xFFF8F8F8),
              borderColor: isAug.value
                  ? AppColors.primaryColor.withValues(alpha: 0.3)
                  : null,
            ),
            PrimaryButton(
              onPressed: () {
                isAug.value = false;
                isSep.value = true;
              },
              title: 'Sep 2024',
              buttonWidth: width * 0.25,
              buttonHeight: height * 0.04,
              fontSize: 12,
              textColor: isSep.value
                  ? AppColors.primaryColor
                  : AppColors.darkGrey,
              fontWeight: FontWeight.w400,
              radius: 4,
              backgroundColor: isSep.value
                  ? AppColors.warmGrey
                  : Color(0xFFF8F8F8),
              borderColor: isSep.value
                  ? AppColors.primaryColor.withValues(alpha: 0.3)
                  : null,
            ),
          ],
        );
      }),
    );
  }
}
