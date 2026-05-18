import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectTimeContainer extends StatelessWidget {
  const SelectTimeContainer({
    super.key,
    required this.title,

    this.isUnavailable,
    required this.isSelected,
  });
  final String title;
  final RxBool isSelected;
  final bool? isUnavailable;
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    return Obx(() {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.035,
          vertical: height * 0.01,
        ),
        decoration: BoxDecoration(
          color: isUnavailable == true
              ? AppColors.midGrey
              : isSelected.value
              ? AppColors.primaryColor
              : AppColors.warmGrey,
          borderRadius: BorderRadius.circular(scaleFactor * 4),
        ),

        child: CustomText(
          text: title,
          color: isSelected.value ? AppColors.white : AppColors.darkGrey,
          fontSize: 12,
          fontWeight: FontWeight.w200,
        ),
      );
    });
  }
}
