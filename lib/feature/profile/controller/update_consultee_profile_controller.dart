// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/loading.dart/main_loading.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/core/utils/share_preference/auth_preference.dart';
import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateConsulteeProfileController extends GetxController {
  Rx<File?> profileImge = Rx<File?>(null);

  Future<bool> updateImage(BuildContext context) async {
    final profileController = Get.find<ProfileController>();
    bool isSuccess = true;
    if (profileImge.value == null) {
      bottomMessage(msg: 'Please select an image');
      return false;
    }
    try {
      mainLoading(context, loadingText: 'Update...');

      final response = await ApiCaller.formRequest(
        token: AuthPreference.accessToken,
        method: 'PUT',
        url: ApiUrls.updateProfile,
        files: {"image": profileImge.value},
      );
      Navigator.pop(context);
      log("${response?.responseData.toString()}");
      if (response?.statusCode == 200 && response?.isSuccess == true) {
        await profileController.getMyProfile();
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
