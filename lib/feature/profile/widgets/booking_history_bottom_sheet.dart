import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/profile/model/booking_history_model.dart';
import 'package:flutter/material.dart';

void bookingHistoryBottomSheet({
  required BuildContext context,
  required BookingData bookingModel,
}) {
  final height = Screen.screenHeight(context);
  final width = Screen.screenWidth(context);
  final scaleFactor = width / Screen.designWidth;

  String getTitle(String? status) {
    switch (status) {
      case 'pending': return 'Pending';
      case 'confirmed': return 'Confirmed';
      case 'not_responded': return 'Not Responded';
      case 'cancelled': 
      default: return 'Cancellation';
    }
  }

  String getDescription(BookingData bookingModel) {
    final String sessionType = bookingModel.sessionType ?? 'session';
    final String name = '${bookingModel.user?.firstName ?? ''} ${bookingModel.user?.lastName ?? ''}'.trim();
    final String date = bookingModel.slot?.date ?? '';
    final String time = bookingModel.slot?.time ?? '';
    final String status = bookingModel.status ?? '';

    final String sessionText = name.isNotEmpty ? "$sessionType session with $name" : "$sessionType session";
    final String dateTimeText = (date.isNotEmpty && time.isNotEmpty) ? " on $date, $time" : "";
    final String baseText = "The $sessionText$dateTimeText";

    switch (status) {
      case 'pending':
        return "$baseText is currently pending.\n\nWaiting for a response.";
      case 'confirmed':
        return "$baseText has been confirmed.";
      case 'not_responded':
        return "$baseText was not responded to.";
      case 'cancelled':
      default:
        return "$baseText was cancelled.\n\nRefund processed.";
    }
  }

  IconData getIcon(String? status) {
    switch (status) {
      case 'pending':
      case 'confirmed':
        return Icons.access_time_rounded;
      case 'not_responded':
      case 'cancelled':
      default:
        return Icons.warning_amber_rounded;
    }
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.white,
    showDragHandle: true,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.symmetric(
          vertical: scaleFactor * 16,
          horizontal: scaleFactor * 34,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: scaleFactor * 76,
              height: scaleFactor * 76,
              decoration: BoxDecoration(
                color: AppColors.warmGrey,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(
                getIcon(bookingModel.status),
                color: AppColors.black,
                size: scaleFactor * 35,
              ),
            ),
            SizedBox(height: height * 0.025),
            CustomText(
              text: getTitle(bookingModel.status),
              color: AppColors.black,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(height: height * 0.025),
            CustomText(
              text: getDescription(bookingModel),
              color: AppColors.black,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: height * 0.1),
          ],
        ),
      );
    },
  );
}
