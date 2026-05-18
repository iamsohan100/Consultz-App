// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/loading.dart/main_loading.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/core/utils/share_preference/auth_preference.dart';
import 'package:consultz/feature/Auth/model/expert_set_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetBankController extends GetxController {
  Rx<ExpertSetProfileModel> expertSetProfileModel = ExpertSetProfileModel().obs;
  final isConnected = false.obs;
  Future<String?> connectStripe(BuildContext context) async {
    String? url;

    try {
      mainLoading(context, loadingText: 'Loading...');

      final response = await ApiCaller.postRequest(
        token: AuthPreference.accessToken,
        url: ApiUrls.connectStripe,
        body: {},
      );
      Navigator.pop(context);

      log("${response?.responseData.toString()}");

      if (response?.statusCode == 200 && response?.isSuccess == true) {
        url = response?.responseData['data'];
      } else {
        bottomMessage(msg: response?.message);
      }
    } catch (e) {
      Navigator.pop(context);
      bottomMessage(msg: e.toString());
    }

    return url;
  }

  Future<bool> checkStripe(BuildContext context) async {
    bool isSuccess = true;

    try {
      mainLoading(context, loadingText: 'Loading...');

      final response = await ApiCaller.getRequest(url: ApiUrls.checkStripe);
      Navigator.pop(context);

      log("${response?.responseData.toString()}");

      if (response?.statusCode == 200 && response?.isSuccess == true) {
        isConnected.value = response?.responseData['data']['isConnected'];
      } else {
        bottomMessage(msg: response?.message);
        isSuccess = false;
      }
    } catch (e) {
      Navigator.pop(context);
      bottomMessage(msg: e.toString());
      isSuccess = false;
    }

    return isSuccess;
  }
}
