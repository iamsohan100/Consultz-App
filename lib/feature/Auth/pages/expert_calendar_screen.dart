import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/feature/main/controller/main_controller.dart';
import 'package:consultz/feature/Auth/model/interest_page_data.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/widgets/available_time_container.dart';
import 'package:consultz/feature/Auth/widgets/expert_filling_steps.dart';
import 'package:consultz/feature/Auth/widgets/profile_completation_progress.dart';
import 'package:consultz/feature/expert/controller/calendar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpertCalendarScreen extends StatelessWidget {
  const ExpertCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    final calendarController = Get.find<CalendarController>();

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
            onPressed: () async {
              final success = await calendarController.submitAvailability(
                context,
                isProfileSetup: true,
              );
              if (success) {
                Get.offAllNamed(RoutesConstant.mainScreen);
                Get.find<MainController>().changeIndex(index: 4);
              }
            },
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
                ExpertFillingSteps(currentScreen: 3),
                const SizedBox(),
                ProfileCompletationProgress(),
                const SizedBox(),
                CustomText(
                  text: 'Set your availability',
                  color: AppColors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                CustomText(
                  text:
                      'Pick the days and the times when you are typically available for video calls.',
                  color: AppColors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                ListView.separated(
                  primary: false,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: InterestPageData.availabilityData.length,
                  itemBuilder: (_, index) {
                    return AvailableTimeContainer(
                      dayName: InterestPageData.availabilityData[index],
                    );
                  },
                  separatorBuilder: (_, _) => SizedBox(height: height * 0.012),
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
