import 'dart:developer';

import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/image/display_network_image.dart';
import 'package:consultz/feature/bookings/widgets/message_icon.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/feature/bookings/model/expert_booking_by_date_model.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/text/custom_rich_text.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/bookings/widgets/dicline_dialog.dart';
import 'package:consultz/feature/bookings/widgets/discussion_details_modal_sheet.dart';
import 'package:consultz/core/utils/helper/time_helper.dart';
import 'package:consultz/feature/bookings/controller/booking_details_controller.dart';
import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DiscussionContainer extends StatelessWidget {
  const DiscussionContainer({super.key, this.bookingItem, this.isMeView});
  final BookingItem? bookingItem;
  final bool? isMeView;
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    // final browseFirstController = Get.find<BrowseFirstController>();
    log("booking id: ${bookingItem?.sId}");
    String formattedDate = '';
    if (bookingItem?.slot?.date != null) {
      try {
        DateTime date = DateTime.parse(bookingItem!.slot!.date!);
        formattedDate = DateFormat('MMM d').format(date);
      } catch (e) {
        formattedDate = bookingItem!.slot!.date!;
      }
    }

    String timeRange = '';
    if (bookingItem?.slot?.time != null &&
        bookingItem?.sessionDuration != null) {
      timeRange = TimeHelper.formatTimeRange(
        bookingItem!.slot!.time!,
        bookingItem!.sessionDuration!,
      );
    }

    final profileController = Get.find<ProfileController>();
    final currentUserId = profileController.expertProfileModel.value.data?.sId;
    final bool isMe = isMeView ?? (bookingItem?.user?.sId == currentUserId);
    final String otherPersonName = isMe
        ? '${bookingItem?.consult?.firstName ?? ''} ${bookingItem?.consult?.lastName ?? ''}'
        : '${bookingItem?.user?.firstName ?? ''} ${bookingItem?.user?.lastName ?? ''}';
    final String receiverId = isMe
        ? bookingItem?.consult?.sId ?? ''
        : bookingItem?.user?.sId ?? '';

    return GestureDetector(
      onTap: () {
        final controller = Get.find<BookingDetailsController>();
        if (bookingItem?.sId != null) {
          controller.getBookingDetails(context, bookingId: bookingItem!.sId!);
        }
      },
      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(
          horizontal: scaleFactor * 14,
          vertical: scaleFactor * 10,
        ),
        margin: EdgeInsets.symmetric(horizontal: width * 0.005),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(scaleFactor * 8),
          border: Border.all(color: Colors.transparent),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.1),
              spreadRadius: 0.8,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: height * 0.003,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomText(
                        text:
                            bookingItem?.sessionType?.toUpperCase() ??
                            'DISCUSSION',
                        color: AppColors.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      CustomText(
                        text: '${bookingItem?.sessionDuration ?? 0} Minutes',
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: width * 0.02),
                Container(
                  padding: EdgeInsets.all(scaleFactor * 10),
                  decoration: BoxDecoration(
                    color: _getStatusColor(
                      bookingItem?.status,
                    ).withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(scaleFactor * 16),
                  ),
                  child: CustomText(
                    text: bookingItem?.status?.capitalizeFirst ?? '',
                    color: _getStatusColor(bookingItem?.status),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (bookingItem?.status?.toLowerCase() == 'pending' ||
                    bookingItem?.status?.toLowerCase() == 'confirmed') ...[
                  SizedBox(width: width * 0.02),
                  GestureDetector(
                    onTap: () => discussionDetailsModalSheet(
                      context,
                      bookingId: bookingItem?.sId,
                      expertId: bookingItem?.consult?.sId,
                      firstName: isMe
                          ? bookingItem?.consult?.firstName ?? ''
                          : bookingItem?.user?.firstName ?? '',
                      lastName: isMe
                          ? bookingItem?.consult?.lastName ?? ''
                          : bookingItem?.user?.lastName ?? '',
                      formatedDate: formattedDate,
                      timeRange: timeRange,
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  width: scaleFactor * 90,
                  height: scaleFactor * 90,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(scaleFactor * 8),
                  ),
                  child:
                      (isMe
                              ? bookingItem?.consult?.photoUrl
                              : bookingItem?.user?.photoUrl) !=
                          null
                      ? DisplayNetworkImage(
                          imageUrl: isMe
                              ? bookingItem!.consult!.photoUrl!
                              : bookingItem!.user!.photoUrl!,
                          imageFit: .cover,
                          imageSize: scaleFactor * 90,
                        )
                      : Image.asset(AppImages.profileImage, fit: .cover),
                ),
                SizedBox(width: width * 0.03),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: otherPersonName,
                        color: AppColors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      CustomRichText(
                        text1: formattedDate,
                        color1: AppColors.darkGrey,
                        fontSize1: 12,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center,
                        text2: ' ・ ',
                        color2: AppColors.grey,
                        fontSize2: 12,
                        text3: timeRange,
                      ),
                      SizedBox(height: height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomText(
                            text:
                                '£${bookingItem?.price?.toStringAsFixed(2) ?? '0.00'}',
                            color: AppColors.primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          Spacer(),
                          // SizedBox(
                          //   width: browseFirstController.isConsultee.value
                          //       ? (width * 0.1)
                          //       : bookingItem?.status?.toLowerCase() ==
                          //             'pending'
                          //       ? (width * 0.045)
                          //       : (width * 0.145),
                          // ),
                          if (bookingItem?.status?.toLowerCase() == 'pending' &&
                              !isMe)
                            PrimaryButton(
                              onPressed: () {
                                final controller =
                                    Get.find<BookingDetailsController>();
                                diclineDialog(
                                  expertId: bookingItem?.consult?.sId ?? '',
                                  context: context,
                                  reasonController: controller.reasonController,
                                  onTap: () {
                                    if (bookingItem?.sId != null) {
                                      controller.declineBooking(
                                        context,
                                        bookingId: bookingItem!.sId!,
                                      );
                                    }
                                  },
                                );
                              },
                              title: 'Decline',
                              fontSize: 12,
                              radius: 8,
                              buttonWidth: width * 0.2,
                              buttonHeight: height * 0.038,
                              backgroundColor: Colors.transparent,
                              borderColor: AppColors.primaryColor,
                              textColor: AppColors.primaryColor,
                            )
                          else if (bookingItem?.status?.toLowerCase() ==
                              'confirmed')
                            MessageIcon(
                              personName: otherPersonName,
                              bookingId: bookingItem?.sId ?? '',
                              receiverId: receiverId,
                            ),
                          SizedBox(width: width * 0.02),
                          PrimaryButton(
                            onPressed: () {
                              final controller =
                                  Get.find<BookingDetailsController>();
                              if (bookingItem?.sId != null) {
                                if (bookingItem?.status?.toLowerCase() ==
                                        'pending' &&
                                    !isMe) {
                                  controller.confirmBooking(
                                    context,
                                    bookingId: bookingItem!.sId!,
                                  );
                                } else {
                                  controller.getBookingDetails(
                                    context,
                                    bookingId: bookingItem!.sId!,
                                  );
                                }
                              }
                            },
                            title:
                                bookingItem?.status?.toLowerCase() ==
                                        'pending' &&
                                    !isMe
                                ? 'Accept'
                                : 'Details',
                            fontSize: 12,
                            radius: 8,
                            buttonWidth: width * 0.2,
                            buttonHeight: height * 0.038,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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
