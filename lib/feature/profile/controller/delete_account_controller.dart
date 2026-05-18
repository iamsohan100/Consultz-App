import 'dart:developer';
import 'package:consultz/core/utils/loading.dart/main_loading.dart';
import 'package:consultz/core/utils/message/top_message.dart';
import 'package:flutter/material.dart';
import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/core/utils/share_preference/auth_preference.dart';
import 'package:consultz/feature/main/controller/main_controller.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:get/get.dart';

class DeleteAccountController extends GetxController {
  final TextEditingController confirmationController = TextEditingController();

  Future<void> deleteAccount(BuildContext context) async {
    if (confirmationController.text != "deletemyaccount") {
      bottomMessage(msg: "Please type 'deletemyaccount' to confirm.");
      return;
    }

    try {
      mainLoading(context, loadingText: 'Deleting account...');
      final response = await ApiCaller.deleteRequest(
        url: ApiUrls.deleteAccount,
      );

      log("Delete Account Response: ${response?.responseData}");

      if (response?.statusCode == 200 && response?.isSuccess == true) {
        Navigator.pop(context);
        topMessage(title: 'Delete', msg: "Account deleted successfully");
        Get.find<MainController>().changeIndex(index: 0);
        await AuthPreference().clearAuthData();
        Get.offAllNamed(RoutesConstant.browseFirstScreen);
      } else {
        Navigator.pop(context);
        bottomMessage(msg: response?.message ?? "Failed to delete account");
      }
    } catch (e) {
      Navigator.pop(context);
      bottomMessage(msg: e.toString());
    }
  }
}
