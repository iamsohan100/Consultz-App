// ignore_for_file: file_names

import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/loading.dart/circle_loading.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:consultz/feature/profile/controller/notification_setting_controller.dart';
import 'package:consultz/feature/profile/widgets/settting_switch.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationSettingScreen extends StatefulWidget {
  const NotificationSettingScreen({super.key});

  @override
  State<NotificationSettingScreen> createState() =>
      _NotificationSettingScreenState();
}

class _NotificationSettingScreenState extends State<NotificationSettingScreen> {
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final profileController = Get.find<ProfileController>();
    final notifySettingController = Get.find<NotificationSettingController>();
    return Scaffold(
      appBar: customAppBar(context: context, title: 'Notifications'),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.all(scaleFactor * 16),
            child: Obx(() {
              final data = profileController.expertProfileModel.value.data;
              final pushNotify = data?.pushNotify;
              final emailNotify = data?.emailNotify;
              if (profileController.inProgress.value) {
                return CircleLoading();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Push notifications',
                    color: AppColors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: height * 0.02),
                  SetttingSwitch(
                    title: 'Booking requests',
                    isSelect: pushNotify!.bookingAndSchedule!.obs,
                    onChanged: (v) {
                      pushNotify.bookingAndSchedule = v;
                      setState(() {});
                      notifySettingController.changeNotifiy();
                    },
                  ),
                  SetttingSwitch(
                    title: 'Schedule reminders',
                    isSelect: pushNotify.scheduleRemainder!.obs,
                    onChanged: (v) {
                      pushNotify.scheduleRemainder = v;
                      setState(() {});
                      notifySettingController.changeNotifiy();
                    },
                  ),
                  SetttingSwitch(
                    title: 'Payments',
                    isSelect: pushNotify.payment!.obs,
                    onChanged: (v) {
                      pushNotify.payment = v;
                      setState(() {});
                      notifySettingController.changeNotifiy();
                    },
                  ),
                  SetttingSwitch(
                    title: 'Consultz points',
                    isSelect: pushNotify.points!.obs,
                    onChanged: (v) {
                      pushNotify.points = v;
                      setState(() {});
                      notifySettingController.changeNotifiy();
                    },
                  ),
                  SizedBox(height: height * 0.04),
                  CustomText(
                    text: 'Email notifications',
                    color: AppColors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: height * 0.02),
                  SetttingSwitch(
                    title: 'Booking requests ',
                    isSelect: emailNotify!.booking!.obs,
                    onChanged: (v) {
                      emailNotify.booking = v;
                      setState(() {});
                      notifySettingController.changeNotifiy();
                    },
                  ),
                  SetttingSwitch(
                    title: 'Schedule reminders',
                    isSelect: emailNotify.schedule!.obs,
                    onChanged: (v) {
                      emailNotify.schedule = v;
                      setState(() {});
                      notifySettingController.changeNotifiy();
                    },
                  ),
                  SetttingSwitch(
                    title: 'Payments',
                    isSelect: emailNotify.payment!.obs,
                    onChanged: (v) {
                      emailNotify.payment = v;
                      setState(() {});
                      notifySettingController.changeNotifiy();
                    },
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
