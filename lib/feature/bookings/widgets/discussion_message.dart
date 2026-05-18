import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/bookings/widgets/discussion_details_modal_sheet.dart';
import 'package:consultz/feature/bookings/widgets/message_icon.dart';
import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:consultz/feature/bookings/model/booking_details_model.dart';
import 'package:consultz/core/utils/helper/time_helper.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DiscussionMessage extends StatelessWidget {
  const DiscussionMessage({super.key, this.joinCall, this.details});
  final bool? joinCall;
  final BookingDetailsData? details;
  @override
  Widget build(BuildContext context) {
    // double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    final profileController = Get.find<ProfileController>();
    final currentUserId = profileController.expertProfileModel.value.data?.sId;
    final bool isMe = details?.user?.sId == currentUserId;
    final String otherPersonName = isMe
        ? '${details?.consult?.firstName ?? ''} ${details?.consult?.lastName ?? ''}'
        : '${details?.user?.firstName ?? ''} ${details?.user?.lastName ?? ''}';
    final String receiverId = isMe
        ? details?.consult?.sId ?? ''
        : details?.user?.sId ?? '';

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

    return Column(
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomText(
                      text: details?.sessionType?.toUpperCase() ?? 'DISCUSSION',
                      color: AppColors.primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(width: width * 0.02),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: scaleFactor * 8,
                        vertical: scaleFactor * 2,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(
                          details?.status,
                        ).withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(scaleFactor * 16),
                      ),
                      child: CustomText(
                        text: details?.status?.capitalizeFirst ?? '',
                        color: _getStatusColor(details?.status),
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                CustomText(
                  text: '${details?.sessionDuration ?? 0} minutes',
                  color: AppColors.darkGrey,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
            Spacer(),

            if (details?.status?.toLowerCase() == 'confirmed') ...[
              MessageIcon(
                personName: otherPersonName,
                bookingId: details?.sId ?? '',
                receiverId: receiverId,
              ),
              SizedBox(width: width * 0.02),
            ],

            if (details?.status?.toLowerCase() == 'pending' ||
                details?.status?.toLowerCase() == 'confirmed') ...[
              GestureDetector(
                onTap: () => discussionDetailsModalSheet(
                  context,
                  bookingId: details?.sId,
                  expertId: details?.consult?.sId,
                  firstName: isMe
                      ? details?.consult?.firstName ?? ''
                      : details?.user?.firstName ?? '',
                  lastName: isMe
                      ? details?.consult?.lastName ?? ''
                      : details?.user?.lastName ?? '',
                  formatedDate: formattedDate,
                  timeRange: timeRange, isDetailScreen: true,
                ),
                child: Icon(
                  Icons.more_vert,
                  color: AppColors.darkGrey,
                  size: scaleFactor * 20,
                ),
              ),
            ],
          ],
        ),
        Divider(color: AppColors.midGrey),
      ],
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'confirmed':
        return AppColors.green;
      case 'up next':
        return AppColors.primaryColor;
      case 'pending':
        return AppColors.darkGrey;
      case 'canceled':
      case 'cancelled':
      case 'declined':
      case 'not_responded':
        return AppColors.red;
      default:
        return AppColors.green;
    }
  }
}
