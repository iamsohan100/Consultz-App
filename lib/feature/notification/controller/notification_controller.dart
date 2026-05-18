import 'dart:developer';
import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/feature/notification/model/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  final inProgress = false.obs;
  final isLoadingMore = false.obs;
  final hasMore = true.obs;
  final notificationList = <NotificationData>[].obs;
  final unreadMessageCount = 0.obs;

  int currentPage = 1;
  final int _limit = 20;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    initialLoad();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (hasMore.value && !isLoadingMore.value) {
          loadMore();
        }
      }
    });
  }

  Future<void> initialLoad() async {
    currentPage = 1;
    notificationList.clear();
    hasMore.value = true;
    await getNotifications();
  }

  Future<void> loadMore() async {
    currentPage++;
    await getNotifications();
  }

  Future<void> refreshNotifications() async {
    currentPage = 1;
    await getNotifications();
  }

  Future<bool> getNotifications() async {
    bool isSuccess = true;
    try {
      if (currentPage == 1) {
        inProgress.value = true;
      } else {
        isLoadingMore.value = true;
      }

      final response = await ApiCaller.getRequest(
        url: ApiUrls.getNotifications(
          page: currentPage.toString(),
          limit: _limit,
        ),
      );

      log("Notifications: ${response?.responseData.toString()}");

      if (response?.statusCode == 200 && response?.isSuccess == true) {
        final model = NotificationModel.fromJson(response?.responseData);
        unreadMessageCount.value = model.data?.unreadMessage ?? 0;
        final data = model.data?.notifications ?? [];

        if (currentPage == 1) {
          notificationList.clear();
        }

        if (data.isEmpty || data.length < _limit) {
          hasMore.value = false;
        }
        notificationList.addAll(data);
        notificationList.refresh();
      } else {
        bottomMessage(msg: response?.message);
        isSuccess = false;
        if (currentPage > 1) currentPage--;
      }
    } catch (e) {
      log("Error: ${e.toString()}");
      bottomMessage(msg: e.toString());
      isSuccess = false;
      if (currentPage > 1) currentPage--;
    } finally {
      inProgress.value = false;
      isLoadingMore.value = false;
    }

    return isSuccess;
  }

  Future<void> readAllNotifications() async {
    try {
      final response = await ApiCaller.patchRequest(
        url: ApiUrls.readAllNotifications,
        body: {},
      );

      if (response?.statusCode == 200 && response?.isSuccess == true) {
        unreadMessageCount.value = 0;
        for (var element in notificationList) {
          element.read = true;
        }
        notificationList.refresh();
      } else {
        bottomMessage(msg: response?.message);
      }
    } catch (e) {
      bottomMessage(msg: e.toString());
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
