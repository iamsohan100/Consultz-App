// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/loading.dart/main_loading.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:consultz/feature/expert/controller/expert_profile_controller.dart';
import 'package:consultz/feature/expert/controller/follower_following_controller.dart';
import 'package:consultz/feature/home/controller/interest_expert_controller.dart';
import 'package:consultz/feature/home/controller/property_expert_controller.dart';
import 'package:consultz/feature/home/controller/search_expert_controller.dart';
import 'package:consultz/feature/home/controller/top_expert_controller.dart';
import 'package:consultz/feature/profile/controller/following_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FollowUnfollowController extends GetxController {
  Future<bool> unfolloweUser(
    BuildContext context, {
    required String userId,
  }) async {
    bool isSuccess = true;
    try {
      mainLoading(context, loadingText: 'Unfollow...');

      final response = await ApiCaller.postRequest(
        url: ApiUrls.unfollowUser(userId),
        body: {},
      );

      Navigator.pop(context);
      log("${response?.responseData.toString()}");
      if (response?.statusCode == 200 && response?.isSuccess == true) {
        _updateExpertStatus(userId, false);
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

  Future<bool> followeBackUser(
    BuildContext context, {
    required String userId,
  }) async {
    bool isSuccess = true;
    try {
      mainLoading(context, loadingText: 'Follow...');

      final response = await ApiCaller.postRequest(
        url: ApiUrls.followUser(userId),
        body: {},
      );

      Navigator.pop(context);
      log("${response?.responseData.toString()}");
      if (response?.statusCode == 200 && response?.isSuccess == true) {
        _updateExpertStatus(userId, true);
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

  void _updateExpertStatus(String userId, bool isFollowing) {
    // Update SearchExpertController
    if (Get.isRegistered<SearchExpertController>()) {
      final controller = Get.find<SearchExpertController>();
      final index = controller.expertList.indexWhere((e) => e.sId == userId);
      if (index != -1) {
        controller.expertList[index].isFollowing = isFollowing;
        controller.expertList.refresh();
      }
    }

    // Update TopExpertController
    if (Get.isRegistered<TopExpertController>()) {
      final controller = Get.find<TopExpertController>();
      final index = controller.expertList.indexWhere((e) => e.sId == userId);
      if (index != -1) {
        controller.expertList[index].isFollowing = isFollowing;
        controller.expertList.refresh();
      }
    }

    // Update InterestExpertController
    if (Get.isRegistered<InterestExpertController>()) {
      final controller = Get.find<InterestExpertController>();
      final index = controller.expertList.indexWhere((e) => e.sId == userId);
      if (index != -1) {
        controller.expertList[index].isFollowing = isFollowing;
        controller.expertList.refresh();
      }
    }

    // Update PropertyExpertController
    if (Get.isRegistered<PropertyExpertController>()) {
      final controller = Get.find<PropertyExpertController>();
      final index = controller.expertList.indexWhere((e) => e.sId == userId);
      if (index != -1) {
        controller.expertList[index].isFollowing = isFollowing;
        controller.expertList.refresh();
      }
    }

    // Update FollowerFollowingController
    if (Get.isRegistered<FollowerFollowingController>()) {
      final controller = Get.find<FollowerFollowingController>();
      final myId = Get.find<ProfileController>().expertProfileModel.value.data?.sId;
      final bool isMyProfile = controller.userId.value == myId;

      // Update following list
      if (!isFollowing && isMyProfile) {
        controller.followingList.removeWhere((user) => user.sId == userId);
      } else {
        final followingIndex =
            controller.followingList.indexWhere((user) => user.sId == userId);
        if (followingIndex != -1) {
          controller.followingList[followingIndex].isFollowing = isFollowing;
          controller.followingList.refresh();
        }
      }

      // Update follower list
      final followerIndex =
          controller.followerList.indexWhere((user) => user.sId == userId);
      if (followerIndex != -1) {
        controller.followerList[followerIndex].isFollowing = isFollowing;
        controller.followerList.refresh();
      }
    }

    // Update FollowingController (Consultee)
    if (Get.isRegistered<FollowingController>()) {
      final controller = Get.find<FollowingController>();

      // Update following list
      if (!isFollowing) {
        controller.followingList.removeWhere((user) => user.sId == userId);
      }
    }

    // Update ExpertProfileController
    if (Get.isRegistered<ExpertProfileController>()) {
      final controller = Get.find<ExpertProfileController>();
      if (controller.expertProfileModel.value.data?.sId == userId) {
        controller.expertProfileModel.value.data?.isFollowing = isFollowing;
        controller.expertProfileModel.refresh();
      }
    }
  }
}
