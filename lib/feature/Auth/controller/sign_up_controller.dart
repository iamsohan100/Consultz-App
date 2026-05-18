// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/loading.dart/main_loading.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/core/utils/share_preference/auth_preference.dart';
import 'package:consultz/feature/Auth/controller/browse_first_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final termsAndConditionCheckBox = false.obs;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final confirmEmailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final referralController = TextEditingController();
  final initCountryCode = '+44'.obs;
  final isOtpComplete = false.obs;
  final otp = ''.obs;
  String? verifyToken;
  @override
  void onInit() {
    super.onInit();
    if (AuthPreference.pendingReferralCode != null) {
      referralController.text = AuthPreference.pendingReferralCode!;
    }
  }

  Future<bool> signUP(BuildContext context) async {
    bool isSuccess = true;
    final browseFirstController = Get.find<BrowseFirstController>();
    try {
      mainLoading(context, loadingText: 'Verify...');

      final response = await ApiCaller.postRequest(
        url: ApiUrls.register,
        body: {
          "firstName": firstNameController.text.trim(),
          "lastName": lastNameController.text.trim(),
          "dob": dateOfBirthController.text.trim(),
          "email": confirmEmailController.text.trim(),
          if (!browseFirstController.isConsultee.value) "role": "expert",

          "password": passwordController.text,
          "confirmPass": confirmPassController.text.trim(),
          "phoneNumber":
              "${initCountryCode.value}${phoneNumberController.text}",
          if (referralController.text.trim().isNotEmpty)
            "referralCode": referralController.text.trim(),
        },
      );

      Navigator.pop(context);
      log("${response?.responseData.toString()}");
      if (response?.statusCode == 201 && response?.isSuccess == true) {
        verifyToken = response?.responseData['data']['otpToken']['token'];
        await AuthPreference().saveLoginToken(
          token: response?.responseData['data']['otpToken']['token'],
        );
        // Clear referral code after success
        await AuthPreference().clearReferralCode();
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

  Future<bool> verifySignUpOtp(BuildContext context) async {
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
        await AuthPreference().saveLoginToken(
          token: response?.responseData['data']['accessToken'],
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
