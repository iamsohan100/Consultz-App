// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/loading.dart/main_loading.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/core/utils/share_preference/auth_preference.dart';
import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:consultz/feature/Auth/model/social_profile_data.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/expert_profile_model.dart';

class UpdateSocialProfileController extends GetxController {
  var socialChannels = <SocialProfiles>[].obs;

  void addSocialChannel() {
    // Make sure 'LinkedIn' exactly matches an item in socialChannelList
    socialChannels.add(SocialProfiles(type: socialChannelList.first, url: ''));
  }

  void updateProfileUrl(int index, String url) {
    socialChannels[index].url = url;
  }

  void updateChannelType(int index, String type) {
    socialChannels[index].type = type;
    socialChannels.refresh();
  }

  TextEditingController getProfileUrlController(int index) {
    return TextEditingController(text: socialChannels[index].url);
  }

  Future<bool> updateSocialProfile(BuildContext context) async {
    bool isSuccess = true;
    // ExpertProfileSetupModel expertProfileSetupModel = ExpertProfileSetupModel(
    //   socialProfiles: socialChannels,
    // );

    try {
      mainLoading(context, loadingText: 'Connecting...');

      final response = await ApiCaller.putRequest(
        token: AuthPreference.accessToken,
        url: ApiUrls.updateProfile,
        body: {
          "socialProfiles": socialChannels
              .map((e) => {"type": e.type, "url": e.url})
              .toList(),
        },
      );
      Navigator.pop(context);
      log("${response?.responseData.toString()}");
      if (response?.statusCode == 200 && response?.isSuccess == true) {
        await Get.find<ProfileController>().getMyProfile();
      } else {
        log('message');
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
