import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/text/custom_rich_text.dart';
import 'package:consultz/core/utils/text/custom_text.dart';

import 'package:consultz/feature/bookings/controller/booking_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void bookingCancelDialog({
  required BuildContext context,
  required String bookingId,
  required String name,
  required String date,
  required String time,
}) {
  final height = Screen.screenHeight(context);
  final width = Screen.screenWidth(context);
  final scaleFactor = width / Screen.designWidth;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: width,
          margin: EdgeInsets.only(
            left: width * 0.04, // side padding
            right: width * 0.04, // side padding
            bottom: height * 0.03, // bottom padding
          ),
          padding: EdgeInsets.all(scaleFactor * 16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(scaleFactor * 20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.close_rounded,
                    color: AppColors.darkGrey,
                    size: scaleFactor * 20,
                  ),
                ),
              ),
              Container(
                width: scaleFactor * 76,
                height: scaleFactor * 76,
                decoration: BoxDecoration(
                  color: AppColors.warmGrey,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.warning_amber_rounded,
                  color: AppColors.black,
                  size: scaleFactor * 35,
                ),
              ),
              SizedBox(height: height * 0.025),
              CustomText(
                text: "Would you like to cancel your\nsession with $name?",
                color: AppColors.black,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: height * 0.025),
              CustomText(
                text: "$date・$time",
                color: AppColors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center,
              ),
              SizedBox(),
              CustomRichText(
                text1: "If yes, you will be refunded in x\namount of time. ",
                color1: AppColors.black,
                fontSize1: 14,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center,
                text2: "T&Cs",
                color2: AppColors.black,
                fontSize2: 14,
                textDecoration: TextDecoration.underline,
                textDecorationColor: AppColors.black,
              ),
              SizedBox(height: height * 0.05),

              PrimaryButton(
                onPressed: () => Navigator.of(context).pop(),
                title: 'No, keep the scheduled session',
                backgroundColor: AppColors.white,
                borderColor: AppColors.primaryColor,
                textColor: AppColors.primaryColor,
                buttonHeight: height * 0.045,
                radius: 8,
              ),
              SizedBox(height: height * 0.015),

              PrimaryButton(
                onPressed: () {
                  final controller = Get.find<BookingDetailsController>();
                  controller.cancelBooking(context, bookingId: bookingId);
                },
                title: 'Yes, I want to cancel',
                buttonHeight: height * 0.045,
                radius: 8,
              ),
            ],
          ),
        ),
      );
    },
  );
}
