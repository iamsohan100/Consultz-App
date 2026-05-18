// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/core/utils/share_preference/auth_preference.dart';
import 'package:consultz/feature/expert/controller/invite_friend_controller.dart';
import 'package:consultz/feature/expert/model/expert_profile_model.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final inProgress = false.obs;
  Rx<ExpertProfileModel> expertProfileModel = ExpertProfileModel().obs;

  Future<bool> getMyProfile() async {
    bool isSuccess = true;
    try {
      inProgress.value = true;

      final response = await ApiCaller.getRequest(url: ApiUrls.getProfile);

      inProgress.value = false;
      if (response?.statusCode == 200 && response?.isSuccess == true) {
        expertProfileModel.value = ExpertProfileModel.fromJson(
          response?.responseData,
        );

        if (expertProfileModel.value.data?.status != null) {
          await AuthPreference().updateUserStatus(
            expertProfileModel.value.data!.status!,
          );
          log("User id: ${expertProfileModel.value.data!.sId}");
        }

        if (expertProfileModel.value.data != null) {
          final data = expertProfileModel.value.data!;
          final name = '${data.firstName ?? ''} ${data.lastName ?? ''}'.trim();
          if (name.isNotEmpty) {
            await AuthPreference().saveUserName(name);
          }
          if (data.photoUrl != null && data.photoUrl!.isNotEmpty) {
            await AuthPreference().saveUserImage(data.photoUrl!);
          }
        }

        Get.find<InviteFriendController>().referalCode.value =
            expertProfileModel.value.data?.referralCode ?? "";
      } else {
        bottomMessage(msg: response?.message);
        isSuccess = false;
      }
    } catch (e) {
      bottomMessage(msg: e.toString());
      log(e.toString());
      isSuccess = false;
    }

    return isSuccess;
  }
}
