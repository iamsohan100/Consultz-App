import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:flutter/material.dart';

class MyCamera extends StatelessWidget {
  const MyCamera({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.only(right: width * 0.05),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              height: height * 0.2,
              width: width * 0.3,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(scaleFactor * 14),
              ),
              child: Image.asset(AppImages.expert3, fit: BoxFit.cover),
            ),
            Positioned(
              top: height * 0.006,
              right: width * 0.015,
              child: Icon(Icons.flip_camera_ios_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
