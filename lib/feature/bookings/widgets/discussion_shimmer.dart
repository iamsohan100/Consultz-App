import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/loading.dart/shimmer_loading.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:flutter/material.dart';

class DiscussionShimmer extends StatelessWidget {
  const DiscussionShimmer({super.key, this.length});
  final int? length;

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    return Column(
      children: [
        for (int i = 0; i < (length ?? 4); i++)
          Container(
            width: width,
            padding: EdgeInsets.symmetric(
              horizontal: scaleFactor * 14,
              vertical: scaleFactor * 10,
            ),
            margin: EdgeInsets.only(
              left: width * 0.005,
              right: width * 0.005,
              bottom: height * 0.02,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(scaleFactor * 8),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.1),
                  spreadRadius: 0.8,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerLoading(
                            width: width * 0.3,
                            height: 14 * scaleFactor,
                          ),
                          SizedBox(height: height * 0.005),
                          ShimmerLoading(
                            width: width * 0.2,
                            height: 12 * scaleFactor,
                          ),
                        ],
                      ),
                    ),
                    ShimmerLoading(
                      width: scaleFactor * 60,
                      height: scaleFactor * 24,
                    ),
                    SizedBox(width: width * 0.02),
                    ShimmerLoading(
                      width: scaleFactor * 20,
                      height: scaleFactor * 20,
                    ),
                  ],
                ),
                Divider(color: AppColors.midGrey, height: height * 0.02),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerLoading(
                      width: scaleFactor * 90,
                      height: scaleFactor * 90,
                    ),
                    SizedBox(width: width * 0.03),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerLoading(
                            width: width * 0.4,
                            height: 14 * scaleFactor,
                          ),
                          SizedBox(height: height * 0.008),
                          ShimmerLoading(
                            width: width * 0.5,
                            height: 12 * scaleFactor,
                          ),
                          SizedBox(height: height * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ShimmerLoading(
                                width: width * 0.15,
                                height: 12 * scaleFactor,
                              ),
                              const Spacer(),
                              ShimmerLoading(
                                width: width * 0.2,
                                height: height * 0.038,
                              ),
                              SizedBox(width: width * 0.02),
                              ShimmerLoading(
                                width: width * 0.2,
                                height: height * 0.038,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}
