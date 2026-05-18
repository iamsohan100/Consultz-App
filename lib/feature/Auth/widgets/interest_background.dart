import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';

import 'package:flutter/material.dart';

class InterestBackground extends StatelessWidget {
  const InterestBackground({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    // double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    // double scaleFactor = width / Screen.designWidth;
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Image.asset(AppImages.interested, width: width),

        child,
      ],
    );
  }
}
