// ignore_for_file: use_build_context_synchronously

import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/loading.dart/main_loading.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/feature/expert/model/terms_condition_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class TermsConditionController extends GetxController {
  Rx<TermsConditionModel> termsConditionModel = TermsConditionModel().obs;
  final inProgress = false.obs;
  Future<bool> getTermsCondition(
    BuildContext context, {
    bool isLoading = true,
  }) async {
    bool isSuccess = true;
    try {
      if (isLoading == true) {
        mainLoading(context, loadingText: 'Terms & Conditions...');
      } else {
        inProgress.value = true;
      }

      final response = await ApiCaller.getRequest(url: ApiUrls.termsCondition);
      if (isLoading == true) {
        Navigator.pop(context);
      } else {
        inProgress.value = false;
      }
      // log("${response?.responseData.toString()}");
      if (response?.statusCode == 200 && response?.isSuccess == true) {
        termsConditionModel.value = TermsConditionModel.fromJson(
          response?.responseData,
        );
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
