// ignore_for_file: use_build_context_synchronously
import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/loading.dart/main_loading.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/feature/Auth/model/all_category_model.dart';
import 'package:consultz/feature/Auth/model/expert_set_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowMeExpertCategoryController extends GetxController {
  Rx<ExpertSetProfileModel> expertSetProfileModel = ExpertSetProfileModel().obs;
  Rx<AllCategoryModel> allCategoryModel = AllCategoryModel().obs;
  // Rx<CategoryModel> categoryModel = CategoryModel().obs;
  RxList<AllCategoryData> allCategoryList = <AllCategoryData>[].obs;
  final selectedExpertise = AllCategoryData(
    sId: '0',
    title: 'Select your category',
  ).obs;
  RxList<AllCategoryData> selectedCategoryList = <AllCategoryData>[].obs;
  RxList<String> subCategoryItems = <String>[].obs;
  final selectedSubCategory = 'Select your sub-category'.obs;
  RxList<String> selectedSubCategoryList = <String>[].obs;
  RxList<String> selectedLearningStyleList = <String>[].obs;


  Future<bool> getAllCategory(BuildContext context) async {
    bool isSuccess = true;
    try {
      allCategoryList.clear();

      mainLoading(context, loadingText: 'Continue...');

      final response = await ApiCaller.getRequest(url: ApiUrls.getAllCategory);
      Navigator.pop(context);

      if (response?.statusCode == 200 && response?.isSuccess == true) {
        final model = AllCategoryModel.fromJson(response?.responseData);

        // insert default first
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

  void loadCategoryItems() {
    subCategoryItems.clear();
    for (final item in selectedCategoryList) {
      subCategoryItems.addAll(item.items ?? []);
    }
  }
}
