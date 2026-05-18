import 'package:badges/badges.dart' as badges;
import 'package:consultz/feature/notification/controller/notification_controller.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationBell extends StatelessWidget {
  const NotificationBell({super.key});

  @override
  Widget build(BuildContext context) {
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final controller = Get.find<NotificationController>();

    return Obx(() {
      final unreadCount = controller.unreadMessageCount.value;
      return badges.Badge(
        position: badges.BadgePosition.topEnd(top: 4, end: 7),
        showBadge: unreadCount > 0,
        badgeContent: CustomText(
          text: unreadCount.toString(),
          color: AppColors.white,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
        badgeStyle: badges.BadgeStyle(
          badgeColor: AppColors.primaryColor,
          borderSide: BorderSide(color: AppColors.white),
        ),
        child: IconButton(
          color: AppColors.darkGrey,
          icon: Icon(Icons.notifications, size: scaleFactor * 25),
          onPressed: () {
            Get.toNamed(RoutesConstant.notificationScreen);
          },
        ),
      );
    });
  }
}
