import 'package:consultz/core/utils/loading.dart/shimmer_loading.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:flutter/material.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    return Padding(
      padding: EdgeInsets.all(scaleFactor * 10),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          SizedBox(
            height: height * 0.2,
            child: ListView.separated(
              scrollDirection: .horizontal,
              itemCount: 2,

              itemBuilder: (_, _) {
                return ShimmerLoading(width: width * 0.65);
              },
              separatorBuilder: (_, _) => SizedBox(width: width * 0.025),
            ),
          ),
          SizedBox(height: height * 0.02),
          ShimmerLoading(width: width, height: 14 * scaleFactor),
          SizedBox(height: height * 0.01),
          ShimmerLoading(width: 220 * scaleFactor, height: 14 * scaleFactor),
          SizedBox(height: height * 0.014),

          // ── Location + followers row ──────────────────────────
          Row(
            children: [
              ShimmerLoading(
                width: 100 * scaleFactor,
                height: 12 * scaleFactor,
              ),
              SizedBox(width: 16 * scaleFactor),
              ShimmerLoading(
                width: 130 * scaleFactor,
                height: 12 * scaleFactor,
              ),
            ],
          ),
          SizedBox(height: height * 0.025),

          // ── Action buttons row ────────────────────────────────
          Row(
            children: [
              Expanded(child: ShimmerLoading(height: 36 * scaleFactor)),
              SizedBox(width: width * 0.05),
              Expanded(child: ShimmerLoading(height: 36 * scaleFactor)),
            ],
          ),
        ],
      ),
    );
  }
}
