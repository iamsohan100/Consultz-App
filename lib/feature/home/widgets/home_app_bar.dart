import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/form_field/custom_form_field.dart';
import 'package:consultz/core/utils/widgets/notification_bell.dart';
import 'package:consultz/feature/Auth/widgets/app_bar_coin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar homeAppBar(
  double height,
  double scaleFactor,
  BuildContext context,
  double width,
  String title, {
  bool? isFilter,
  VoidCallback? onTap,
  bool? isShowMeExpert,
}) {
  return customAppBar(
    context: context,
    isLeading: false,
    title: title,
    fontSize: 24,
    isLine: true,
    actions: [
      AppBarCoin(),
      SizedBox(width: width * 0.02),
      if (isShowMeExpert == true) ...[
        IconButton(
          color: AppColors.darkGrey,
          icon: Icon(Icons.notifications, size: scaleFactor * 25),
          onPressed: () {},
        ),
      ] else ...[
        NotificationBell(),
      ],
      SizedBox(width: width * 0.02),
    ],
    bottomWidgetHeight: 60,
    bottomWidget: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 8,
              child: Padding(
                padding: EdgeInsets.only(left: width * 0.04),
                child: CustomFormField(
                  onTap:
                      onTap ??
                      () {
                        Get.toNamed(RoutesConstant.searchExpertScreen);
                      },
                  readOnly: true,
                  hintText: 'Search for Experts',
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: AppColors.darkGrey,
                    size: scaleFactor * 22,
                  ),
                  backgroundColor: Color(0xFFF5F5F5),
                ),
              ),
            ),
            if (isFilter == false) SizedBox(width: width * 0.04),
            if (isFilter != false)
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(RoutesConstant.filterScreen);
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      left: width * 0.04,
                      right: width * 0.04,
                    ),
                    height: scaleFactor * 44,
                    width: width,
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(scaleFactor * 12),
                    ),
                    child: Transform.rotate(
                      angle: 90 * 3.1416 / 180, // rotate 90 degrees
                      child: Icon(
                        Icons.tune,
                        color: AppColors.darkGrey,
                        size: scaleFactor * 24,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: scaleFactor * 12),
      ],
    ),
  );
}
