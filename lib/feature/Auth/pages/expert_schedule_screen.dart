import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/feature/Auth/controller/expert_session_duration_controller.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/feature/bookings/model/session_data.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/widgets/expert_filling_steps.dart';
import 'package:consultz/feature/Auth/widgets/profile_completation_progress.dart';
import 'package:consultz/feature/Auth/widgets/session_duration_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpertScheduleScreen extends StatelessWidget {
  const ExpertScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final expertSessionDurationController =
        Get.find<ExpertSessionDurationController>();
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
            title: 'Continue, just 2 steps to go',
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
                ExpertFillingSteps(currentScreen: 2),
                SizedBox(),
                ProfileCompletationProgress(),
                SizedBox(),
                CustomText(
                  text: 'Set session duration',
                  color: AppColors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                CustomText(
                  text:
                      'Select the call durations you’d like to offer for video calls.',
                  color: AppColors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(),
                ListView.separated(
                  primary: false,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: SessionData.sessionList.length,
                  itemBuilder: (_, index) {
                    return SessionDurationContainer(
                      sessionModel: SessionData.sessionList[index],
                      onToggle: () =>
                          expertSessionDurationController.toggleSession(index),
                    );
                  },
                  separatorBuilder: (_, _) {
                    return SizedBox(height: height * 0.012);
                  },
                ),

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
  final expertSessionDurationController =
      Get.find<ExpertSessionDurationController>();

  if (!expertSessionDurationController.hasAnySessionSelected()) {
    bottomMessage(msg: "Please select at least one session duration");
    return;
  }

  final response = await expertSessionDurationController.updateSessionDurations(
    context,
  );

  if (response) {
    Get.toNamed(RoutesConstant.expertCalendarScreen);
  }
}
