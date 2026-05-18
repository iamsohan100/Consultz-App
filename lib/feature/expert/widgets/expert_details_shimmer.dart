import 'package:consultz/core/utils/loading.dart/shimmer_loading.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:flutter/material.dart';

class ExpertDetailsShimmer extends StatelessWidget {
  const ExpertDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Cover Photo ──────────────────────────────────────────────
          ShimmerLoading(width: width, height: height * 0.22),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16 * scaleFactor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Avatar (overlaps cover) ───────────────────────────
                Transform.translate(
                  offset: Offset(0, -(40 * scaleFactor)),
                  child: ShimmerLoading(
                    width: 90 * scaleFactor,
                    height: 90 * scaleFactor,
                    isCircle: true,
                  ),
                ),

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
                SizedBox(height: height * 0.032),

                // ── Action buttons row ────────────────────────────────
                Row(
                  children: [
                    Expanded(child: ShimmerLoading(height: 36 * scaleFactor)),
                    SizedBox(width: width * 0.05),
                    Expanded(child: ShimmerLoading(height: 36 * scaleFactor)),
                  ],
                ),
                SizedBox(height: height * 0.03),

                // ── Section tab buttons ───────────────────────────────
                Row(
                  children: [
                    ShimmerLoading(
                      width: 80 * scaleFactor,
                      height: 32 * scaleFactor,
                    ),
                    SizedBox(width: 10 * scaleFactor),
                    ShimmerLoading(
                      width: 80 * scaleFactor,
                      height: 32 * scaleFactor,
                    ),
                    SizedBox(width: 10 * scaleFactor),
                    ShimmerLoading(
                      width: 80 * scaleFactor,
                      height: 32 * scaleFactor,
                    ),
                  ],
                ),
                SizedBox(height: height * 0.05),
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
                SizedBox(height: height * 0.027),

                // ── Action buttons row ────────────────────────────────
                Row(
                  children: [
                    Expanded(child: ShimmerLoading(height: 36 * scaleFactor)),
                    SizedBox(width: width * 0.05),
                    Expanded(child: ShimmerLoading(height: 36 * scaleFactor)),
                  ],
                ),
                SizedBox(height: height * 0.03),

                // ── Section tab buttons ───────────────────────────────
                Row(
                  children: [
                    ShimmerLoading(
                      width: 80 * scaleFactor,
                      height: 32 * scaleFactor,
                    ),
                    SizedBox(width: 10 * scaleFactor),
                    ShimmerLoading(
                      width: 80 * scaleFactor,
                      height: 32 * scaleFactor,
                    ),
                    SizedBox(width: 10 * scaleFactor),
                    ShimmerLoading(
                      width: 80 * scaleFactor,
                      height: 32 * scaleFactor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
