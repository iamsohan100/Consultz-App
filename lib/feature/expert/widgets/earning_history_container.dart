import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/core/utils/different_text_format/time_format.dart';
import 'package:consultz/feature/expert/model/withdraw_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EarningHistoryContainer extends StatelessWidget {
  const EarningHistoryContainer({super.key, required this.item});

  final WithdrawItem item;

  @override
  Widget build(BuildContext context) {
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    bool isCompleted = item.status == 'completed';

    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(
            isCompleted ? Icons.check_circle_rounded : Icons.cancel,
            color: isCompleted ? AppColors.green : AppColors.grey,
            size: scaleFactor * 26,
          ),
          title: CustomText(
            text: item.booking?.user?.fullName ?? 'Unknown User',
            color: AppColors.black,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text:
                    item.booking?.sessionType
                        ?.replaceAll('_', ' ')
                        .toUpperCase() ??
                    '',
                color: AppColors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              CustomText(
                text: item.createdAt != null ? timeFormat(item.createdAt!) : '',
                color: AppColors.grey,
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: '£${item.amount?.toStringAsFixed(2) ?? '0.00'}',
                color: AppColors.black,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              CustomText(
                text: isCompleted
                    ? 'Paid'
                    : (item.status?.capitalizeFirst ?? 'Unknown'),
                color: isCompleted ? AppColors.green : AppColors.primaryColor,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        ),
        Container(width: width, color: AppColors.midGrey, height: 0.8),
      ],
    );
  }
}
