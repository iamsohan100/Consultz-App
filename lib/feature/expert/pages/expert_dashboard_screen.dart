import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/feature/expert/widgets/discover_more_app.dart';
import 'package:consultz/feature/expert/widgets/expert_earning_booking_analytics.dart';
import 'package:consultz/feature/expert/widgets/expert_edit_profile_section.dart';
import 'package:consultz/feature/expert/widgets/expert_tools.dart';
import 'package:consultz/feature/expert/widgets/follow_growth_rate.dart';
import 'package:consultz/feature/expert/widgets/invite_friend.dart';
import 'package:consultz/feature/expert/widgets/more_tools.dart';
import 'package:consultz/feature/profile/widgets/setting_section.dart';
import 'package:consultz/feature/expert/controller/expert_dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpertDashboardScreen extends StatelessWidget {
  const ExpertDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final expertProfileViewModel = Get.find<ExpertDashboardViewModel>();
    return Scaffold(
      appBar: customAppBar(title: 'Dashboard', context: context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Padding(
                  padding: EdgeInsetsGeometry.all(scaleFactor * 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ExpertLevel(),
                    ExpertEarningBookingAnalytics(),
                      DiscoverMoreApp(),
                      InviteFriend(),
                      ExpertTools(),
                      FollowGrowthRate(),

                      MoreTools(),
                    ],
                  ),
                ),
                if (expertProfileViewModel.isEditProfile.value)
                  ExpertEditProfileSection(),
                if (expertProfileViewModel.isAccountSetting.value)
                  SettingSection(),
                if (!expertProfileViewModel.isEditProfile.value &&
                    !expertProfileViewModel.isAccountSetting.value)
                  SizedBox(height: height * 0.1),
              ],
            );
          }),
        ),
      ),
    );
  }
}
