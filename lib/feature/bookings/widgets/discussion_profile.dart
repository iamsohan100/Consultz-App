import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/core/utils/image/display_network_image.dart';
import 'package:consultz/feature/bookings/model/booking_details_model.dart';
import 'package:consultz/core/utils/helper/time_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:consultz/core/utils/share_preference/auth_preference.dart';

class DiscussionProfile extends StatelessWidget {
  const DiscussionProfile({super.key, this.details});
  final BookingDetailsData? details;

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    final isConsultee = AuthPreference.logInInfo?.data?.user?.role != 'expert';
    final profileData = isConsultee ? details?.consult : details?.user;

    String formattedDate = '';
    if (details?.slot?.date != null) {
      try {
        DateTime date = DateTime.parse(details!.slot!.date!);
        formattedDate = DateFormat('MMM d').format(date);
      } catch (e) {
        formattedDate = details!.slot!.date!;
      }
    }

    String timeRange = '';
    if (details?.slot?.time != null && details?.sessionDuration != null) {
      timeRange = TimeHelper.formatTimeRange(
        details!.slot!.time!,
        details!.sessionDuration!,
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          height: scaleFactor * 60,
          width: scaleFactor * 60,
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: profileData?.photoUrl != null
              ? DisplayNetworkImage(
                  imageUrl: profileData!.photoUrl!,
                  imageFit: BoxFit.cover,
                  imageSize: scaleFactor*60,
                )
              : Image.asset(AppImages.profileImage, fit: BoxFit.cover),
        ),
        SizedBox(width: width * 0.04),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text:
                  '${profileData?.firstName ?? ''} ${profileData?.lastName ?? ''}',
              color: AppColors.black,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
            CustomText(
              text: '$formattedDate ・ $timeRange',
              color: AppColors.black,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: height * 0.002),
            CustomText(
              text: '£${details?.price?.toStringAsFixed(2) ?? '0.00'}',
              color: AppColors.primaryColor,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
      ],
    );
  }
}
