import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';

class BookingDetailContainer extends StatelessWidget {
  const BookingDetailContainer({
    super.key,
    required this.title,
    required this.titleColor,
    required this.subtitle,
    required this.child,
  });
  final String title;
  final Color titleColor;
  final String subtitle;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    return Container(
      width: width,
      height: height * 0.12,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(scaleFactor * 8),
        border: Border.all(color: AppColors.midGrey, width: 0.8),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.green.withValues(alpha: 0.2),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(scaleFactor * 10),
                bottomLeft: Radius.circular(scaleFactor * 10),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(scaleFactor * 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: title,
                  color: titleColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                CustomText(
                  text: subtitle,
                  color: AppColors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                child,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
