// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/feature/home/model/expert_model.dart';
import 'package:consultz/feature/shome_me_expert/controller/show_me_expert_category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowMeExpertInterestController extends GetxController {
  final inProgress = false.obs;
  final isLoadingMore = false.obs;
  final hasMore = true.obs;
  final expertList = <ExpertData>[].obs;
  int currentPage = 1;
  final int _limit = 20;
  final ScrollController scrollController = ScrollController();

  Future<void> initialLoad() async {
    currentPage = 1;
    expertList.clear();
    hasMore.value = true;
    await getInterestExpert();
  }

  Future<void> loadMore() async {
    currentPage++;
    await getInterestExpert();
  }

  Future<bool> getInterestExpert() async {
    final categoryController = Get.find<ShowMeExpertCategoryController>();
    bool isSuccess = true;
    try {
      if (currentPage == 1) {
        inProgress.value = true;
      } else {
        isLoadingMore.value = true;
      }

      final response = await ApiCaller.getRequest(
        url: ApiUrls.showMeExpertInterest(
          page: currentPage.toString(),
          limit: _limit,
          interest: [
            ...categoryController.selectedCategoryList.map((e) => e.title ?? ''),
            ...categoryController.selectedSubCategoryList,
          ],
        ),
      );
      log([
        ...categoryController.selectedCategoryList.map((e) => e.title ?? ''),
        ...categoryController.selectedSubCategoryList
      ].join(','));
      log("${response?.responseData.toString()}");
      if (response?.statusCode == 200 && response?.isSuccess == true) {
        final expertModel = ExpertModel.fromJson(response?.responseData);
        final expertUser = expertModel.data ?? [];

        if (expertUser.isEmpty || expertUser.length < _limit) {
          hasMore.value = false;
        }
        expertList.addAll(expertUser);
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
