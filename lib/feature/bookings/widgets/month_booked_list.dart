import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/bookings/widgets/discussion_shimmer.dart';
import 'package:consultz/feature/bookings/widgets/custom_header_calender.dart';
import 'package:consultz/feature/bookings/widgets/discussion_container.dart';
import 'package:consultz/feature/bookings/widgets/no_session_booked.dart';
import 'package:consultz/feature/bookings/controller/expert_booking_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MonthBookedList extends StatelessWidget {
  const MonthBookedList({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final expertBookingController = Get.find<ExpertBookingController>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: scaleFactor * 12),
      child: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomHeaderCalendar(),
            SizedBox(height: height * 0.02),
            if (expertBookingController.inProgress.value)
              const DiscussionShimmer()
            else if (expertBookingController.bookingDateGroups.isEmpty)
              const NoSessionBooked()
            else
              ...expertBookingController.bookingDateGroups.map((group) {
                final dateStr = group.date ?? '';
                DateTime? dateTime;
                String displayDate = dateStr;
                String dayName = '';

                try {
                  dateTime = DateFormat('dd-MM-yyyy').parse(dateStr);
                  displayDate = DateFormat('MMM d').format(dateTime);
                  dayName = _getDayName(dateTime);
                } catch (e) {
                  try {
                    dateTime = DateTime.parse(dateStr);
                    displayDate = DateFormat('MMM d').format(dateTime);
                    dayName = _getDayName(dateTime);
                  } catch (_) {}
                }

                final bookings = group.bookingList ?? [];
                if (bookings.isEmpty) return const SizedBox.shrink();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.01),
                      child: CustomText(
                        text: dayName.isNotEmpty
                            ? '$displayDate ・ $dayName'
                            : displayDate,
                        color: AppColors.darkGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
                      separatorBuilder: (_, _) =>
                          SizedBox(height: height * 0.016),
                    ),
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
}
