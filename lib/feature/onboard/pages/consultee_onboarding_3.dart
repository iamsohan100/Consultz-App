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

class ConsulteeOnboarding3 extends StatelessWidget {
  const ConsulteeOnboarding3({super.key});

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
            CurrentBoardDot(
              screenNo: browseFirstController.isConsultee.value ? 3 : 4,
            ),

            PrimaryButton(
              onPressed: () {
                Get.toNamed(RoutesConstant.signUpScreen);
              },
              buttonWidth: width * 0.3,
              buttonHeight: scaleFactor * 48,
              title: "Let's do this!",
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
                AppImages.consulteeOnboarding3,
                width: scaleFactor * 231,
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
                      text: 'Consultz points',
                      color: AppColors.primaryColor,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                      lineHeight: 1.2,
                    ),
                    CustomText(
                      text:
                          'Earn Consultz Points through in-app activity, completed calls, and reviews. Use points to unlock in-app features, rewards, promotions, and increased visibility.',
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
