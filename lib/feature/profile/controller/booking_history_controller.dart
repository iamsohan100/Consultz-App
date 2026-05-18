import 'dart:developer';

import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/feature/Auth/controller/browse_first_controller.dart';
import 'package:consultz/feature/profile/model/booking_history_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingHistoryController extends GetxController {
  final inProgress = false.obs;
  final isLoadingMore = false.obs;
  final hasMore = true.obs;

  final bookingList = <BookingData>[].obs;

  int currentPage = 1;
  final int _limit = 20;
  String status = '';

  final ScrollController scrollController = ScrollController();

  final isAll = true.obs;
  final isCompleted = false.obs;
  final isPending = false.obs;
  final isCancelled = false.obs;
  final isConfirmed = false.obs;
  final isNotResponded = false.obs;

  Future<void> initialLoad({String? selectedStatus}) async {
    status = selectedStatus ?? '';
    currentPage = 1;
    bookingList.clear();
    hasMore.value = true;
    await getBookings();
  }

  Future<void> loadMore() async {
    currentPage++;
    await getBookings();
  }

  Future<bool> getBookings() async {
    bool isSuccess = true;
    try {
      if (currentPage == 1) {
        inProgress.value = true;
      } else {
        isLoadingMore.value = true;
      }

      final isConsultee = Get.find<BrowseFirstController>().isConsultee.value;
      final response = await ApiCaller.getRequest(
        url: ApiUrls.getBookings(
          isConsultee: isConsultee,
          status: status,
          page: currentPage.toString(),
          limit: _limit,
        ),
      );

      log("${response?.responseData.toString()}");

      if (response?.statusCode == 200 && response?.isSuccess == true) {
        final model = BookingHistoryModel.fromJson(response?.responseData);
        final newBookings = model.data ?? [];

        if (newBookings.isEmpty || newBookings.length < _limit) {
          hasMore.value = false;
        }

        bookingList.addAll(newBookings);
      } else {
        bottomMessage(msg: response?.message);
        isSuccess = false;
        if (currentPage > 1) currentPage--;
      }
    } catch (e) {
      bottomMessage(msg: e.toString());
      isSuccess = false;
      if (currentPage > 1) currentPage--;
    } finally {
      inProgress.value = false;
      isLoadingMore.value = false;
    }

    return isSuccess;
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
