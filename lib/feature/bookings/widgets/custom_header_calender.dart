import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:consultz/feature/bookings/controller/expert_booking_controller.dart';
import 'package:get/get.dart';

class CustomHeaderCalendar extends StatefulWidget {
  const CustomHeaderCalendar({super.key});

  @override
  State<CustomHeaderCalendar> createState() => _CustomHeaderCalendarState();
}

class _CustomHeaderCalendarState extends State<CustomHeaderCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);

    return Column(
      spacing: height * 0.01,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ✅ Custom Header Section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Month name first
            CustomText(
              text: DateFormat.yMMM().format(_focusedDay),
              color: AppColors.black,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),

            // Chevron icons at right side
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  color: AppColors.grey,
                  onPressed: () {
                    setState(() {
                      _focusedDay = DateTime(
                        _focusedDay.year,
                        _focusedDay.month - 1,
                      );
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  color: AppColors.grey,
                  onPressed: () {
                    setState(() {
                      _focusedDay = DateTime(
                        _focusedDay.year,
                        _focusedDay.month + 1,
                      );
                    });
                  },
                ),
              ],
            ),
          ],
        ),

        // ✅ Calendar part
        TableCalendar(
          headerVisible: false,
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _focusedDay,
          availableGestures:
              AvailableGestures.horizontalSwipe, // ✅ only horizontal swipe
          // select logic
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
            final expertBookingController = Get.find<ExpertBookingController>();
            final String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDay);
            expertBookingController.pickDate(formattedDate);
          },
          onPageChanged: (focusedDay) {
            setState(() {
              _focusedDay = focusedDay;
            });
          },
          calendarStyle: CalendarStyle(
            isTodayHighlighted: false,
            selectedDecoration: BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
            outsideDaysVisible: false,
          ),
        ),
      ],
    );
  }
}
