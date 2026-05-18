// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/feature/discover/model/content_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiscoverController extends GetxController {
  final inProgress = false.obs;
  final isLoadingMore = false.obs;
  final hasMore = true.obs;
  final contentList = <FeedList>[].obs;

  int currentPage = 1;
  final int _limit = 20;
  final ScrollController scrollController = ScrollController();

  final searchInProgress = false.obs;
  final isSearchLoadingMore = false.obs;
  final searchHasMore = true.obs;
  final searchContentList = <FeedList>[].obs;

  int searchPage = 1;
  final int _searchLimit = 20;
  final ScrollController searchScrollController = ScrollController();
  final searchController = TextEditingController();
  final searchTerm = ''.obs;

  Future<void> initialLoad() async {
    currentPage = 1;
    contentList.clear();
    hasMore.value = true;
    await getActiveContent();
  }

  Future<void> loadMore() async {
    currentPage++;
    await getActiveContent();
  }

  Future<bool> getActiveContent() async {
    bool isSuccess = true;
    try {
      if (currentPage == 1) {
        inProgress.value = true;
      } else {
        isLoadingMore.value = true;
      }

      final response = await ApiCaller.getRequest(
        url: ApiUrls.getActiveContent(
          page: currentPage.toString(),
          limit: _limit,
        ),
      );

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

  Future<void> searchInitialLoad({String? term}) async {
    searchPage = 1;
    searchContentList.clear();
    searchHasMore.value = true;
    if (term != null) searchTerm.value = term;

    if (searchTerm.value.trim().isEmpty) {
      searchInProgress.value = false;
      return;
    }

    await getSearchContent();
  }

  Future<void> searchLoadMore() async {
    searchPage++;
    await getSearchContent();
  }

  Future<bool> getSearchContent() async {
    bool isSuccess = true;
    try {
      if (searchPage == 1) {
        searchInProgress.value = true;
      } else {
        isSearchLoadingMore.value = true;
      }

      final response = await ApiCaller.getRequest(
        url: ApiUrls.getActiveContent(
          page: searchPage.toString(),
          limit: _searchLimit,
          searchTerm: searchTerm.value,
        ),
      );

      if (response?.statusCode == 200 && response?.isSuccess == true) {
        final contentModel = ContentModel.fromJson(response?.responseData);
        final content = contentModel.data?.feedList ?? [];

        if (content.isEmpty || content.length < _searchLimit) {
          searchHasMore.value = false;
        }
        searchContentList.addAll(content);
      } else {
        bottomMessage(msg: response?.message);
        isSuccess = false;
        if (searchPage > 1) searchPage--;
      }
    } catch (e) {
      bottomMessage(msg: e.toString());
      isSuccess = false;
      if (searchPage > 1) searchPage--;
    } finally {
      searchInProgress.value = false;
      isSearchLoadingMore.value = false;
    }

    return isSuccess;
  }

  Future<void> refreshFeedCount(String contentId) async {
    try {
      final response = await ApiCaller.getRequest(
        url: ApiUrls.getFeed(contentId),
      );

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

  @override
  void onClose() {
    scrollController.dispose();
    searchScrollController.dispose();
    searchController.dispose();
    super.onClose();
  }
}
