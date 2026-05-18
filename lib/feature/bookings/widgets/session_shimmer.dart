import 'package:consultz/core/utils/loading.dart/shimmer_loading.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:flutter/material.dart';

class SessionShimmer extends StatelessWidget {
  const SessionShimmer({super.key, this.length});
  final int? length;

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: length ?? 5,
      itemBuilder: (_, index) {
        return Container(
          width: width,
          padding: EdgeInsets.symmetric(
            horizontal: scaleFactor * 14,
            vertical: scaleFactor * 10,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(scaleFactor * 8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                spreadRadius: 0.8,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: height * 0.008,
            children: [
              ShimmerLoading(
                width: width * 0.4,
                height: 14 * scaleFactor,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ShimmerLoading(
                    width: width * 0.2,
                    height: 12 * scaleFactor,
                  ),
                  SizedBox(width: width * 0.02),
                  ShimmerLoading(
                    width: width * 0.15,
                    height: 12 * scaleFactor,
                  ),
                ],
              ),
            ],
          ),
        );
      },
      separatorBuilder: (_, _) {
        return SizedBox(height: height * 0.012);
      },
    );
  }
}
