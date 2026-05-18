import 'dart:async';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/loading.dart/circle_loading.dart';
import 'package:consultz/core/utils/widgets/no_data.dart';
import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:consultz/feature/profile/controller/following_controller.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/form_field/custom_form_field.dart';
import 'package:consultz/feature/profile/widgets/following_button.dart';
import 'package:consultz/feature/expert/widgets/review_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FollowingScreen extends StatefulWidget {
  const FollowingScreen({super.key});

  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  final followingController = Get.find<FollowingController>();
  final profileController =
      Get.find<ProfileController>().expertProfileModel.value.data;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      followingController.initialLoad();
    });
    followingController.scrollController.addListener(() {
      if (followingController.scrollController.position.pixels >=
              followingController.scrollController.position.maxScrollExtent -
                  200 &&
          !followingController.isLoadingMore.value &&
          followingController.hasMore.value) {
        followingController.loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final name =
        "${profileController?.firstName ?? ''} ${profileController?.lastName ?? ''}";

    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: name.trim().isEmpty ? 'Following' : name,
      ),

      body: SafeArea(
        child: Obx(() {
          final following = followingController.followingList;

          return SingleChildScrollView(
            controller: followingController.scrollController,
            child: Padding(
              padding: EdgeInsetsGeometry.only(
                top: height * 0.01,
                bottom: height * 0.02,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(scaleFactor * 16),
                    child: CustomFormField(
                      controller: followingController.searchController,
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
                            followingController.initialLoad(term: value);
                          },
                        );
                      },
                    ),
                  ),
                  if (followingController.inProgress.value) ...[
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: scaleFactor * 16,
                      ),
                      child: ReviewShimmer(length: 5),
                    ),
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
                          return FollowingButton(
                            followingData: following[index],
                          );
                        },
                      ),
                    if (followingController.isLoadingMore.value) ...[
                      SizedBox(height: height * 0.015),
                      CircleLoading(top: 0),
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
