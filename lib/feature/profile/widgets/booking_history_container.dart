import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/feature/profile/model/booking_history_model.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_rich_text.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/profile/widgets/booking_history_bottom_sheet.dart';
import 'package:consultz/feature/profile/controller/booking_history_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingHistoryContainer extends StatelessWidget {
  const BookingHistoryContainer({super.key, required this.bookingModel});
  final BookingData bookingModel;
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final bookingDetailsController = Get.find<BookingHistoryDetailsController>();

    bool isCompleted = bookingModel.status == 'completed';
    bool isPending = bookingModel.status == 'pending';
    bool isConfirmed = bookingModel.status == 'confirmed';
    bool isNotResponded = bookingModel.status == 'not_responded';

    return Column(
      children: [
        ListTile(
          onTap: () async {
            if (!isCompleted) {
              bookingHistoryBottomSheet(
                context: context,
                bookingModel: bookingModel,
              );
            } else {
              if (bookingModel.sId != null) {
                final success = await bookingDetailsController
                    .getBookingDetails(context, bookingId: bookingModel.sId!);

                if (success) {
                  Get.toNamed(
                    RoutesConstant.bookingHistoryDetailsScreen,
                    arguments: bookingModel.sId,
                  );
                }
              }
            }
          },
          leading: Icon(
            isCompleted
                ? Icons.check_circle_rounded
                : isPending || isConfirmed
                ? Icons.access_time_filled
                : Icons.cancel,
            color: isCompleted
                ? AppColors.green
                : isPending || isConfirmed
                ? AppColors.darkGrey
                : AppColors.grey,
            size: scaleFactor * 26,
          ),
          title: CustomRichText(
            text1:
                '${bookingModel.user?.firstName ?? ''} ${bookingModel.user?.lastName ?? ''}',
            color1: AppColors.black,
            fontSize1: 14,
            fontWeight: FontWeight.w700,
            text2: ' - ${bookingModel.sessionType?.capitalizeFirst ?? ''}',
            color2: AppColors.darkGrey,
            fontSize2: 14,
            fontWeight2: FontWeight.w500,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.002),
              CustomText(
                text: '£${bookingModel.price}.00',
                color: AppColors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              CustomText(
                text: isCompleted
                    ? 'Session completed!'
                    : isPending
                    ? 'Waiting for you to accept.'
                    : isConfirmed
                    ? 'Session confirmed.'
                    : isNotResponded
                    ? 'Not responded.'
                    : 'Session cancelled. Refund processed.',
                color: isPending || isConfirmed
                    ? AppColors.primaryColor
                    : AppColors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            color: AppColors.darkGrey,
            size: scaleFactor * 16,
          ),
        ),
        Divider(color: AppColors.midGrey),
      ],
    );
  }
}
