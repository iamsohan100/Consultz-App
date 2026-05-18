// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/feature/home/model/expert_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchExpertController extends GetxController {
  final inProgress = false.obs;
  final isLoadingMore = false.obs;
  final hasMore = true.obs;
  final expertList = <ExpertData>[].obs;
  
  int currentPage = 1;
  final int _limit = 20;
  final ScrollController scrollController = ScrollController();
  final searchController = TextEditingController();
  final searchTerm = ''.obs;

  Future<void> initialLoad({String? term}) async {
    currentPage = 1;
    expertList.clear();
    hasMore.value = true;
    if (term != null) searchTerm.value = term;

    if (searchTerm.value.trim().isEmpty) {
      inProgress.value = false;
      return;
    }

    await getExperts();
  }

  Future<void> loadMore() async {
    currentPage++;
    await getExperts();
  }

  Future<bool> getExperts() async {
    bool isSuccess = true;
    try {
      if (currentPage == 1) {
        inProgress.value = true;
      } else {
        isLoadingMore.value = true;
      }

      final response = await ApiCaller.getRequest(
        url: ApiUrls.getExperts(
          page: currentPage.toString(),
          limit: _limit,
          searchTerm: searchTerm.value,
        ),
      );

      log("${response?.responseData.toString()}");

      if (response?.statusCode == 200 && response?.isSuccess == true) {
        final expertModel = ExpertModel.fromJson(response?.responseData);
        final experts = expertModel.data ?? [];

        if (experts.isEmpty || experts.length < _limit) {
          hasMore.value = false;
        }
        expertList.addAll(experts);
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
    searchController.dispose();
    super.onClose();
  }
}
