// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:consultz/core/utils/share_preference/auth_preference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/loading.dart/main_loading.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/feature/bookings/model/session_data.dart';
import 'package:consultz/feature/Auth/model/expert_set_profile_model.dart';

class ExpertSessionDurationController extends GetxController {
  Rx<ExpertSetProfileModel> expertSetProfileModel = ExpertSetProfileModel().obs;

  RxList<SessionModel> sessions = <SessionModel>[].obs;

  @override
  void onInit() {
    sessions.assignAll(SessionData.sessionList);
    super.onInit();
  }

  void toggleSession(int index) {
    sessions[index].isSelected.value = !sessions[index].isSelected.value;
  }

  bool hasAnySessionSelected() {
    return sessions.any((e) => e.isSelected.value == true);
  }

  Future<bool> updateSessionDurations(BuildContext context) async {
    bool isSuccess = true;

    try {
      mainLoading(context, loadingText: 'Continue...');

      final response = await ApiCaller.putRequest(
        token: AuthPreference.accessToken,
        url: ApiUrls.updateProfile,
        body: {
          "sessionDurations": sessions
              .map(
                (e) => {
                  "type": e.title,
                  "duration": e.duration,
                  "isOffered": e.isSelected.value,
                },
              )
              .toList(),
        },
      );

      Navigator.pop(context);
      log("${response?.responseData.toString()}");

      if (response?.statusCode == 200 && response?.isSuccess == true) {
        expertSetProfileModel.value = ExpertSetProfileModel.fromJson(
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
