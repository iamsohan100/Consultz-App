// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/loading.dart/main_loading.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateNameController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final jobRoleController = TextEditingController();

  Future<bool> updateName(BuildContext context) async {
    bool isSuccess = true;
    try {
      mainLoading(context, loadingText: 'Change...');

      final response = await ApiCaller.putRequest(
        url: ApiUrls.updateProfile,
        body: {
          "firstName": firstNameController.text.trim(),
          "lastName": lastNameController.text.trim(),
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


  Future<bool> updateJobRole(BuildContext context) async {
    bool isSuccess = true;
    try {
      mainLoading(context, loadingText: 'Change...');

      final response = await ApiCaller.putRequest(
        url: ApiUrls.updateProfile,
        body: {
          "headline": jobRoleController.text.trim(),
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
