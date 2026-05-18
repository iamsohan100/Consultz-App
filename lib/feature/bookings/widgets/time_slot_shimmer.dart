import 'package:consultz/core/utils/loading.dart/shimmer_loading.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:flutter/material.dart';

class TimeSlotShimmer extends StatelessWidget {
  const TimeSlotShimmer({super.key, this.length = 3});
  final int length;

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < length; i++) ...[
          ShimmerLoading(
            height: height * 0.02,
            width: width * 0.2,
          ),
          SizedBox(height: height * 0.015),
          Wrap(
            spacing: width * 0.02,
            runSpacing: height * 0.02,
            children: List.generate(
              4,
              (index) => ShimmerLoading(
                height: height * 0.045,
                width: width * 0.2,
              ),
            ),
          ),
          if (i < length - 1) SizedBox(height: height * 0.02),
        ],
      ],
    );
  }
}
