import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/bookings/controller/expert_booking_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodayTomorrowFriday extends StatelessWidget {
  const TodayTomorrowFriday({super.key});

  @override
  Widget build(BuildContext context) {
    double width = Screen.screenWidth(context);
    final expertBookingController = Get.find<ExpertBookingController>();
    GestureDetector button({
      required String title,
      required VoidCallback onTap,
      required bool isSelected,
    }) {
      return GestureDetector(
        onTap: onTap,
        child: CustomText(
          text: title,
          color: isSelected ? AppColors.black : AppColors.grey,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      );
    }

    return Column(
      children: [
        Obx(() {
          return Row(
            spacing: width * 0.05,
            children: [
              button(
                onTap: () => expertBookingController.setFilter('today'),
                title: 'Today',
                isSelected: expertBookingController.isToday.value,
              ),
              button(
                onTap: () => expertBookingController.setFilter('tomorrow'),
                title: 'Tomorrow',
                isSelected: expertBookingController.isTomorrow.value,
              ),
              button(
                onTap: () => expertBookingController.setFilter('day'),
                title: 'Date',
                isSelected: expertBookingController.isCustomDate.value,
              ),
            ],
          );
        }),
      ],
    );
  }
}
