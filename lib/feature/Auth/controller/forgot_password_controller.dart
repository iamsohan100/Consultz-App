import 'dart:developer';

import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/loading.dart/main_loading.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final otp = ''.obs;
  final isOtpComplete = false.obs;
  String? verifyToken;
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<bool> sendOtp(BuildContext context) async {
    bool isSuccess = true;
    try {
      mainLoading(context, loadingText: 'Sending...');

      final response = await ApiCaller.postRequest(
        url: ApiUrls.forgetPassword,
        body: {"email": emailController.text.trim()},
      );

      Navigator.pop(context);
      log("${response?.responseData.toString()}");
      if (response?.statusCode == 200 && response?.isSuccess == true) {
        verifyToken = response?.responseData['data']?['verifyToken'];
        Get.toNamed(RoutesConstant.forgotEmailVerificationScreen);
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

  Future<bool> verifyOtpAndUpdateEmail(BuildContext context) async {
    bool isSuccess = true;

    try {
      mainLoading(context, loadingText: 'Verifying...');

      final response = await ApiCaller.postRequest(
        token: verifyToken,
        url: ApiUrls.verifyOtpWithEmail,
        body: {"otp": otp.value},
      );

      Navigator.pop(context);

      log("${response?.responseData.toString()}");
      if (response?.statusCode == 200 && response?.isSuccess == true) {
        verifyToken = response?.responseData['data']?['accessToken'];
        Get.toNamed(RoutesConstant.resetPasswordScreen);
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

  Future<bool> resetPassword(BuildContext context) async {
    bool isSuccess = true;
    try {
      mainLoading(context, loadingText: 'Reset...');

      final response = await ApiCaller.postRequest(
        url: ApiUrls.resetPassword,
        token: verifyToken,
        body: {
          "email": emailController.text.trim(),
          "newPassword": passwordController.text,
          "confirmPassword": confirmPasswordController.text,
        },
      );

      Navigator.pop(context);
      log("${response?.responseData.toString()}");
      if (response?.statusCode == 200 && response?.isSuccess == true) {
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
