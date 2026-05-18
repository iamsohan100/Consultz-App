// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/loading.dart/main_loading.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/feature/discover/model/content_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContentController extends GetxController {
  final inProgress = false.obs;
  final isLoadingMore = false.obs;
  final hasMore = true.obs;
  final contentList = <FeedList>[].obs;
  final userId = ''.obs;
  int currentPage = 1;
  final int _limit = 20;
  final ScrollController scrollController = ScrollController();

  Future<void> initialLoad() async {
    currentPage = 1;
    contentList.clear();
    hasMore.value = true;
    await getMyContent();
  }

  Future<void> loadMore() async {
    currentPage++;
    await getMyContent();
  }

  Future<bool> getMyContent() async {
    bool isSuccess = true;
    try {
      if (currentPage == 1) {
        inProgress.value = true;
      } else {
        isLoadingMore.value = true;
      }

      final response = await ApiCaller.getRequest(
        url: ApiUrls.getMyContent(
          id: userId.value,
          page: currentPage.toString(),
          limit: _limit,
        ),
      );

      log("${response?.responseData.toString()}");

      if (response?.statusCode == 200 && response?.isSuccess == true) {
        final contentModel = ContentModel.fromJson(response?.responseData);
        final content = contentModel.data?.feedList ?? [];

        if (content.isEmpty || content.length < _limit) {
          hasMore.value = false;
        }
        contentList.addAll(content);
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

  Future<void> refreshFeedCount(String contentId) async {
    try {
      final response = await ApiCaller.getRequest(
        url: ApiUrls.getFeed(contentId),
      );

      log('Feed refresh response: ${response?.responseData}');

      if (response?.statusCode == 200 && response?.isSuccess == true) {
        final updatedFeed = FeedList.fromJson(response?.responseData['data']);
        final index = contentList.indexWhere((f) => f.sId == contentId);
        if (index != -1) {
          contentList[index] = updatedFeed;
          contentList.refresh();
        }
      }
    } catch (e) {
      log('Feed refresh error: $e');
    }
  }

  Future<void> deleteContent({
    required BuildContext context,
    required String contentId,
  }) async {
    try {
      mainLoading(context, loadingText: 'Deleting...');
      final response = await ApiCaller.deleteRequest(
        url: ApiUrls.deleteFeed(contentId),
      );

      if (response?.statusCode == 200 && response?.isSuccess == true) {
        contentList.removeWhere((f) => f.sId == contentId);
        contentList.refresh();
        bottomMessage(msg: 'Post deleted successfully');
        Navigator.pop(context);
      } else {
        bottomMessage(msg: response?.message ?? 'Failed to delete post');
      }
    } catch (e) {
      log('Delete feed error: $e');
      bottomMessage(msg: 'An error occurred while deleting the post');
    } finally {
      Navigator.pop(context);
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
