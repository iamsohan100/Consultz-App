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

class FollowingButton extends StatelessWidget {
  const FollowingButton({super.key, required this.followingData});

  final FollowerAndFollowingData followingData;

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final followUnfollowController = Get.find<FollowUnfollowController>();

    return ListTile(
      onTap: () {
        log('id: ${followingData.sId}');
        Get.toNamed(
          RoutesConstant.expertDetailsScreen,
          arguments: followingData.sId,
        );
      },
      leading: Container(
        clipBehavior: Clip.antiAlias,
        width: scaleFactor * 51,
        height: scaleFactor * 51,
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: followingData.photoUrl != null
            ? DisplayNetworkImage(
                imageUrl: followingData.photoUrl,
                imageFit: .cover,
                imageSize: scaleFactor * 51,
              )
            : Image.asset(AppImages.profileImage, fit: BoxFit.cover),
      ),
      title: CustomText(
        text: "${followingData.firstName ?? ''} ${followingData.lastName ?? ''}"
            .trim(),
        color: AppColors.black,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      subtitle: CustomText(
        text: followingData.headline ?? '',
        color: AppColors.grey,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      trailing: PrimaryButton(
        onPressed: () async {
          await followUnfollowController.unfolloweUser(
            context,
            userId: followingData.sId!,
          );
        },
        title: 'Unfollow',
        textColor: AppColors.darkGrey,
        fontWeight: FontWeight.w500,
        buttonWidth: width * 0.25,
        buttonHeight: height * 0.045,
        backgroundColor: Color(0xFFF8F8F8),
        radius: 12,
      ),
    );
  }
}
