import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/widgets/no_data.dart';
import 'package:consultz/feature/notification/controller/notification_controller.dart';
import 'package:consultz/feature/notification/widgets/notification_app_bar.dart';
import 'package:consultz/feature/notification/widgets/notification_container.dart';
import 'package:consultz/feature/notification/widgets/notification_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final controller = Get.find<NotificationController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.readAllNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    return Scaffold(
      appBar: notificationAppBar(context),
      body: RefreshIndicator(
        onRefresh: () => controller.initialLoad(),
        child: SafeArea(
          child: Obx(() {
            if (controller.inProgress.value) {
              return const NotificationShimmer();
            }
            if (controller.notificationList.isEmpty) {
              return Column(
                children: [
                  SizedBox(height: height * 0.2),
                  Icon(
                    Icons.notifications_off_outlined,
                    color: AppColors.grey,
                    size: scaleFactor * 50,
                  ),
                  NoData(text: "No notifications found"),
                ],
              );
            }
            return ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: controller.scrollController,
              itemCount:
                  controller.notificationList.length +
                  (controller.isLoadingMore.value ? 1 : 0),
              itemBuilder: (_, index) {
                if (index < controller.notificationList.length) {
                  return NotificationContainer(
                    notificationData: controller.notificationList[index],
                  );
                } else {
                  return const NotificationShimmer(length: 1);
                }
              },
              separatorBuilder: (context, index) {
                return Divider(color: AppColors.midGrey, thickness: 0.5);
              },
            );
          }),
        ),
      ),
    );
  }
}
