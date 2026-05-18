import 'package:consultz/core/utils/loading.dart/shimmer_loading.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:flutter/material.dart';

class DiscoverShimmer extends StatelessWidget {
  const DiscoverShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(3, (index) => _buildShimmerItem(height, width, scaleFactor)),
      ),
    );
  }

  Widget _buildShimmerItem(double height, double width, double scaleFactor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: scaleFactor * 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              // Profile row (avatar, name, time, follow button)
              Row(
                children: [
                  ShimmerLoading(
                    width: scaleFactor * 40,
                    height: scaleFactor * 40,
                    isCircle: true,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerLoading(
                        width: 120 * scaleFactor,
                        height: 14 * scaleFactor,
                      ),
                      const SizedBox(height: 6),
                      ShimmerLoading(
                        width: 60 * scaleFactor,
                        height: 10 * scaleFactor,
                      ),
                    ],
                  ),
                  const Spacer(),
                  ShimmerLoading(
                    width: 70 * scaleFactor,
                    height: 30 * scaleFactor,
                  ),
                ],
              ),

              // Description text
              SizedBox(height: height * 0.02),
              ShimmerLoading(width: width * 0.9, height: 12 * scaleFactor),
              const SizedBox(height: 8),
              ShimmerLoading(width: width * 0.7, height: 12 * scaleFactor),
            ],
          ),
        ),

        // Media box
        SizedBox(height: height * 0.02),
        ShimmerLoading(
          width: width,
          height: height * 0.25,
        ),

        SizedBox(height: height * 0.02),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: scaleFactor * 14),
          child: Row(
            children: [
              ShimmerLoading(
                width: 50 * scaleFactor,
                height: 20 * scaleFactor,
              ),
              const SizedBox(width: 16),
              ShimmerLoading(
                width: 50 * scaleFactor,
                height: 20 * scaleFactor,
              ),
            ],
          ),
        ),
        SizedBox(height: height * 0.015),
        const Divider(color: Color(0xFFE6E8EC)),
        SizedBox(height: height * 0.015),
      ],
    );
  }
}
