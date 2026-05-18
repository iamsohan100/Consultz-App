import 'dart:developer';

import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/image/display_network_image.dart';
import 'package:consultz/feature/expert/controller/follow_unfollow_controller.dart';
import 'package:consultz/feature/expert/model/follower_and_following_data.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FollowersButton extends StatelessWidget {
  const FollowersButton({
    super.key,
    this.followerAndFollowingData,
    this.isFollower,
    this.isProfile,
    this.currentUserId,
  });

  final FollowerAndFollowingData? followerAndFollowingData;
  final bool? isFollower;
  final bool? isProfile;
  final String? currentUserId;

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final followUnfollowController = Get.find<FollowUnfollowController>();

    final bool isMe = followerAndFollowingData?.sId == currentUserId;
    final bool isFollowing = followerAndFollowingData?.isFollowing ?? false;

    return ListTile(
      onTap: () {
        log('id: ${followerAndFollowingData?.sId}');
        Get.toNamed(
          RoutesConstant.expertDetailsScreen,
          arguments: followerAndFollowingData?.sId,
        );
      },
      leading: Container(
        clipBehavior: Clip.antiAlias,
        width: scaleFactor * 51,
        height: scaleFactor * 51,
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: followerAndFollowingData?.photoUrl != null
            ? DisplayNetworkImage(
                imageUrl: followerAndFollowingData?.photoUrl,
                imageFit: BoxFit.cover,
                imageSize: scaleFactor * 51,
              )
            : Image.asset(AppImages.profileImage, fit: BoxFit.cover),
      ),
      title: CustomText(
        text:
            "${followerAndFollowingData?.firstName} ${followerAndFollowingData?.lastName}",
        color: AppColors.black,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      subtitle: CustomText(
        text: "${followerAndFollowingData?.headline}",
        color: AppColors.grey,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      trailing: (isMe || followerAndFollowingData?.role == 'consult')
          ? null
          : PrimaryButton(
              onPressed: () async {
                if (isFollowing) {
                  await followUnfollowController.unfolloweUser(
                    context,
                    userId: followerAndFollowingData!.sId!,
                  );
                } else {
                  await followUnfollowController.followeBackUser(
                    context,
                    userId: followerAndFollowingData!.sId!,
                  );
                }
              },
              title: isFollowing
                  ? 'Unfollow'
                  : (isProfile == true && isFollower == true)
                      ? 'Follow Back'
                      : 'Follow',
              textColor: isFollowing ? AppColors.darkGrey : null,
              fontWeight: FontWeight.w500,
              buttonWidth: width * 0.25,
              buttonHeight: height * 0.045,
              backgroundColor: isFollowing ? Color(0xFFF8F8F8) : null,
              radius: 12,
              fontSize: isFollowing ? null : 12,
            ),
    );
  }
}
