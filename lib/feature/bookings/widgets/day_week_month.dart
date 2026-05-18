import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/bookings/controller/expert_booking_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DayWeekMonth extends StatelessWidget {
  const DayWeekMonth({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final expertBookingController = Get.find<ExpertBookingController>();
    GestureDetector button({
      required String title,
      required VoidCallback onTap,
      required bool isSelected,
    }) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.only(
            bottom: height * 0.01,
            right: width * 0.02,
            left: width * 0.01,
          ),
          decoration: BoxDecoration(
            color: Colors.transparent,

            border: Border(
              bottom: BorderSide(
                color: isSelected ? AppColors.primaryColor : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          alignment: Alignment.center,
          child: CustomText(
            text: title,
            color: isSelected ? AppColors.black : AppColors.grey,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: scaleFactor * 14),
      child: Column(
        children: [
          Obx(() {
            return Row(
              spacing: width * 0.04,
              children: [
                button(
                  onTap: () => expertBookingController.setFilter('today'),
                  title: 'Day',
                  isSelected: expertBookingController.isSelectedFilter('today') || 
                              expertBookingController.isSelectedFilter('tomorrow') ||
                              expertBookingController.isSelectedFilter('day'),
                ),
                button(
                  onTap: () => expertBookingController.setFilter('week'),
                  title: 'Week',
                  isSelected: expertBookingController.isSelectedFilter('week'),
                ),
                button(
                  onTap: () => expertBookingController.setFilter('month'),
                  title: 'Month',
                  isSelected: expertBookingController.isSelectedFilter('month'),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
