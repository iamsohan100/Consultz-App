// ignore_for_file: use_build_context_synchronously

import 'package:consultz/feature/bookings/controller/socket_service_controller.dart';
import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/loading.dart/main_loading.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/core/utils/share_preference/auth_preference.dart';
import 'package:consultz/feature/Auth/model/expert_login_model.dart';
import 'package:consultz/core/utils/helpers/notification_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:consultz/feature/Auth/controller/browse_first_controller.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'dart:developer';

class LoginController extends GetxController {
  final mailController = TextEditingController();
  final passwordController = TextEditingController();
  Rx<ExpertLoginModel> expertLoginModel = ExpertLoginModel().obs;

  Future<bool> login(BuildContext context) async {
    bool isSuccess = true;
    try {
      mainLoading(context, loadingText: 'Login...');

      final fcmToken = await NotificationHelper.getFCMToken();
      final response = await ApiCaller.postRequest(
        url: ApiUrls.login,
        body: {
          "email": mailController.text.trim(),
          "password": passwordController.text.trim(),
          "fcmToken": fcmToken ?? "",
        },
      );

      Navigator.pop(context);
      // log("${response?.responseData.toString()}");
      if (response?.statusCode == 200 && response?.isSuccess == true) {
        expertLoginModel.value = ExpertLoginModel.fromJson(
          response?.responseData,
        );
        await AuthPreference().saveLoginToken(
          logToken: expertLoginModel.value.data?.accessToken ?? '',
          logInfo: expertLoginModel.value,
        );

        // Initialize socket with new token
        await Get.find<SocketServiceController>().init();
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

  Future<bool> googleLogin(BuildContext context) async {
    try {
      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        mainLoading(context, loadingText: 'Google Login...');
        final googleAuth = await googleUser.authentication;

        String? email = googleUser.email;
        String? displayName = googleUser.displayName;
        String? token = googleAuth.idToken;
        String? photoUrl = googleUser.photoUrl;
        log('photoUrl $photoUrl');
        // Extract first and last name from display name
        List<String> nameParts = displayName?.split(' ') ?? [];
        String firstName = nameParts.isNotEmpty ? nameParts.first : "";
        String lastName = nameParts.length > 1
            ? nameParts.sublist(1).join(' ')
            : "";

        final fcmToken = await NotificationHelper.getFCMToken();

        final browseFirstController = Get.find<BrowseFirstController>();
        final role = browseFirstController.isConsultee.value
            ? "consult"
            : "expert";

        final response = await ApiCaller.postRequest(
          url: ApiUrls.googleLogin,
          body: {
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "role": role,
            "token": token,
            "fcmToken": fcmToken ?? "",
            "photoUrl": photoUrl,
          },
        );

        log("googleLoginResponse:  ${response?.responseData.toString()}");
        Navigator.pop(context);

        if (response?.statusCode == 200 && response?.isSuccess == true) {
          expertLoginModel.value = ExpertLoginModel.fromJson(
            response?.responseData,
          );
          await AuthPreference().saveLoginToken(
            logToken: expertLoginModel.value.data?.accessToken ?? '',
            logInfo: expertLoginModel.value,
          );

          // Initialize socket with new token
          await Get.find<SocketServiceController>().init();
          return true;
        } else {
          bottomMessage(msg: response?.message);
          return false;
        }
      }
    } catch (e) {
      log("Error during Google Login: $e");
      bottomMessage(msg: "Google login failed");
    }
    return false;
  }

  Future<bool> appleLogin(BuildContext context) async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      if (credential.identityToken != null) {
        mainLoading(context, loadingText: 'Apple Login...');

        String firstName = credential.givenName ?? "";
        String lastName = credential.familyName ?? "";
        String? email = credential.email;
        String? token = credential.identityToken;

        final fcmToken = await NotificationHelper.getFCMToken();
        final browseFirstController = Get.find<BrowseFirstController>();
        final role = browseFirstController.isConsultee.value
            ? "consult"
            : "expert";

        final response = await ApiCaller.postRequest(
          url: ApiUrls.appleLogin,
          body: {
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "role": role,
            "token": token,
            "fcmToken": fcmToken ?? "",
          },
        );

        Navigator.pop(context);

        if (response?.statusCode == 200 && response?.isSuccess == true) {
          expertLoginModel.value = ExpertLoginModel.fromJson(
            response?.responseData,
          );
          await AuthPreference().saveLoginToken(
            logToken: expertLoginModel.value.data?.accessToken ?? '',
            logInfo: expertLoginModel.value,
          );

          // Initialize socket with new token
          await Get.find<SocketServiceController>().init();
          return true;
        } else {
          bottomMessage(msg: response?.message);
          return false;
        }
      }
    } catch (e) {
      log("Error during Apple Login: $e");
      bottomMessage(msg: "Apple login failed");
    }
    return false;
  }
}
