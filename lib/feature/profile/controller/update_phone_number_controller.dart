import 'dart:developer';

import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/loading.dart/main_loading.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/core/utils/message/top_message.dart';
import 'package:consultz/core/utils/share_preference/auth_preference.dart';
import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdatePhoneNumberController extends GetxController {
  final phoneNumberController = TextEditingController();
  final initCountryCode = '+44'.obs;
  final otp = ''.obs;
  final isOtpComplete = false.obs;
  String? verifyToken;

  Future<bool> sendOtp(BuildContext context) async {
    bool isSuccess = true;
    try {
      mainLoading(context, loadingText: 'Sending...');

      final response = await ApiCaller.postRequest(
        url: ApiUrls.sendOtpInPhoneViaToken,
        token: AuthPreference.accessToken,
        body: {
          "phoneNumber":
              "${initCountryCode.value}${phoneNumberController.text}",
        },
      );

      Navigator.pop(context);
      log("${response?.responseData.toString()}");
      if (response?.statusCode == 200 && response?.isSuccess == true) {
        verifyToken = response?.responseData['data']?['token'];
        Get.toNamed(RoutesConstant.editPhoneNumberVerifyScreen);
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

  Future<bool> verifyOtpAndUpdatePhone(BuildContext context) async {
    bool isSuccess = true;

    try {
      mainLoading(context, loadingText: 'Verify...');

      final response = await ApiCaller.postRequest(
        token: verifyToken ?? AuthPreference.accessToken,
        url: ApiUrls.verifyOtp,
        body: {"otp": otp.value},
      );

      Navigator.pop(context);

      log("${response?.responseData.toString()}");
      if (response?.statusCode == 200 && response?.isSuccess == true) {
        // According to flow, now we update the phone number
        return await updatePhoneNumber(context);
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

  Future<bool> updatePhoneNumber(BuildContext context) async {
    bool isSuccess = true;
    try {
      mainLoading(context, loadingText: 'Updating...');

      final response = await ApiCaller.putRequest(
        url: ApiUrls.updateProfile,
        body: {
          "phoneNumber":
              "${initCountryCode.value}${phoneNumberController.text}",
        },
      );

      Navigator.pop(context);
      log("${response?.responseData.toString()}");
      if (response?.statusCode == 200 && response?.isSuccess == true) {
        topMessage(title: 'Updated', msg: "Phone number updated successfully");
        await Get.find<ProfileController>().getMyProfile();
        Navigator.pop(context);
        Navigator.pop(context);
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
