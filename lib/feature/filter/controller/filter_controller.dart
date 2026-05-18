import 'dart:developer';
import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/feature/home/model/expert_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  final inProgress = false.obs;
  final isLoadingMore = false.obs;
  final hasMore = true.obs;
  final expertList = <ExpertData>[].obs;

  int currentPage = 1;
  final int _limit = 20;
  final ScrollController scrollController = ScrollController();

  // Filter States
  final priceRange = Rx<RangeValues>(const RangeValues(10, 150));
  final selectedInterests = <String>[].obs;
  final selectedLearningStyles = <String>[].obs;
  final selectedAvailability = <String>[].obs;
  final rating = 0.obs;
  final selectedSessionDurations = <int>[].obs;

  Future<void> initialLoad() async {
    currentPage = 1;
    expertList.clear();
    hasMore.value = true;
    await getFilteredExperts();
  }

  Future<void> loadMore() async {
    currentPage++;
    await getFilteredExperts();
  }

  void toggleInterest(String interest) {
    if (selectedInterests.contains(interest)) {
      selectedInterests.remove(interest);
    } else {
      selectedInterests.add(interest);
    }
  }

  void toggleLearningStyle(String style) {
    if (selectedLearningStyles.contains(style)) {
      selectedLearningStyles.remove(style);
    } else {
      selectedLearningStyles.add(style);
    }
  }

  void toggleAvailability(String day) {
    if (selectedAvailability.contains(day)) {
      selectedAvailability.remove(day);
    } else {
      selectedAvailability.add(day);
    }
  }

  void setRating(int value) {
    if (rating.value == value) {
      rating.value = 0;
    } else {
      rating.value = value;
    }
  }

  void toggleSessionDuration(int duration) {
    if (selectedSessionDurations.contains(duration)) {
      selectedSessionDurations.remove(duration);
    } else {
      selectedSessionDurations.add(duration);
    }
  }

  void resetFilters() {
    priceRange.value = const RangeValues(10, 150);
    selectedInterests.clear();
    selectedLearningStyles.clear();
    selectedAvailability.clear();
    rating.value = 0;
    selectedSessionDurations.clear();
  }

  Future<bool> getFilteredExperts() async {
    bool isSuccess = true;
    try {
      if (currentPage == 1) {
        inProgress.value = true;
      } else {
        isLoadingMore.value = true;
      }

      final response = await ApiCaller.getRequest(
        url: ApiUrls.getFilteredExperts(
          page: currentPage.toString(),
          limit: _limit,
          priceRange:
              "${priceRange.value.start.toInt()}-${priceRange.value.end.toInt()}",
          interests: selectedInterests.isEmpty ? null : selectedInterests.join(','),
          learningStyles: selectedLearningStyles.isEmpty ? null : selectedLearningStyles.join(','),
          availability:
              selectedAvailability.isEmpty ? null : selectedAvailability.join(','),
          rating: rating.value == 0 ? null : rating.value.toString(),
          sessionDurations: selectedSessionDurations.isEmpty
              ? null
              : selectedSessionDurations.join(','),
        ),
      );

      log("Filter Response: ${response?.responseData.toString()}");

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
    super.onClose();
  }
}
