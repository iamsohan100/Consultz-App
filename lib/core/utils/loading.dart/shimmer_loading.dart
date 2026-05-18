import 'package:consultz/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({
    super.key,
    this.height,
    this.width,
    this.isCircle,
    this.color,
  });

  final double? height;
  final double? width;
  final bool? isCircle;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: AppColors.primaryColor.withValues(alpha: 0.05),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: isCircle == true ? null : BorderRadius.circular(5),
          shape: isCircle == true ? BoxShape.circle : BoxShape.rectangle,
        ),
      ),
    );
  }
}
