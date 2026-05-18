import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/feature/bookings/model/session_data.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_rich_text.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SessionContainer extends StatelessWidget {
  const SessionContainer({
    super.key,
    required this.sessionModel,
    required this.isSelected,
  });
  final SessionModel sessionModel;
  final RxBool isSelected;

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    return Obx(() {
      return Container(
        width: width,

        padding: EdgeInsets.symmetric(
          horizontal: scaleFactor * 14,
          vertical: scaleFactor * 10,
        ),
        margin: EdgeInsets.symmetric(horizontal: width * 0.005),
        decoration: BoxDecoration(
          color: isSelected.value ? AppColors.warmGrey : AppColors.white,
          borderRadius: BorderRadius.circular(scaleFactor * 8),
          border: Border.all(
            color: isSelected.value
                ? AppColors.primaryColor
                : Colors.transparent,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.1),
              spreadRadius: 0.8,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: height * 0.003,
          children: [
            CustomText(
              text: sessionModel.title,
              color: AppColors.black,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                  text: '${sessionModel.duration} Minutes',
                  color: AppColors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                CustomRichText(
                  text1: '・ ',
                  color1: AppColors.grey,
                  fontSize1: 12,
                  fontWeight: FontWeight.w400,
                  text2: sessionModel.amount,
                  color2: AppColors.primaryColor,
                  fontSize2: 12,
                  fontWeight2: FontWeight.w400,
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
