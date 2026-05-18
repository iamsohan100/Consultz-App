import 'dart:developer';

import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/feature/expert/model/follower_and_following_data.dart';
import 'package:consultz/feature/expert/model/following_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FollowingController extends GetxController {
  final inProgress = false.obs;
  final isLoadingMore = false.obs;
  final hasMore = true.obs;
  final followingList = <FollowerAndFollowingData>[].obs;

  int currentPage = 1;
  final int limit = 20;
  final ScrollController scrollController = ScrollController();
  final searchController = TextEditingController();
  final searchTerm = ''.obs;

  Future<void> initialLoad({String? term}) async {
    currentPage = 1;
    followingList.clear();
    hasMore.value = true;
    if (term != null) {
      searchTerm.value = term;
    }
    await getFollowingUser();
  }

  Future<void> loadMore() async {
    currentPage++;
    await getFollowingUser();
  }

  Future<bool> getFollowingUser() async {
    bool isSuccess = true;
    try {
      if (currentPage == 1) {
        inProgress.value = true;
      } else {
        isLoadingMore.value = true;
      }

      final response = await ApiCaller.getRequest(
        url: ApiUrls.getMyFollowingUsers(
          page: currentPage.toString(),
          limit: limit,
          searchTerm: searchTerm.value,
        ),
      );

      log("${response?.responseData.toString()}");

      if (response?.statusCode == 200 && response?.isSuccess == true) {
        final followingModel = FollowingModel.fromJson(response?.responseData);
        final followingUser = followingModel.followingData ?? [];

        if (followingUser.isEmpty || followingUser.length < limit) {
          hasMore.value = false;
        }
        followingList.addAll(followingUser);
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
    searchController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
