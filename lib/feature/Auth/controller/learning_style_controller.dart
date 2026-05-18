// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/loading.dart/main_loading.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/core/utils/share_preference/auth_preference.dart';
import 'package:consultz/feature/Auth/controller/login_controller.dart';
import 'package:consultz/feature/Auth/controller/sign_up_controller.dart';
import 'package:consultz/feature/Auth/model/expert_set_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LearningStyleController extends GetxController {
  Rx<ExpertSetProfileModel> expertSetProfileModel = ExpertSetProfileModel().obs;

  RxList<String> selectedLearningStyles = <String>[].obs;
  Future<bool> setLearningStyle(BuildContext context) async {
    bool isSuccess = true;

    try {
      mainLoading(context, loadingText: 'Continue...');

      final response = await ApiCaller.putRequest(
        token: AuthPreference.accessToken,
        url: ApiUrls.updateProfile,
        body: {
          "learningStyles": selectedLearningStyles,
          'isProfileSetup': true,
        },
      );
      Navigator.pop(context);
      log("${response?.responseData.toString()}");
      if (response?.statusCode == 200 && response?.isSuccess == true) {
        expertSetProfileModel.value = ExpertSetProfileModel.fromJson(
          response?.responseData,
        );

        if (AuthPreference.logInToken != null) {
          // ── Social Login flow: token আছে → Update local status & Role ──
          if (AuthPreference.logInInfo?.data?.user != null) {
            AuthPreference.logInInfo!.data!.user!.isProfileSetup = true;
            // Save updated info to local storage
            await AuthPreference().saveLoginToken(
              logToken: AuthPreference.logInToken,
              logInfo: AuthPreference.logInInfo,
            );
          }
        } else {
          final signUpController = Get.find<SignUpController>();
          final loginController = Get.isRegistered<LoginController>()
              ? Get.find<LoginController>()
              : Get.put(LoginController());

          loginController.mailController.text = signUpController
              .confirmEmailController
              .text
              .trim();
          loginController.passwordController.text =
              signUpController.passwordController.text;

          final loginSuccess = await loginController.login(context);
          if (!loginSuccess) isSuccess = false;
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
