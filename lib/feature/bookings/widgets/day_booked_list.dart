import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/feature/bookings/model/expert_booking_by_date_model.dart';
import 'package:consultz/feature/bookings/widgets/custom_header_calender.dart';
import 'package:consultz/feature/bookings/widgets/discussion_shimmer.dart';
import 'package:consultz/feature/bookings/widgets/discussion_container.dart';
import 'package:consultz/feature/bookings/widgets/no_session_booked.dart';
import 'package:consultz/feature/bookings/widgets/today_tomorrow_friday.dart';
import 'package:consultz/feature/bookings/controller/expert_booking_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DayBookedList extends StatelessWidget {
  const DayBookedList({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final expertBookingController = Get.find<ExpertBookingController>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: scaleFactor * 12),
      child: Obx(() {
        final bookings = expertBookingController.bookingDateGroups.isEmpty
            ? <BookingItem>[]
            : expertBookingController.bookingDateGroups.first.bookingList ?? [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TodayTomorrowFriday(),
            if (expertBookingController.isCustomDate.value) ...[
              SizedBox(height: height * 0.02),
              const CustomHeaderCalendar(),
            ],
            SizedBox(height: height * 0.03),
            if (expertBookingController.inProgress.value)
              const DiscussionShimmer()
            else if (bookings.isEmpty)
              NoSessionBooked()
            else
              ListView.separated(
                primary: false,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  return DiscussionContainer(bookingItem: bookings[index]);
                },
                separatorBuilder: (_, _) {
                  return SizedBox(height: height * 0.016);
                },
              ),
          ],
        );
      }),
    );
  }
}
