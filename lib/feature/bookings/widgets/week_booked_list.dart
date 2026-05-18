import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/feature/bookings/widgets/discussion_shimmer.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/bookings/widgets/discussion_container.dart';
import 'package:consultz/feature/bookings/widgets/no_session_booked.dart';
import 'package:consultz/feature/bookings/controller/expert_booking_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class WeekBookedList extends StatelessWidget {
  const WeekBookedList({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final expertBookingController = Get.find<ExpertBookingController>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: scaleFactor * 12),
      child: Obx(() {
        if (expertBookingController.inProgress.value) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.02),
              const DiscussionShimmer(),
            ],
          );
        }

        if (expertBookingController.bookingDateGroups.isEmpty) {
          return const NoSessionBooked();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.015),
            ...expertBookingController.bookingDateGroups.map((group) {
              final dateStr = group.date ?? '';
              DateTime? dateTime;
              String displayDate = dateStr;
              String dayName = '';

              try {
                // Try parsing dd-MM-yyyy
                dateTime = DateFormat('dd-MM-yyyy').parse(dateStr);
                displayDate = DateFormat('MMM d').format(dateTime);
                dayName = _getDayName(dateTime);
              } catch (e) {
                try {
                  // Try yyyy-MM-dd if that fails
                  dateTime = DateTime.parse(dateStr);
                  displayDate = DateFormat('MMM d').format(dateTime);
                  dayName = _getDayName(dateTime);
                } catch (_) {}
              }

              final bookings = group.bookingList ?? [];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _dateHeader(
                    width: width,
                    height: height,
                    date: displayDate,
                    day: dayName,
                    noSession: bookings.isEmpty,
                  ),
                  if (bookings.isNotEmpty) ...[
                    SizedBox(height: height * 0.015),
                    ListView.separated(
                      primary: false,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: bookings.length,
                      itemBuilder: (context, index) {
                        return DiscussionContainer(
                          bookingItem: bookings[index],
                        );
                      },
                      separatorBuilder: (_, _) => SizedBox(height: height * 0.016),
                    ),
                  ],
                  SizedBox(height: height * 0.02),
                ],
              );
            }),
          ],
        );
      }),
    );
  }

  String _getDayName(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final checkDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (checkDate == today) return 'Today';
    if (checkDate == tomorrow) return 'Tomorrow';
    return DateFormat('EEEE').format(dateTime);
  }

  Padding _dateHeader({
    required double width,
    required double height,
    required String date,
    required String day,
    bool? noSession,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: width * 0.05,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomText(
                text: date,
                color: AppColors.black,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                lineHeight: 0,
              ),
              CustomText(
                text: day,
                color: AppColors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                lineHeight: 0,
              ),
            ],
          ),
          if (noSession == true) ...[
            SizedBox(height: height * 0.015),
            CustomText(
              text: 'No sessions',
              color: AppColors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ],
        ],
      ),
    );
  }
}
