import 'package:consultz/core/utils/loading.dart/shimmer_loading.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:flutter/material.dart';

class NotificationShimmer extends StatelessWidget {
  const NotificationShimmer({super.key, this.length});
  final int? length;

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: length ?? 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: scaleFactor * 14,
            vertical: height * 0.008,
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon Box Shimmer
                  ShimmerLoading(
                    width: scaleFactor * 50,
                    height: scaleFactor * 50,
                  ),
                  SizedBox(width: width * 0.04),
                  // Text Content Shimmer
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        ShimmerLoading(
                          width: width * 0.4,
                          height: 12 * scaleFactor,
                        ),
                        SizedBox(height: height * 0.006),
                        // Description line 1
                        ShimmerLoading(
                          width: width * 0.6,
                          height: 10 * scaleFactor,
                        ),
                        SizedBox(height: height * 0.004),
                        // Description line 2
                        ShimmerLoading(
                          width: width * 0.3,
                          height: 10 * scaleFactor,
                        ),
                        SizedBox(height: height * 0.006),
                        // Time
                        ShimmerLoading(
                          width: width * 0.2,
                          height: 8 * scaleFactor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.006),
              const Divider(color: Color(0xFFE5E5E5)),
            ],
          ),
        );
      },
    );
  }
}
