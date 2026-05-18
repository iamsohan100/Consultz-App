// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/feature/expert/model/expert_review_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpertReviewController extends GetxController {
  final inRatingProgress = false.obs;
  Rx<RatingBreakdown?> ratingBreakDown = Rx<RatingBreakdown?>(null);
  final totalReviews = 0.obs;
  final inReviewProgress = false.obs;
  final isLoadingMore = false.obs;
  final hasMore = true.obs;

  final reviewList = <Reviews>[].obs;

  int currentPage = 1;
  final int _limit = 20;
  String expertId = '';
  String sort = 'latest';
  final ScrollController scrollController = ScrollController();

  Future<void> initialLoad({String sor = 'latest'}) async {
    sort = sor; // ✅ update sort
    currentPage = 1;
    reviewList.clear();
    hasMore.value = true;
    await getReview();
  }

  Future<void> loadMore() async {
    currentPage++;
    await getReview();
  }

  Future<bool> getReview() async {
    bool isSuccess = true;
    try {
      if (currentPage == 1) {
        inReviewProgress.value = true;
      } else {
        isLoadingMore.value = true;
      }

      final response = await ApiCaller.getRequest(
        url: ApiUrls.getReviews(
          id: expertId,
          page: currentPage.toString(),
          limit: _limit,
          sort: sort, 
        ),
      );

      log("${response?.responseData.toString()}");

      if (response?.statusCode == 200 && response?.isSuccess == true) {
        final model = ExpertReviewModel.fromJson(response?.responseData);
        final newReviews = model.data?.reviews ?? [];

        if (newReviews.isEmpty || newReviews.length < _limit) {
          hasMore.value = false;
        }

        reviewList.addAll(newReviews);
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
      inReviewProgress.value = false;
      isLoadingMore.value = false;
    }

    return isSuccess;
  }

  Future<bool> getRating({required String expertId}) async {
    bool isSuccess = true;
    try {
      inRatingProgress.value = true;

      final response = await ApiCaller.getRequest(
        url: ApiUrls.getReviews(id: expertId, page: "1", limit: 10),
      );

      inRatingProgress.value = false;
      log("${response?.responseData.toString()}");
      if (response?.statusCode == 200 && response?.isSuccess == true) {
        ratingBreakDown.value = RatingBreakdown.fromJson(
          response?.responseData['data']['ratingBreakdown'],
        );
        totalReviews.value = response?.responseData['meta']['total'];
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
