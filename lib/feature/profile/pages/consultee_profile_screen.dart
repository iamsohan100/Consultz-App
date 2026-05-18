import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/feature/expert/widgets/invite_friend.dart';
import 'package:consultz/feature/profile/widgets/consultee_booking_point.dart';
import 'package:consultz/feature/profile/widgets/consultee_profile.dart';
import 'package:consultz/feature/profile/widgets/edit_profile_section.dart';
import 'package:consultz/feature/profile/widgets/setting_section.dart';
import 'package:consultz/feature/profile/widgets/tools.dart';
import 'package:consultz/feature/main/controller/main_controller.dart';
import 'package:consultz/feature/profile/controller/consultee_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConsulteeProfileScreen extends StatelessWidget {
  const ConsulteeProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final consulteeProfileController = Get.find<ConsulteeProfileController>();
    return PopScope(
      canPop: false,
      // ignore: deprecated_member_use
      onPopInvoked: (_) {
        Get.find<MainController>().changeIndex(index: 0);
      },
      child: Scaffold(
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
                        ConsulteeProfile(),
                        SizedBox(height: height * 0.015),
                        // ConsulteeLevel(),
                        ConsulteeBookinPoint(),
                        InviteFriend(),
                        Tools(),
                      ],
                    ),
                  ),
                  if (consulteeProfileController.isProfile.value)
                    EditProfileSection(),
                  if (consulteeProfileController.isSetting.value)
                    SettingSection(),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
