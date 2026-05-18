// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/loading.dart/main_loading.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/core/utils/share_preference/auth_preference.dart';
import 'package:consultz/feature/Auth/model/expert_set_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadProfilePictureController extends GetxController {
  Rx<ExpertSetProfileModel> expertSetProfileModel = ExpertSetProfileModel().obs;

  Rx<File?> profileImge = Rx<File?>(null);

  Future<bool> updateProfile(BuildContext context) async {
    bool isSuccess = true;
    // ExpertProfileSetupModel expertProfileSetupModel = ExpertProfileSetupModel(
    //   socialProfiles: socialChannels,
    // );

    try {
      mainLoading(context, loadingText: 'Continue...');

      final response = await ApiCaller.formRequest(
        token: AuthPreference.accessToken,
        method: 'PUT',
        url: ApiUrls.updateProfile,
        files: {"image": profileImge.value},

        fields: {},
      );
      Navigator.pop(context);
      log("${response?.responseData.toString()}");
      if (response?.statusCode == 200 && response?.isSuccess == true) {
        expertSetProfileModel.value = ExpertSetProfileModel.fromJson(
          response?.responseData,
        );
        if (expertSetProfileModel.value.data?.photoUrl != null) {
          await AuthPreference().saveUserImage(
            expertSetProfileModel.value.data!.photoUrl!,
          );
        }
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
