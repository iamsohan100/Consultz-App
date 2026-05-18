// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/loading.dart/main_loading.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/feature/profile/model/blocked_user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlockedUserController extends GetxController {
  final inProgress = false.obs;
  final isLoadingMore = false.obs;
  final hasMore = true.obs;
  final blockedList = <BlockedUserData>[].obs;

  int currentPage = 1;
  final int _limit = 20;
  final ScrollController scrollController = ScrollController();

  Future<void> initialLoad() async {
    currentPage = 1;
    blockedList.clear();
    hasMore.value = true;
    await getBlockedUser();
  }

  Future<void> loadMore() async {
    currentPage++;
    await getBlockedUser();
  }

  Future<bool> getBlockedUser() async {
    bool isSuccess = true;
    try {
      if (currentPage == 1) {
        inProgress.value = true;
      } else {
        isLoadingMore.value = true;
      }

      final response = await ApiCaller.getRequest(
        url: ApiUrls.getBlockedUsers(
          page: currentPage.toString(),
          limit: _limit,
        ),
      );

      log("${response?.responseData.toString()}");

      if (response?.statusCode == 200 && response?.isSuccess == true) {
        final blockedUserModel = BlockedUserModel.fromJson(
          response?.responseData,
        );
        final blockedUser = blockedUserModel.data ?? [];

        if (blockedUser.isEmpty || blockedUser.length < _limit) {
          hasMore.value = false;
        }
        blockedList.addAll(blockedUser);
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

  Future<bool> unblockedUser(
    BuildContext context, {
    required String userId,
    bool isBlock = false,
  }) async {
    bool isSuccess = true;
    try {
      mainLoading(context, loadingText: isBlock ? 'Blocking...' : 'Unblock...');

      final response = await ApiCaller.postRequest(
        url: isBlock 
            ? ApiUrls.profileBlock(userId) 
            : ApiUrls.profileUnblock(userId),
        body: {},
      );

      Navigator.pop(context);
      log("${response?.responseData.toString()}");
      if (response?.statusCode == 200 && response?.isSuccess == true) {
        if (!isBlock) {
          blockedList.removeWhere((user) => user.sId == userId);
        }
      } else {
        bottomMessage(msg: response?.message);
        isSuccess = false;
      }
    } catch (e) {
      bottomMessage(msg: e.toString());
      isSuccess = false;
    }

    return isSuccess;
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
