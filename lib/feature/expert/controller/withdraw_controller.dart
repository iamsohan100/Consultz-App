// lib/feature/expert/controller/withdraw_controller.dart

import 'dart:developer';
import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/feature/expert/model/withdraw_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WithdrawController extends GetxController {
  final inProgress = false.obs;
  final isLoadingMore = false.obs;
  final hasMore = true.obs;

  final withdrawItems = <WithdrawItem>[].obs;
  final withdrawOverview = <WithdrawOverview>[].obs;
  final thisMonthWithdraw = 0.0.obs;

  final selectedYear = DateTime.now().year.toString().obs;
  final availableYears = <String>[];

  int currentPage = 1;
  final int _limit = 20;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    _generateYears();
    initialLoad(selectedYear.value);
    scrollController.addListener(_scrollListener);
  }

  void _generateYears() {
    int currentYear = DateTime.now().year;
    for (int i = 0; i < 5; i++) {
      availableYears.add((currentYear - i).toString());
    }
  }

  void _scrollListener() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200 &&
        !isLoadingMore.value &&
        hasMore.value) {
      loadMore();
    }
  }

  Future<void> initialLoad(String year) async {
    selectedYear.value = year;
    currentPage = 1;
    withdrawItems.clear();
    withdrawOverview.clear();
    hasMore.value = true;
    await _fetchWithdraws();
  }

  Future<void> loadMore() async {
    currentPage++;
    await _fetchWithdraws();
  }

  Future<void> _fetchWithdraws() async {
    try {
      if (currentPage == 1) {
        inProgress.value = true;
      } else {
        isLoadingMore.value = true;
      }

      final response = await ApiCaller.getRequest(
        url: ApiUrls.getWithdraws(
          year: selectedYear.value,
          page: currentPage.toString(),
          limit: _limit,
        ),
      );

      log('Withdraws response: ${response?.responseData}');

      if (response?.statusCode == 200 && response?.isSuccess == true) {
        final model = WithdrawResponseModel.fromJson(response?.responseData);

        // Update overview only on first load
        if (currentPage == 1) {
          thisMonthWithdraw.value =
              model.data?.thisMonthWithdraw?.toDouble() ?? 0.0;
          withdrawOverview.assignAll(model.data?.withdrawOverview ?? []);
        }

        final list = model.data?.withdrawList ?? [];
        if (list.isEmpty || list.length < _limit) hasMore.value = false;
        withdrawItems.addAll(list);
      } else {
        bottomMessage(msg: response?.message);
        if (currentPage > 1) currentPage--;
      }
    } catch (e) {
      log('Error fetching withdraws: $e');
      bottomMessage(msg: 'Failed to load withdraws');
      if (currentPage > 1) currentPage--;
    } finally {
      inProgress.value = false;
      isLoadingMore.value = false;
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
