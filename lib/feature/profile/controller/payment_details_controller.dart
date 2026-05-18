import 'dart:developer';
import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/loading.dart/main_loading.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/feature/profile/model/my_cards_response_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentDetailsController extends GetxController {
  final inProgress = false.obs;
  final isLoadingMore = false.obs;
  final hasMore = true.obs;
  final cardList = <CardDataModel>[].obs;
  Rx<MyCardsResponseModel> myCardsResponseModel = MyCardsResponseModel().obs;

  int currentPage = 1;
  final int _limit = 20;
  final ScrollController scrollController = ScrollController();

  Future<void> initialLoad() async {
    currentPage = 1;
    cardList.clear();
    hasMore.value = true;
    await getMyCards();
  }

  Future<void> loadMore() async {
    currentPage++;
    await getMyCards();
  }

  Future<void> getMyCards() async {
    try {
      if (currentPage == 1) {
        inProgress.value = true;
      } else {
        isLoadingMore.value = true;
      }

      final response = await ApiCaller.getRequest(
        url: ApiUrls.getCards(page: currentPage.toString(), limit: _limit),
      );

      if (response?.statusCode == 200 && response?.isSuccess == true) {
        myCardsResponseModel.value = MyCardsResponseModel.fromJson(
          response?.responseData,
        );
        final cards = myCardsResponseModel.value.data ?? [];

        // Sort: Default card at the top
        cards.sort((a, b) {
          if (a.setAsDefault == true && b.setAsDefault != true) return -1;
          if (a.setAsDefault != true && b.setAsDefault == true) return 1;
          return 0;
        });

        if (cards.isEmpty || cards.length < _limit) {
          hasMore.value = false;
        }
        cardList.addAll(cards);
      } else {
        log("Failed to fetch cards: ${response?.message}");
        if (currentPage > 1) currentPage--;
      }
    } catch (e) {
      log("Error fetching cards: $e");
      if (currentPage > 1) currentPage--;
    } finally {
      inProgress.value = false;
      isLoadingMore.value = false;
    }
  }

  Future<bool> deleteCard(BuildContext context, String cardId) async {
    bool isSuccess = true;
    try {
      mainLoading(context, loadingText: 'Deleting...');

      final response = await ApiCaller.deleteRequest(
        url: ApiUrls.deleteCard(cardId),
      );

      Navigator.pop(context);

      if (response?.statusCode == 200 && response?.isSuccess == true) {
        cardList.removeWhere((card) => card.sId == cardId);
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

  Future<bool> setDefaultCard(BuildContext context, String cardId) async {
    bool isSuccess = true;
    try {
      mainLoading(context, loadingText: 'Set default...');

      final response = await ApiCaller.patchRequest(
        url: ApiUrls.setDefaultCard(cardId),
        body: {},
      );

      Navigator.pop(context);

      if (response?.statusCode == 200 && response?.isSuccess == true) {
        await initialLoad();
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
