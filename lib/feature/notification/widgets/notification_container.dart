import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/different_text_format/time_format.dart';
import 'package:consultz/feature/notification/model/notification_model.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';

class NotificationContainer extends StatelessWidget {
  const NotificationContainer({super.key, required this.notificationData});
  final NotificationData notificationData;

  Color _getContainerColor(String? type) {
    switch (type) {
      case 'Booking':
        return AppColors.lilac.withValues(alpha: 0.3);
      case 'Payment':
        return const Color(0xFFE8FFEA);
      case 'Withdraw':
        return AppColors.blue.withValues(alpha: 0.3);
      case 'Reviews':
        return const Color(0xFFFFF8E8);
      case 'Calling':
        return AppColors.primaryColor.withValues(alpha: 0.15);
      default:
        return AppColors.primaryColor.withValues(alpha: 0.1);
    }
  }

  String _getImage(String? type) {
    switch (type) {
      case 'Booking':
        return AppImages.calender;
      case 'Payment':
        return AppImages.payment;
      case 'Withdraw':
        return AppImages.priceRange;
      case 'Reviews':
        return AppImages.star;
      case 'Calling':
        return AppImages.timeZone;
      default:
        return AppImages.icon;
    }
  }

  Color _getImageColor(String? type) {
    switch (type) {
      case 'Booking':
        return const Color(0xFFB735D8);
      case 'Payment':
        return AppColors.green;
      case 'Withdraw':
        return const Color(0xFF29B6F6); // A nice blue for withdraw
      case 'Reviews':
        return AppColors.warmYellow;
      case 'Calling':
        return AppColors.primaryColor;
      default:
        return AppColors.primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = Screen.screenHeight(context);
    final width = Screen.screenWidth(context);
    final scaleFactor = width / Screen.designWidth;
    final type = notificationData.modelType;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height * 0.008),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: scaleFactor * 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: scaleFactor * 50,
                height: scaleFactor * 50,
                decoration: BoxDecoration(
                  color: _getContainerColor(type),
                  borderRadius: BorderRadius.circular(scaleFactor * 8),
                ),
                alignment: Alignment.center,
                child: Image.asset(
                  _getImage(type),
                  width: scaleFactor * 27,
                  color: _getImageColor(type),
                ),
              ),
              SizedBox(width: width * 0.04),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: notificationData.message ?? '',
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(height: height * 0.002),
                    CustomText(
                      text: notificationData.description ?? '',
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    if (type != null) ...[
                      SizedBox(height: height * 0.002),
                      CustomText(
                        text: type,
                        color: type == 'Calling'
                            ? AppColors.primaryColor
                            : AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        textDecoration: TextDecoration.underline,
                        textDecorationColor: type == 'Calling'
                            ? AppColors.primaryColor
                            : AppColors.grey,
                      ),
                    ],
                    SizedBox(height: height * 0.002),
                    CustomText(
                      text: timeFormat(notificationData.createdAt ?? ''),
                      color: AppColors.grey,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              if (notificationData.read == false)
                Container(
                  width: scaleFactor * 9,
                  height: scaleFactor * 9,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: height * 0.006),
      ],
    );
  }
}
