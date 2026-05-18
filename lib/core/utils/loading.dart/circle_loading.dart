import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CircleLoading extends StatelessWidget {
  const CircleLoading({super.key, this.top});
  final double? top;
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    return Column(
      crossAxisAlignment: .center,
      mainAxisAlignment: .center,
      children: [
        SizedBox(height: height * (top ?? 0.32)),
        SpinKitCircle(color: AppColors.primaryColor, size: scaleFactor * 40),
      ],
    );
  }
}
