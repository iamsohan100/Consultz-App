// ignore_for_file: use_build_context_synchronously

import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/message/top_message.dart';
import 'package:consultz/feature/Auth/model/interest_page_data.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/widgets/available_time_container.dart';
import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:consultz/feature/expert/controller/calendar_controller.dart';
import 'package:consultz/feature/expert/model/expert_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final calendarController = Get.find<CalendarController>();
  final profileController = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final List<Availability>? existing =
          profileController.expertProfileModel.value.data?.availability;
      if (existing != null && existing.isNotEmpty) {
        calendarController.loadFromProfile(existing);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Calendar',
        actions: [
          GestureDetector(
            onTap: updateCalendar,
            child: CustomText(
              text: 'Done',
              color: AppColors.primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: width * 0.04),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(scaleFactor * 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Manage your available time slots',
                  color: AppColors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: height * 0.03),
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
                  separatorBuilder: (_, _) {
                    return SizedBox(height: height * 0.012);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateCalendar() async {
    final success = await calendarController.submitAvailability(context);
    if (success) {
      topMessage(msg: 'Calendar updated successfully', title: 'Successful');
      Navigator.pop(context);
    }
  }
}
