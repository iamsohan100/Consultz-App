import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/feature/bookings/widgets/dicline_dialog.dart';
import 'package:consultz/feature/bookings/controller/booking_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AcceptDiclineButton extends StatelessWidget {
  const AcceptDiclineButton({super.key, required this.expertId});
final String expertId;
  @override
  Widget build(BuildContext context) {
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    return Container(
      padding: EdgeInsets.only(
        top: scaleFactor * 15,
        left: scaleFactor * 20,
        right: scaleFactor * 20,
        bottom: scaleFactor * 30,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            spreadRadius: 0.12,
            offset: Offset(0, -20),
          ),
        ],
      ),
      child: Row(
        spacing: width * 0.03,
        children: [
          Expanded(
            child: PrimaryButton(
              onPressed: () {
                final controller = Get.find<BookingDetailsController>();
                diclineDialog(
                  expertId: expertId,
                  context: context,
                  reasonController: controller.reasonController,
                  onTap: () {
                    if (controller.bookingDetails.value?.sId != null) {
                      controller.declineBooking(
                        context,
                        bookingId: controller.bookingDetails.value!.sId!,
                      );
                    }
                  },
                );
              },
              title: 'Decline',
              backgroundColor: Colors.transparent,
              textColor: AppColors.primaryColor,
              borderColor: AppColors.primaryColor,
            ),
          ),
          Expanded(
            child: PrimaryButton(
              onPressed: () {
                final controller = Get.find<BookingDetailsController>();
                if (controller.bookingDetails.value?.sId != null) {
                  controller.confirmBooking(
                    context,
                    bookingId: controller.bookingDetails.value!.sId!,
                  );
                }
              },
              title: 'Accept',
            ),
          ),
        ],
      ),
    );
  }
}
