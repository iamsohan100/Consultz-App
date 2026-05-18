import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/feature/bookings/controller/booking_controller.dart';
import 'package:consultz/feature/bookings/widgets/reschedule_available_date.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/bookings/widgets/confirm_date_time_button.dart';
import 'package:consultz/feature/bookings/widgets/select_date_in_calender.dart';
import 'package:consultz/feature/main/controller/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingRescheduleScreen extends StatefulWidget {
  const BookingRescheduleScreen({super.key});

  @override
  State<BookingRescheduleScreen> createState() =>
      _BookingRescheduleScreenState();
}

class _BookingRescheduleScreenState extends State<BookingRescheduleScreen> {
  final bookingController = Get.find<BookingController>();
  final args = Get.arguments as Map<String, dynamic>;

  //  'bookingId': bookingId,
  //             'expertId': expertId,
  //             'firstName': firstName,
  //             'lastName': lastName,
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bookingController.fetchBookingSlots(author: args['expertId'] ?? '');
      bookingController.getSlotsByExpertAndDate(
        expertId: args['expertId'] ?? '',
        date: DateTime.now(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    final expertName = "${args['firstName'] ?? ''} ${args['lastName'] ?? ''}"
        .trim();
    final sessionType = bookingController.sessionType.value.replaceAll(
      '_',
      ' ',
    );

    return Scaffold(
      appBar: customAppBar(title: '', context: context),
      bottomNavigationBar: ConfirmDateTimeButton(
        onTap: () async {
          if (bookingController.slotId.value.isNotEmpty) {
            final isSuccess = await bookingController.rescheduleBooking(
              context,
              args['bookingId'] ?? '',
            );
            if (isSuccess) {
              if (args['isDetailScreen'] == true) {
                Navigator.pop(context);
                Navigator.pop(context);
              } else {
                Navigator.pop(context);
              }
              Get.find<MainController>().changeIndex(index: 0);
              bottomMessage(msg: 'Booking rescheduled successfully');
            }
          } else {
            bottomMessage(msg: 'Please select a time slot');
          }
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.only(
              top: scaleFactor * 8,
              left: scaleFactor * 20,
              right: scaleFactor * 20,
              bottom: scaleFactor * 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: height * 0.016,
              children: [
                SizedBox(),
                CustomText(
                  text: 'Select a date and time',
                  color: AppColors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.center,
                ),
                CustomText(
                  text:
                      'Select a date and start time you’d like to book your $sessionType session with $expertName',
                  color: AppColors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.center,
                  lineHeight: 1.6,
                ),
                SelectDateInCalender(expertId: args['expertId'] ?? ''),
                RescheduleAvailableDate(
                  firstName: args['firstName'],
                  lastName: args['lastName'],
                ),
                SizedBox(height: height * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
