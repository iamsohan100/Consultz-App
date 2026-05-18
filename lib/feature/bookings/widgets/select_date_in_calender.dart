import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/feature/bookings/controller/booking_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class SelectDateInCalender extends StatefulWidget {
  const SelectDateInCalender({super.key, required this.expertId});
  final String expertId;
  @override
  State<SelectDateInCalender> createState() => _SimpleCalendarState();
}

class _SimpleCalendarState extends State<SelectDateInCalender> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();
  final bookingController = Get.find<BookingController>();

  @override
  Widget build(BuildContext context) {
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    final now = DateTime.now();
    return TableCalendar(
      firstDay: now,
      lastDay: DateTime(now.year + 2, now.month, now.day),
      focusedDay: _focusedDay,
      availableGestures: AvailableGestures.horizontalSwipe,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });

        // Fetch slots for the selected date
        bookingController.getSlotsByExpertAndDate(
          expertId: widget.expertId,
          date: selectedDay,
        );
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
        // Fetch slots for the new month/year
        bookingController.fetchBookingSlots(
          year: focusedDay.year,
          month: focusedDay.month,
          author: widget.expertId,
        );
      },

      // header style
      headerStyle: HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        titleTextStyle: GoogleFonts.figtree(
          fontSize: scaleFactor * 16,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryColor,
          letterSpacing: 0.4,
        ),
        leftChevronIcon: Icon(Icons.chevron_left, color: AppColors.darkGrey),
        rightChevronIcon: Icon(Icons.chevron_right, color: AppColors.darkGrey),
      ),

      calendarStyle: CalendarStyle(
        isTodayHighlighted: false,
        selectedDecoration: BoxDecoration(
          color: AppColors.primaryColor,
          shape: BoxShape.circle,
        ),
        outsideDaysVisible: false,
      ),
    );
  }
}
