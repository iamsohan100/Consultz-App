import 'package:consultz/core/utils/loading.dart/shimmer_loading.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:flutter/material.dart';

class ReviewShimmer extends StatelessWidget {
  const ReviewShimmer({super.key, this.length});
final int? length;
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: height * 0.035,
        children: [
          for (int i = 0; i < (length ?? 2); i++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Name ─────────────────────────────────────────────
                ShimmerLoading(
                  width: 180 * scaleFactor,
                  height: 18 * scaleFactor,
                ),
                SizedBox(height: height * 0.014),

                // ── Title / Tagline ───────────────────────────────────
                ShimmerLoading(width: width, height: 14 * scaleFactor),
                SizedBox(height: height * 0.01),
                ShimmerLoading(
                  width: 220 * scaleFactor,
                  height: 14 * scaleFactor,
                ),
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
              ],
            ),
        ],
      ),
    );
  }
}
