import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/onboard/widgets/current_board_dot.dart';
import 'package:consultz/feature/onboard/widgets/onboard_background.dart';
import 'package:consultz/feature/Auth/controller/browse_first_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConsulteeOnboarding2 extends StatelessWidget {
  const ConsulteeOnboarding2({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final browseFirstController = Get.find<BrowseFirstController>();

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.all(scaleFactor * 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CurrentBoardDot(screenNo: 2),
            PrimaryButton(
              onPressed: () {
                if (!browseFirstController.isConsultee.value) {
                  Get.toNamed(RoutesConstant.expertOnboarding3);
                } else {
                  Get.toNamed(RoutesConstant.consulteeOnboarding3);
                }
              },
              buttonWidth: scaleFactor * 48,
              buttonHeight: scaleFactor * 48,
              icon: Icon(
                Icons.arrow_forward_sharp,
                color: AppColors.white,
                size: scaleFactor * 22,
              ),
            ),
          ],
        ),
      ),
      body: OnbaordBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.115),
            Center(
              child: Image.asset(
                AppImages.consulteeOnboarding2,
                width: scaleFactor * 375,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: height * 0.05),

            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(scaleFactor * 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: height * 0.018,
                  children: [
                    CustomText(
                      text: 'Flexible booking',
                      color: AppColors.primaryColor,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                      lineHeight: 1.2,
                    ),
                    CustomText(
                      text: !browseFirstController.isConsultee.value
                          ? 'Clients can instantly book 15, 30, or 60-minute sessions that fit your schedule and their needs, all through the app.'
                          : 'Book 15, 30, or 60-minute sessions that suit your schedule and needs. Find the perfect time and duration with ease, all through the app.',
                      color: AppColors.darkGrey,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.4,
                      lineHeight: 1.5,
                    ),
                    SizedBox(height: height * 0.1),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
