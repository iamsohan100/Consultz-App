import 'dart:async';

import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/loading.dart/circle_loading.dart';
import 'package:consultz/core/utils/widgets/no_data.dart';
import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:consultz/feature/expert/controller/follower_following_controller.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/form_field/custom_form_field.dart';
import 'package:consultz/feature/expert/widgets/follower_following_filter.dart';
import 'package:consultz/feature/expert/widgets/followers_button.dart';
import 'package:consultz/feature/expert/widgets/review_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FollowersScreen extends StatefulWidget {
  const FollowersScreen({super.key});

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  final followerFollowingController = Get.find<FollowerFollowingController>();
  final args = Get.arguments as Map<String, dynamic>; // isProfile // expertId
  final profileController =
      Get.find<ProfileController>().expertProfileModel.value.data;
  Timer? _debounce;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      followerFollowingController.userId.value = args['expertId'];

      myFollowerFollowing();
    });
  }

  void myFollowerFollowing() {
    followerFollowingController.initialLoadForFollower();
    followerFollowingController.initialLoadForFollowing();

    followerFollowingController.scrollControllerForFollower.addListener(() {
      if (followerFollowingController
                  .scrollControllerForFollower
                  .position
                  .pixels >=
              followerFollowingController
                      .scrollControllerForFollower
                      .position
                      .maxScrollExtent -
                  200 &&
          !followerFollowingController.isLoadingMoreForFollower.value &&
          followerFollowingController.hasMoreForFollower.value) {
        followerFollowingController.loadMoreForFollower();
      }
    });
    followerFollowingController.scrollControllerForFollowing.addListener(() {
      if (followerFollowingController
                  .scrollControllerForFollowing
                  .position
                  .pixels >=
              followerFollowingController
                      .scrollControllerForFollowing
                      .position
                      .maxScrollExtent -
                  200 &&
          !followerFollowingController.isLoadingMoreForFollowing.value &&
          followerFollowingController.hasMoreForFollowing.value) {
        followerFollowingController.loadMoreForFollowing();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final name =
        "${profileController?.firstName} ${profileController?.lastName}";

    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: args['isProfile'] == true ? name : '',
      ),

      body: SafeArea(
        child: Obx(() {
          final controller = followerFollowingController.isFollower.value
              ? followerFollowingController.scrollControllerForFollower
              : followerFollowingController.scrollControllerForFollowing;
          final following = followerFollowingController.followingList;
          final follower = followerFollowingController.followerList;
          final isFollower = followerFollowingController.isFollower.value;

          return SingleChildScrollView(
            controller: controller,
            child: Padding(
              padding: EdgeInsetsGeometry.only(
                top: height * 0.01,
                bottom: height * 0.02,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FollowerFollowingFilter(),
                  Padding(
                    padding: EdgeInsets.all(scaleFactor * 16),
                    child: CustomFormField(
                      controller: isFollower
                          ? followerFollowingController
                                .searchControllerForFollower
                          : followerFollowingController
                                .searchControllerForFollowing,
                      hintText: 'Search',
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: AppColors.darkGrey,
                        size: scaleFactor * 22,
                      ),
                      backgroundColor: Color(0xFFF5F5F5),
                      onChange: (value) {
                        if (_debounce?.isActive ?? false) _debounce!.cancel();
                        _debounce = Timer(
                          const Duration(milliseconds: 400),
                          () {
                            if (isFollower) {
                              followerFollowingController
                                  .initialLoadForFollower(searchTerm: value);
                            } else {
                              followerFollowingController
                                  .initialLoadForFollowing(searchTerm: value);
                            }
                          },
                        );
                      },
                    ),
                  ),
                  if ((followerFollowingController.isFollower.value &&
                          followerFollowingController
                              .inProgressForFollower
                              .value) ||
                      (!followerFollowingController.isFollower.value &&
                          followerFollowingController
                              .inProgressForFollowing
                              .value)) ...[
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: scaleFactor * 16,
                      ),
                      child: ReviewShimmer(length: 5),
                    ),
                  ] else ...[
                    if (followerFollowingController.isFollower.value) ...[
                      if (follower.isEmpty) ...[
                        SizedBox(height: height * 0.02),
                        NoData(text: "You don’t have any followers yet."),
                      ] else
                        ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: follower.length,
                          itemBuilder: (context, index) {
                            return FollowersButton(
                              followerAndFollowingData: follower[index],
                              isFollower: true,
                              isProfile: args['isProfile'],
                              currentUserId: profileController?.sId,
                            );
                          },
                        ),
                      if (followerFollowingController
                          .isLoadingMoreForFollower
                          .value) ...[
                        SizedBox(height: height * 0.015),
                        CircleLoading(top: 0),
                      ],
                    ] else ...[
                      if (following.isEmpty) ...[
                        SizedBox(height: height * 0.02),
                        NoData(text: "You’re not following anyone yet"),
                      ] else
                        ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: following.length,
                          itemBuilder: (context, index) {
                            return FollowersButton(
                              followerAndFollowingData: following[index],
                              isFollower: false,
                              isProfile: args['isProfile'],
                              currentUserId: profileController?.sId,
                            );
                          },
                        ),
                      if (followerFollowingController
                          .isLoadingMoreForFollowing
                          .value) ...[
                        SizedBox(height: height * 0.015),
                        CircleLoading(top: 0),
                      ],
                    ],
                  ],
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
