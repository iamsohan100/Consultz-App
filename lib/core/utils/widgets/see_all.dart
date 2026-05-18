import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';

class SeeAll extends StatelessWidget {
  const SeeAll({
    super.key,
    required this.title,
    this.onTap,
    this.isLoading,
    this.isFilter,
  });
  final String title;
  final bool? isLoading;
  final VoidCallback? onTap;
  final bool? isFilter;
  @override
  Widget build(BuildContext context) {
    // final height = Screen.screenHeight(context);
    final width = Screen.screenWidth(context);
    final scaleFactor = width / Screen.designWidth;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomText(
            text: title,
            color: AppColors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          // if (isLoading == true)
          //   ShimmerLoading(
          //     shimmerHeight: height * 0.018,
          //     shimmerWidth: width * 0.1,
          //   )
          // else
          Icon(
            isFilter == true
                ? Icons.arrow_forward_ios_rounded
                : Icons.arrow_forward_rounded,
            color: AppColors.black,
            size: isFilter == true ? scaleFactor * 17 : scaleFactor * 20,
          ),
        ],
      ),
    );
  }
}
