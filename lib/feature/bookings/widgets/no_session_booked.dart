import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/main/controller/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoSessionBooked extends StatelessWidget {
  const NoSessionBooked({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    // double scaleFactor = width / Screen.designWidth;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: height * 0.005,
      children: [
        CustomText(
          text: 'No sessions booked',
          color: AppColors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        CustomText(
          text:
              'Posting content can help boost your\nprofile and increase your bookings',
          color: AppColors.black,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        SizedBox(),
        PrimaryButton(
          onPressed: () {
            Get.find<MainController>().changeIndex(index: 2);
          },
          title: 'Post',
          buttonHeight: height * 0.04,
          buttonWidth: width * 0.2,
          fontSize: 12,
          radius: 8,
        ),
      ],
    );
  }
}
