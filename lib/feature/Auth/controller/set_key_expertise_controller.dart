// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/loading.dart/main_loading.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/core/utils/share_preference/auth_preference.dart';
import 'package:consultz/feature/Auth/model/all_category_model.dart';
import 'package:consultz/feature/Auth/model/expert_set_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetKeyExpertiseController extends GetxController {
  Rx<ExpertSetProfileModel> expertSetProfileModel = ExpertSetProfileModel().obs;
  Rx<AllCategoryModel> allCategoryModel = AllCategoryModel().obs;
  // Rx<CategoryModel> categoryModel = CategoryModel().obs;
  RxList<AllCategoryData> allCategoryList = <AllCategoryData>[].obs;
  final selectedExpertise = AllCategoryData().obs;
  RxList<AllCategoryData> selectedCategoryList = <AllCategoryData>[].obs;
  RxList<String> subCategoryItems = <String>[].obs;
  final inProgress = false.obs;

  Future<bool> getAllCategory(
    BuildContext context, {
    bool isLoading = true,
  }) async {
    bool isSuccess = true;
    try {
      allCategoryList.clear();
      if (isLoading == true) {
        mainLoading(context, loadingText: 'Continue...');
      } else {
        inProgress.value = true;
      }

      final response = await ApiCaller.getRequest(url: ApiUrls.getAllCategory);
      if (isLoading == true) {
        Navigator.pop(context);
      } else {
        inProgress.value = false;
      }

      if (response?.statusCode == 200 && response?.isSuccess == true) {
        final model = AllCategoryModel.fromJson(response?.responseData);

        allCategoryList.addAll(model.data ?? []);
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

  Future<bool> updateExpertise(BuildContext context) async {
    bool isSuccess = true;
    try {
      mainLoading(context, loadingText: 'Continue...');
      final response = await ApiCaller.putRequest(
        token: AuthPreference.accessToken,
        url: ApiUrls.updateProfile,
        body: {
          "expertise": selectedCategoryList.map((e) => e.title).toList(),
        },
      );
      Navigator.pop(context);
      log("${response?.responseData.toString()}");
      if (response?.statusCode == 200 && response?.isSuccess == true) {
        expertSetProfileModel.value = ExpertSetProfileModel.fromJson(
          response?.responseData,
        );
        loadCategoryItems();
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

  void loadCategoryItems() {
    subCategoryItems.clear();
    for (final item in selectedCategoryList) {
      subCategoryItems.addAll(item.items ?? []);
    }
  }
}
