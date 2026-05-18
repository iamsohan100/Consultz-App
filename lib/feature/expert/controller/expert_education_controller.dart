// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/loading.dart/main_loading.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpertEducationController extends GetxController {
  final degreeController = TextEditingController();
  final certificationController = TextEditingController();
  final phdController = TextEditingController();

  Future<bool> updateEducation(BuildContext context) async {
    bool isSuccess = true;
    try {
      mainLoading(context, loadingText: 'Save...');

      final response = await ApiCaller.putRequest(
        url: ApiUrls.updateProfile,
        body: {
          "education": {
            "degree": degreeController.text.trim(),
            "certificate": [certificationController.text.trim()],
            "phd": phdController.text.trim(),
          },
        },
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
}
