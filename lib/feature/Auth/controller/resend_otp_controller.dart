import 'dart:developer';

import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/loading.dart/main_loading.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResendOtpController extends GetxController {
  String? verifyToken;

  Future<bool> resendOtp(
    BuildContext context, {
    bool isMail = false,
    String? email,
    String? phone,
    bool? isUpdatePhone,
  }) async {
    bool isSuccess = true;
    try {
      mainLoading(context, loadingText: 'Sending...');

      final response = await ApiCaller.postRequest(
        url: isMail
            ? ApiUrls.sendOtpInEmail
            : isUpdatePhone==true
                ? ApiUrls.sendOtpInPhoneViaToken
                : ApiUrls.sendOtpInPhoneViaDirect,
        body: isMail ? {"email": email} : {"phoneNumber": phone},
      );
      Navigator.pop(context);
      log("${response?.responseData.toString()}");
      if (response?.statusCode == 200 && response?.isSuccess == true) {
        verifyToken = response?.responseData['data']?['token'];
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
