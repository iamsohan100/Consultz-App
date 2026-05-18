import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/feature/profile/controller/booking_history_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterBookingHistoryButton extends StatelessWidget {
  const FilterBookingHistoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    final bookingViewModel = Get.find<BookingHistoryController>();

    return Obx(() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          spacing: width * 0.04,
          children: [
            PrimaryButton(
              onPressed: () {
                bookingViewModel.isAll.value = true;
                bookingViewModel.isCompleted.value = false;
                bookingViewModel.isPending.value = false;
                bookingViewModel.isCancelled.value = false;
                bookingViewModel.isConfirmed.value = false;
                bookingViewModel.isNotResponded.value = false;
                bookingViewModel.initialLoad(selectedStatus: '');
              },
              title: 'All',
              backgroundColor: bookingViewModel.isAll.value
                  ? AppColors.warmGrey
                  : AppColors.darkGrey.withValues(alpha: 0.05),
              textColor: bookingViewModel.isAll.value
                  ? AppColors.primaryColor
                  : AppColors.darkGrey,
              borderColor: bookingViewModel.isAll.value
                  ? AppColors.primaryColor.withValues(alpha: 0.5)
                  : null,
              fontSize: 10,
              fontWeight: FontWeight.w500,
              buttonWidth: width * 0.12,
              buttonHeight: height * 0.037,
              radius: 8,
            ),
            PrimaryButton(
              onPressed: () {
                bookingViewModel.isAll.value = false;
                bookingViewModel.isCompleted.value = false;
                bookingViewModel.isPending.value = true;
                bookingViewModel.isCancelled.value = false;
                bookingViewModel.isConfirmed.value = false;
                bookingViewModel.isNotResponded.value = false;
                bookingViewModel.initialLoad(selectedStatus: 'pending');
              },
              title: 'Pending',
              backgroundColor: bookingViewModel.isPending.value
                  ? AppColors.warmGrey
                  : AppColors.darkGrey.withValues(alpha: 0.05),
              textColor: bookingViewModel.isPending.value
                  ? AppColors.primaryColor
                  : AppColors.darkGrey,
              borderColor: bookingViewModel.isPending.value
                  ? AppColors.primaryColor.withValues(alpha: 0.5)
                  : null,
              fontSize: 10,
              fontWeight: FontWeight.w500,
              buttonWidth: width * 0.22,
              buttonHeight: height * 0.037,
              radius: 8,
            ),
            PrimaryButton(
              onPressed: () {
                bookingViewModel.isAll.value = false;
                bookingViewModel.isCompleted.value = false;
                bookingViewModel.isPending.value = false;
                bookingViewModel.isCancelled.value = false;
                bookingViewModel.isConfirmed.value = true;
                bookingViewModel.isNotResponded.value = false;
                bookingViewModel.initialLoad(selectedStatus: 'confirmed');
              },
              title: 'Confirmed',
              backgroundColor: bookingViewModel.isConfirmed.value
                  ? AppColors.warmGrey
                  : AppColors.darkGrey.withValues(alpha: 0.05),
              textColor: bookingViewModel.isConfirmed.value
                  ? AppColors.primaryColor
                  : AppColors.darkGrey,
              borderColor: bookingViewModel.isConfirmed.value
                  ? AppColors.primaryColor.withValues(alpha: 0.5)
                  : null,
              fontSize: 10,
              fontWeight: FontWeight.w500,
              buttonWidth: width * 0.23,
              buttonHeight: height * 0.037,
              radius: 8,
            ),
            PrimaryButton(
              onPressed: () {
                bookingViewModel.isAll.value = false;
                bookingViewModel.isCompleted.value = true;
                bookingViewModel.isPending.value = false;
                bookingViewModel.isCancelled.value = false;
                bookingViewModel.isConfirmed.value = false;
                bookingViewModel.isNotResponded.value = false;
                bookingViewModel.initialLoad(selectedStatus: 'completed');
              },
              title: 'Completed',
              backgroundColor: bookingViewModel.isCompleted.value
                  ? AppColors.warmGrey
                  : AppColors.darkGrey.withValues(alpha: 0.05),
              textColor: bookingViewModel.isCompleted.value
                  ? AppColors.primaryColor
                  : AppColors.darkGrey,
              borderColor: bookingViewModel.isCompleted.value
                  ? AppColors.primaryColor.withValues(alpha: 0.5)
                  : null,
              fontSize: 10,
              fontWeight: FontWeight.w500,
              buttonWidth: width * 0.22,
              buttonHeight: height * 0.037,
              radius: 8,
            ),
            PrimaryButton(
              onPressed: () {
                bookingViewModel.isAll.value = false;
                bookingViewModel.isCompleted.value = false;
                bookingViewModel.isPending.value = false;
                bookingViewModel.isCancelled.value = true;
                bookingViewModel.isConfirmed.value = false;
                bookingViewModel.isNotResponded.value = false;
                bookingViewModel.initialLoad(selectedStatus: 'cancelled');
              },
              title: 'Cancelled',
              backgroundColor: bookingViewModel.isCancelled.value
                  ? AppColors.warmGrey
                  : AppColors.darkGrey.withValues(alpha: 0.05),
              textColor: bookingViewModel.isCancelled.value
                  ? AppColors.primaryColor
                  : AppColors.darkGrey,
              borderColor: bookingViewModel.isCancelled.value
                  ? AppColors.primaryColor.withValues(alpha: 0.5)
                  : null,
              fontSize: 10,
              fontWeight: FontWeight.w500,
              buttonWidth: width * 0.23,
              buttonHeight: height * 0.037,
              radius: 8,
            ),
            PrimaryButton(
              onPressed: () {
                bookingViewModel.isAll.value = false;
                bookingViewModel.isCompleted.value = false;
                bookingViewModel.isPending.value = false;
                bookingViewModel.isCancelled.value = false;
                bookingViewModel.isConfirmed.value = false;
                bookingViewModel.isNotResponded.value = true;
                bookingViewModel.initialLoad(selectedStatus: 'not_responded');
              },
              title: 'Not Responded',
              backgroundColor: bookingViewModel.isNotResponded.value
                  ? AppColors.warmGrey
                  : AppColors.darkGrey.withValues(alpha: 0.05),
              textColor: bookingViewModel.isNotResponded.value
                  ? AppColors.primaryColor
                  : AppColors.darkGrey,
              borderColor: bookingViewModel.isNotResponded.value
                  ? AppColors.primaryColor.withValues(alpha: 0.5)
                  : null,
              fontSize: 10,
              fontWeight: FontWeight.w500,
              buttonWidth: width * 0.32,
              buttonHeight: height * 0.037,
              radius: 8,
            ),
          ],
        ),
      );
    });
  }
}
