import 'dart:convert';
import 'dart:developer';

import 'package:consultz/core/utils/share_preference/key_constant.dart';
import 'package:consultz/feature/Auth/model/expert_login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPreference {
  static String? accessToken;
  static String? logInToken;
  static ExpertLoginModel? logInInfo;
  static bool? isReferralDialogShown;
  static String? cachedUserName;
  static String? cachedUserImage;
  static String? pendingReferralCode;
  static bool? isExpertDetailShowcaseShown;
  static bool? isDiscoverShowcaseShown;
  static bool? isHomeShowcaseShown;
  Future<void> saveLoginToken({
    String? token,
    String? logToken,
    ExpertLoginModel? logInfo,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (token != null) {
      await sharedPreferences.setString(KeyConstant.accessToken, token);
    } else {
      await sharedPreferences.remove(KeyConstant.accessToken);
    }
    if (logToken != null) {
      await sharedPreferences.setString(KeyConstant.logInToken, logToken);
    } else {
      await sharedPreferences.remove(KeyConstant.logInToken);
    }
    if (logInfo != null) {
      await sharedPreferences.setString(
        KeyConstant.logInInfo,
        jsonEncode(logInfo.toJson()),
      );
    } else {
      await sharedPreferences.remove(KeyConstant.logInInfo);
    }

    logInInfo = logInfo;
    logInToken = logToken;
    accessToken = token;

    if (logInfo?.data?.user != null) {
      final String firstName = logInfo!.data!.user!.firstName ?? '';
      final String lastName = logInfo.data!.user!.lastName ?? '';
      cachedUserName = '$firstName $lastName'.trim();
      if (cachedUserName!.isNotEmpty) {
        await sharedPreferences.setString(
          KeyConstant.cachedUserName,
          cachedUserName!,
        );
      }
    }

    log("logInToken: $logInToken");
  }

  Future<void> saveUserImage(String image) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(KeyConstant.cachedUserImage, image);
    cachedUserImage = image;
  }

  Future<void> saveUserName(String name) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(KeyConstant.cachedUserName, name);
    cachedUserName = name;
  }

  Future<void> updateUserStatus(String newStatus) async {
    if (logInInfo?.data?.user != null) {
      logInInfo!.data!.user!.status = newStatus;

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString(
        KeyConstant.logInInfo,
        jsonEncode(logInInfo!.toJson()),
      );
    }
  }

  Future<void> setReferralDialogShown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(KeyConstant.referralDialogShown, true);
    isReferralDialogShown = true;
  }

  Future<bool?> getReferralDialogShown() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(KeyConstant.referralDialogShown) ?? false;
  }

  Future<void> setExpertDetailShowcaseShown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(KeyConstant.expertDetailShowcaseShown, true);
    isExpertDetailShowcaseShown = true;
  }

  Future<bool?> getExpertDetailShowcaseShown() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(KeyConstant.expertDetailShowcaseShown) ?? false;
  }

  Future<void> setDiscoverShowcaseShown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(KeyConstant.discoverShowcaseShown, true);
    isDiscoverShowcaseShown = true;
  }

  Future<bool?> getDiscoverShowcaseShown() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(KeyConstant.discoverShowcaseShown) ?? false;
  }

  Future<void> setHomeShowcaseShown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(KeyConstant.homeShowcaseShown, true);
    isHomeShowcaseShown = true;
  }

  Future<bool?> getHomeShowcaseShown() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(KeyConstant.homeShowcaseShown) ?? false;
  }

  Future<String?> _getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(KeyConstant.accessToken);
  }

  Future<String?> _getLoginToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(KeyConstant.logInToken);
  }

  Future<ExpertLoginModel?> _getLoginInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String? response = sharedPreferences.getString(KeyConstant.logInInfo);
    if (response == null || response == "null") {
      return null;
    } else {
      return ExpertLoginModel.fromJson(jsonDecode(response));
    }
  }

  Future<void> initializeToken() async {
    accessToken = await _getToken();
    logInInfo = await _getLoginInfo();
    logInToken = await _getLoginToken();
    isReferralDialogShown = await getReferralDialogShown();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    cachedUserName = sharedPreferences.getString(KeyConstant.cachedUserName);
    cachedUserImage = sharedPreferences.getString(KeyConstant.cachedUserImage);
    pendingReferralCode =
        sharedPreferences.getString(KeyConstant.pendingReferralCode);
    isExpertDetailShowcaseShown =
        sharedPreferences.getBool(KeyConstant.expertDetailShowcaseShown) ??
            false;
    isDiscoverShowcaseShown =
        sharedPreferences.getBool(KeyConstant.discoverShowcaseShown) ?? false;
    isHomeShowcaseShown =
        sharedPreferences.getBool(KeyConstant.homeShowcaseShown) ?? false;

    log("logInToken: $logInToken");
  }

  Future<void> saveReferralCode(String code) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(KeyConstant.pendingReferralCode, code);
    pendingReferralCode = code;
  }

  Future<String?> getReferralCode() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(KeyConstant.pendingReferralCode);
  }

  Future<void> clearReferralCode() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(KeyConstant.pendingReferralCode);
    pendingReferralCode = null;
  }

  Future<void> clearAuthData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(KeyConstant.accessToken);
    await sharedPreferences.remove(KeyConstant.logInToken);
    await sharedPreferences.remove(KeyConstant.logInInfo);
    await sharedPreferences.remove(KeyConstant.referralDialogShown);
    await sharedPreferences.remove(KeyConstant.expertDetailShowcaseShown);
    await sharedPreferences.remove(KeyConstant.discoverShowcaseShown);
    await sharedPreferences.remove(KeyConstant.homeShowcaseShown);
    await sharedPreferences.remove(KeyConstant.cachedUserName);
    await sharedPreferences.remove(KeyConstant.cachedUserImage);
    accessToken = null;
    logInToken = null;
    logInInfo = null;
    isReferralDialogShown = null;
    isExpertDetailShowcaseShown = null;
    isDiscoverShowcaseShown = null;
    isHomeShowcaseShown = null;
    cachedUserName = null;
    cachedUserImage = null;
  }
}
