import 'dart:developer';

import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/feature/expert/model/follower_and_following_data.dart';
import 'package:consultz/feature/expert/model/follower_model.dart';
import 'package:consultz/feature/expert/model/following_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FollowerFollowingController extends GetxController {
  final isFollower = true.obs;
  final isFollowing = false.obs;
  final inProgressForFollower = false.obs;
  final isLoadingMoreForFollower = false.obs;
  final hasMoreForFollower = true.obs;
  final inProgressForFollowing = false.obs;
  final isLoadingMoreForFollowing = false.obs;
  final hasMoreForFollowing = true.obs;
  final followerList = <FollowerAndFollowingData>[].obs;
  final followingList = <FollowerAndFollowingData>[].obs;
  final userId = ''.obs;
  int currentPageForFollower = 1;
  final int _limitForFollower = 20;
  final ScrollController scrollControllerForFollower = ScrollController();
  int currentPageForFollowing = 1;
  final int _limitForFollowing = 20;
  final ScrollController scrollControllerForFollowing = ScrollController();
  final searchControllerForFollower = TextEditingController();
  final searchControllerForFollowing = TextEditingController();
  final searchTermForFollower = ''.obs;
  final searchTermForFollowing = ''.obs;
  // Future<void> initialLoadForFollower() async {
  //   currentPageForFollower = 1;
  //   followerList.clear();
  //   hasMoreForFollower.value = true;
  //   await getFollowerUser();
  // }
  Future<void> initialLoadForFollower({String? searchTerm}) async {
    currentPageForFollower = 1;
    followerList.clear();
    hasMoreForFollower.value = true;
    if (searchTerm != null) searchTermForFollower.value = searchTerm;
    await getFollowerUser();
  }

  Future<void> loadMoreForFollower() async {
    currentPageForFollower++;
    await getFollowerUser();
  }

  // Future<void> initialLoadForFollowing() async {
  //   currentPageForFollowing = 1;
  //   followingList.clear();
  //   hasMoreForFollowing.value = true;
  //   await getFollowingUser();
  // }
  Future<void> initialLoadForFollowing({String? searchTerm}) async {
    currentPageForFollowing = 1;
    followingList.clear();
    hasMoreForFollowing.value = true;
    if (searchTerm != null) searchTermForFollowing.value = searchTerm;
    await getFollowingUser();
  }

  Future<void> loadMoreForFollowing() async {
    currentPageForFollowing++;
    await getFollowingUser();
  }

  Future<bool> getFollowerUser() async {
    bool isSuccess = true;
    try {
      if (currentPageForFollower == 1) {
        inProgressForFollower.value = true;
      } else {
        isLoadingMoreForFollower.value = true;
      }

      final response = await ApiCaller.getRequest(
        url: ApiUrls.getFollowerUsers(
          id: userId.value,
          page: currentPageForFollower.toString(),
          limit: _limitForFollower,
          searchTerm: searchTermForFollower.value,
        ),
      );

      log("${response?.responseData.toString()}");

      if (response?.statusCode == 200 && response?.isSuccess == true) {
        final followerModel = FollowerModel.fromJson(response?.responseData);
        final followers = followerModel.followerData ?? [];

        if (followers.isEmpty || followers.length < _limitForFollower) {
          hasMoreForFollower.value = false;
        }
        followerList.addAll(followers);
      } else {
        bottomMessage(msg: response?.message);
        isSuccess = false;
        if (currentPageForFollower > 1) currentPageForFollower--;
      }
    } catch (e) {
      bottomMessage(msg: e.toString());
      isSuccess = false;
      if (currentPageForFollower > 1) currentPageForFollower--;
    } finally {
      inProgressForFollower.value = false;
      isLoadingMoreForFollower.value = false;
    }

    return isSuccess;
  }

  Future<bool> getFollowingUser() async {
    bool isSuccess = true;
    try {
      if (currentPageForFollowing == 1) {
        inProgressForFollowing.value = true;
      } else {
        isLoadingMoreForFollowing.value = true;
      }

      // final response = await ApiCaller.getRequest(
      //   url: ApiUrls.getFollowingUsers(
      //     page: currentPageForFollowing.toString(),
      //     limit: _limitForFollowing,
      //   ),
      // );
      final response = await ApiCaller.getRequest(
        url: ApiUrls.getFollowingUsers(
          id: userId.value,
          page: currentPageForFollowing.toString(),
          limit: _limitForFollowing,
          searchTerm: searchTermForFollowing.value, // ADD THIS
        ),
      );

      log("${response?.responseData.toString()}");

      if (response?.statusCode == 200 && response?.isSuccess == true) {
        final followingModel = FollowingModel.fromJson(response?.responseData);
        final followingUser = followingModel.followingData ?? [];

        if (followingUser.isEmpty ||
            followingUser.length < _limitForFollowing) {
          hasMoreForFollowing.value = false;
        }
        followingList.addAll(followingUser);
      } else {
        bottomMessage(msg: response?.message);
        isSuccess = false;
        if (currentPageForFollowing > 1) currentPageForFollowing--;
      }
    } catch (e) {
      bottomMessage(msg: e.toString());
      isSuccess = false;
      if (currentPageForFollowing > 1) currentPageForFollowing--;
    } finally {
      inProgressForFollowing.value = false;
      isLoadingMoreForFollowing.value = false;
    }

    return isSuccess;
  }

  @override
  void onClose() {
    searchControllerForFollower.dispose();
    searchControllerForFollowing.dispose();
    scrollControllerForFollower.dispose();
    scrollControllerForFollowing.dispose();
    super.onClose();
  }
}
