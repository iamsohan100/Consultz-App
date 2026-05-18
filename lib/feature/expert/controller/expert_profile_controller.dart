// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/feature/expert/model/expert_profile_model.dart';
import 'package:get/get.dart';

class ExpertProfileController extends GetxController {
  final inProgress = false.obs;
  Rx<ExpertProfileModel> expertProfileModel = ExpertProfileModel().obs;

  Future<bool> getExpertProfile({required String id}) async {
    bool isSuccess = true;
    try {
      inProgress.value = true;

      final response = await ApiCaller.getRequest(
        url: ApiUrls.getExpertProfile(id),
      );

      inProgress.value = false;
      log("${response?.responseData.toString()}");
      if (response?.statusCode == 200 && response?.isSuccess == true) {
        expertProfileModel.value = ExpertProfileModel.fromJson(
          response?.responseData,
        );
        log("message2");
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
}
