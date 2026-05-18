import 'package:consultz/core/utils/loading.dart/shimmer_loading.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:flutter/material.dart';

class BookingShimmer extends StatelessWidget {
  const BookingShimmer({super.key, this.length});
  final int? length;

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: scaleFactor * 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < (length ?? 10); i++)
              Padding(
                padding: EdgeInsets.only(bottom: height * 0.02),
                child: Row(
                  children: [
                    // Icon placeholder
                    ShimmerLoading(
                      width: scaleFactor * 26,
                      height: scaleFactor * 26,
                      isCircle: true,
                    ),
                    SizedBox(width: width * 0.04),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Name and session type
                          ShimmerLoading(
                            width: width * 0.5,
                            height: 14 * scaleFactor,
                          ),
                          SizedBox(height: height * 0.008),
                          // Amount
                          ShimmerLoading(
                            width: width * 0.2,
                            height: 12 * scaleFactor,
                          ),
                          SizedBox(height: height * 0.005),
                          // Status message
                          ShimmerLoading(
                            width: width * 0.4,
                            height: 12 * scaleFactor,
                          ),
                        ],
                      ),
                    ),
                    // Arrow placeholder
                    ShimmerLoading(
                      width: scaleFactor * 16,
                      height: scaleFactor * 16,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
