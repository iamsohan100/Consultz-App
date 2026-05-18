import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/text/custom_rich_text.dart';
import 'package:consultz/feature/bookings/controller/booking_controller.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/bookings/widgets/select_time_container.dart';
import 'package:consultz/feature/bookings/widgets/time_slot_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RescheduleAvailableDate extends StatelessWidget {
  const RescheduleAvailableDate({super.key, this.firstName, this.lastName});
  final String? firstName;
  final String? lastName;
  @override
  Widget build(BuildContext context) {
    final bookingController = Get.find<BookingController>();

    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);

    return Obx(() {
      if (bookingController.inProgress.value &&
          bookingController.availableSlots.isEmpty) {
        return Column(
          children: [
            SizedBox(height: height * 0.02),
            const TimeSlotShimmer(),
          ],
        );
      }

      if (bookingController.selectedDay.value == null) {
        return const SizedBox.shrink();
      }

      final expertName = "${firstName ?? 'Expert'} ${lastName ?? ''}";

      return Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text:
                  'Available on ${bookingController.selectedDateDisplay.value}',
              color: AppColors.black,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(height: height * 0.003),
            CustomRichText(
              text1: 'You can schedule a session with ',
              text2: expertName,
              text3: '\n1-60 days a head of time.',
              color1: AppColors.black,
              color2: AppColors.primaryColor,
              fontSize1: 12.5,
              fontWeight: FontWeight.w400,
              fontSize2: 12.5,
            ),

            SizedBox(height: height * 0.02),

            // Morning Section
            _buildTimeSection(
              title: 'Morning',
              slots: bookingController.morningSlots,
              bookingController: bookingController,
              height: height,
              width: width,
            ),

            SizedBox(height: height * 0.02),

            // Afternoon Section
            _buildTimeSection(
              title: 'Afternoon',
              slots: bookingController.afternoonSlots,
              bookingController: bookingController,
              height: height,
              width: width,
            ),

            SizedBox(height: height * 0.02),

            // Evening Section
            _buildTimeSection(
              title: 'Evening',
              slots: bookingController.eveningSlots,
              bookingController: bookingController,
              height: height,
              width: width,
            ),
          ],
        ),
      );
    });
  }

  Widget _buildTimeSection({
    required String title,
    required List slots,
    required BookingController bookingController,
    required double height,
    required double width,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          color: AppColors.black,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: height * 0.015),
        if (slots.isEmpty)
          SelectTimeContainer(
            title: 'Unavailable',
            isUnavailable: true,
            isSelected: false.obs,
          )
        else
          Wrap(
            spacing: width * 0.02,
            runSpacing: height * 0.02,
            children: [
              for (var slot in slots)
                GestureDetector(
                  onTap: () {
                    if (slot.sId != null) {
                      bookingController.slotId.value = slot.sId!;
                    }
                  },
                  child: SelectTimeContainer(
                    title: slot.time ?? '',
                    isSelected:
                        (bookingController.slotId.value == slot.sId).obs,
                  ),
                ),
            ],
          ),
      ],
    );
  }
}
