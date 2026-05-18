import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/controller/browse_first_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FillingSteps extends StatelessWidget {
  final int currentScreen;
  const FillingSteps({super.key, required this.currentScreen});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final browseFirstController = Get.find<BrowseFirstController>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (int i = 1; i < 4; i++)
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: height * 0.008,
            children: [
              Container(
                height: scaleFactor * 8,
                width: scaleFactor * 8,
                decoration: BoxDecoration(
                  color: currentScreen >= i ? AppColors.black : AppColors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: currentScreen != i
                        ? AppColors.black
                        : Colors.transparent,
                  ),
                ),
              ),
              CustomText(
                text: i == 1
                    ? 'Mobile number'
                    : i == 2
                    ? (browseFirstController.isConsultee.value)
                          ? 'Time zone'
                          : 'Social profile'
                    : (browseFirstController.isConsultee.value)
                    ? 'Price range'
                    : 'Set pricing',
                color: AppColors.black,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
      ],
    );
  }
}
