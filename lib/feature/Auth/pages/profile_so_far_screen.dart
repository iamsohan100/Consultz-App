import 'package:consultz/feature/Auth/controller/set_key_expertise_controller.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/widgets/completed_part.dart';
import 'package:consultz/feature/Auth/widgets/profile_completation_progress.dart';
import 'package:consultz/feature/Auth/controller/browse_first_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileSoFarScreen extends StatelessWidget {
  const ProfileSoFarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    return Scaffold(
      appBar: customAppBar(title: '', context: context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SafeArea(
        bottom: true,
        top: false,
        left: false,
        right: false,
        child: Padding(
          padding: EdgeInsets.all(scaleFactor * 20),
          child: PrimaryButton(
            onPressed: () => continu(context),
            title: 'Let’s wrap it up',
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.only(
              top: scaleFactor * 8,
              left: scaleFactor * 20,
              right: scaleFactor * 20,
              bottom: scaleFactor * 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: height * 0.016,
              children: [
                ProfileCompletationProgress(),
                CustomText(
                  text:
                      'Before we can push your profile live, you need to complete the steps below.',
                  color: AppColors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  lineHeight: 1.6,
                ),
                CompletedPart(),
                SizedBox(height: height * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> continu(BuildContext context) async {
  final setKeyExpertiseController = Get.find<SetKeyExpertiseController>();
  final browseFirstController = Get.find<BrowseFirstController>();

  final response = await setKeyExpertiseController.getAllCategory(context);
  if (response) {
    if (browseFirstController.isConsultee.value) {
      Get.toNamed(RoutesConstant.interestedScreen);
    } else {
      Get.toNamed(RoutesConstant.keyExpertiseScreen);
    }
  }
}
