import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';

class InterestValueContainer extends StatelessWidget {
  const InterestValueContainer({
    super.key,
    required this.title,
    this.index,
    this.isFilter,
    this.onTap,
    this.isSelected,
    this.onRemove,
  });
  final String title;
  final int? index;
  final bool? isFilter;
  final VoidCallback? onTap;
  final bool? isSelected;
  final VoidCallback? onRemove;
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: isFilter == true
            ? EdgeInsets.only(
                left: index == 0 ? scaleFactor * 14 : 0,
                right: scaleFactor * 8,
              )
            : null,
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.035,
          vertical: height * 0.006,
        ),
        decoration: BoxDecoration(
          color: AppColors.warmGrey,
          borderRadius: BorderRadius.circular(scaleFactor * 8),
          border: Border.all(
            color: (isSelected ?? false)
                ? AppColors.primaryColor
                : Colors.transparent,
          ),
        ),
        alignment: isFilter == true ? Alignment.center : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              text: title,
              color: AppColors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            if (onRemove != null) ...[
              SizedBox(width: width * 0.02),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onRemove,
                child: Icon(
                  Icons.close,
                  size: scaleFactor * 14,
                  color: AppColors.darkGrey,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
