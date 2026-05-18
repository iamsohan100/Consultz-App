import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/feature/bookings/widgets/day_booked_list.dart';
import 'package:consultz/feature/bookings/widgets/day_week_month.dart';
import 'package:consultz/feature/bookings/widgets/month_booked_list.dart';
import 'package:consultz/feature/bookings/widgets/week_booked_list.dart';
import 'package:consultz/feature/bookings/controller/expert_booking_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpertPart extends StatefulWidget {
  const ExpertPart({super.key});

  @override
  State<ExpertPart> createState() => _ExpertPartState();
}

class _ExpertPartState extends State<ExpertPart> {
  final expertBookingController = Get.find<ExpertBookingController>();

  @override
  void initState() {
    super.initState();
    // Refresh bookings when this view is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      expertBookingController.fetchBookings();
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsGeometry.only(
              top: scaleFactor * 10,
              bottom: expertBookingController.isDay.value
                  ? (scaleFactor * 20)
                  : 0,
            ),
            child: DayWeekMonth(),
          ),
          if (expertBookingController.isDay.value) DayBookedList(),
          if (expertBookingController.isWeek.value) WeekBookedList(),
          if (expertBookingController.isMonth.value) MonthBookedList(),

          SizedBox(height: height * 0.04),
        ],
      );
    });
  }
}
