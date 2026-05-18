import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/loading.dart/circle_loading.dart';
import 'package:consultz/core/utils/widgets/no_data.dart';
import 'package:consultz/feature/expert/widgets/review_shimmer.dart';
import 'package:consultz/feature/profile/controller/blocked_user_controller.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/feature/profile/widgets/unblock_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlockedUserScreen extends StatefulWidget {
  const BlockedUserScreen({super.key});

  @override
  State<BlockedUserScreen> createState() => _BlockedUserScreenState();
}

class _BlockedUserScreenState extends State<BlockedUserScreen> {
  final blockedUserController = Get.find<BlockedUserController>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      blockedUserController.initialLoad();

      blockedUserController.scrollController.addListener(() {
        if (blockedUserController.scrollController.position.pixels >=
                blockedUserController
                        .scrollController
                        .position
                        .maxScrollExtent -
                    200 &&
            !blockedUserController.isLoadingMore.value &&
            blockedUserController.hasMore.value) {
          blockedUserController.loadMore();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    return Scaffold(
      appBar: customAppBar(context: context, title: 'Blocked users'),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.only(
              top: height * 0.01,
              bottom: height * 0.02,
            ),
            child: Obx(() {
              if (blockedUserController.inProgress.value) {
                return Padding(
                  padding: .symmetric(horizontal: scaleFactor * 16),
                  child: ReviewShimmer(length: 5),
                );
              } else if (blockedUserController.blockedList.isEmpty) {
                return Column(
                  children: [
                    SizedBox(height: height * 0.2),
                    Image.asset(
                      AppImages.block,
                      color: AppColors.grey,
                      width: scaleFactor * 100,
                    ),
                    NoData(text: 'You haven’t blocked anyone'),
                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: blockedUserController.blockedList.length,
                    itemBuilder: (context, index) {
                      return UnblockButton(
                        blockedUserData:
                            blockedUserController.blockedList[index],
                      );
                    },
                  ),
                  if (blockedUserController.isLoadingMore.value) ...[
                    SizedBox(height: height * 0.015),
                    CircleLoading(top: 0),
                  ],
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
