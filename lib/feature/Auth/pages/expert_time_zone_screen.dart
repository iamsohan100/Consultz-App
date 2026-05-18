import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/feature/Auth/controller/set_expertise_time_zone_controller.dart';
import 'package:consultz/feature/Auth/model/time_zone_model.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/drop_down/custom_drop_down.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/widgets/expert_filling_steps.dart';
import 'package:consultz/feature/Auth/widgets/profile_completation_progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpertTimeZoneScreen extends StatelessWidget {
  const ExpertTimeZoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final setExpertiseTimeZoneController =
        Get.find<SetExpertiseTimeZoneController>();
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
            title: 'Set time zone',
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
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: height * 0.016,
              children: [
                ExpertFillingSteps(currentScreen: 1),
                SizedBox(),
                ProfileCompletationProgress(),
                SizedBox(),
                CustomText(
                  text: 'Select a time zone',
                  color: AppColors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                CustomText(
                  text:
                      'Select a time zone to set your availability for video calls.',
                  color: AppColors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                Obx(() {
                  return CustomDropDown(
                    title: 'Time zone *',
                    items: timeZone,
                    value:
                        setExpertiseTimeZoneController.selectedTimeZone.value,
                    onChange: (value) {
                      setExpertiseTimeZoneController.selectedTimeZone.value =
                          value!;
                    },
                  );
                }),

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
  final setExpertiseTimeZoneController =
      Get.find<SetExpertiseTimeZoneController>();
  if (setExpertiseTimeZoneController.selectedTimeZone.value ==
      'Select a time zone') {
    bottomMessage(msg: "Please select your time zone");
    return;
  }
  final response = await setExpertiseTimeZoneController.setTimeZone(context);
  if (response) {
    Get.toNamed(RoutesConstant.expertScheduleScreen);
  }
}
