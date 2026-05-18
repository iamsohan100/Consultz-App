import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';

class ExpertRatingContainer extends StatelessWidget {
  const ExpertRatingContainer({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width * 0.25,
        margin: EdgeInsets.only(left: scaleFactor * 14, right: scaleFactor * 2),
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.025,
          vertical: height * 0.01,
        ),
        decoration: BoxDecoration(
          color: AppColors.warmGrey,
          borderRadius: BorderRadius.circular(scaleFactor * 8),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : Colors.transparent,
          ),
        ),
        child: Row(
          spacing: width * 0.01,
          children: [
            Icon(
              Icons.star_rounded,
              size: scaleFactor * 20,
              color: AppColors.warmYellow,
            ),
            CustomText(
              text: "$title stars",
              color: AppColors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}
