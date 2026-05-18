import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class DiscoverMoreApp extends StatelessWidget {
  const DiscoverMoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    RxBool isClose = false.obs;
    unlockIcon() {
      return Transform.rotate(
        angle: 2.8,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: height * 0.003,
            horizontal: width * 0.02,
          ),
          decoration: BoxDecoration(
            color: Color(0xFFFFE8E8),
            borderRadius: BorderRadius.circular(scaleFactor * 33),
            border: Border.all(
              color: Color(0xFFFFBCBC).withValues(alpha: 0.68),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [Image.asset(AppImages.icon, width: scaleFactor * 14)],
          ),
        ),
      );
    }

    return Obx(() {
      if (isClose.value) {
        return SizedBox();
      }
      return Container(
        width: width,
        margin: EdgeInsets.only(top: height * 0.02),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(scaleFactor * 8),
          border: Border.all(color: Color(0xFFE6E8EC)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: scaleFactor * 6,
                top: scaleFactor * 5,
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    isClose.value = true;
                  },
                  child: Icon(
                    Icons.close,
                    size: scaleFactor * 16,
                    color: AppColors.darkGrey,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: scaleFactor * 20,
                right: scaleFactor * 20,
                left: scaleFactor * 20,
              ),
              child: Row(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Image.asset(AppImages.unlock, width: scaleFactor * 48),
                      unlockIcon(),
                    ],
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: width * 0.03),
                    width: width * 0.003,
                    height: height * 0.07,
                    color: AppColors.midGrey,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: height * 0.002,
                      children: [
                        CustomText(
                          text:
                              'Discover more App analytics  with Consultz Points',
                          color: AppColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),

                        CustomText(
                          text: 'Learn How',
                          color: AppColors.primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
