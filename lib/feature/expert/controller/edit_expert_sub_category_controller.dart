// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/loading.dart/main_loading.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:consultz/feature/Auth/controller/set_key_expertise_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditExpertSubCategoryController extends GetxController {
  final List<String> selectedSubCategoryList = <String>[].obs;
  final allSubCategories = <String>[].obs;
  Future<bool> updateSubCategory(BuildContext context) async {
    bool isSuccess = true;
    try {
      mainLoading(context, loadingText: 'Done...');
      final response = await ApiCaller.putRequest(
        url: ApiUrls.updateProfile,
        body: {"skills": selectedSubCategoryList},
      );
      Navigator.pop(context);
      log("${response?.responseData.toString()}");
      if (response?.statusCode == 200 && response?.isSuccess == true) {
        await Get.find<ProfileController>().getMyProfile();
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



  void getItemsForSelectedCategories() {
    final profileController = Get.find<ProfileController>();
    final  setKeyExpertiseController = Get.find<SetKeyExpertiseController>();
    final allCategories = setKeyExpertiseController.allCategoryList;
    final selectedCategories = profileController.expertProfileModel.value.data?.expertise ?? [];
    allSubCategories.clear();
    List<String> filteredItems = [];

    for (var category in allCategories) {
      if (selectedCategories.contains(category.title)) {
        filteredItems.addAll(category.items ?? []);
      }
    }

    allSubCategories.addAll(filteredItems);
  }
}
