import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/feature/expert/controller/expert_detail_controller.dart';
import 'package:consultz/feature/expert/controller/expert_profile_controller.dart';
import 'package:consultz/feature/expert/controller/follow_unfollow_controller.dart';
import 'package:consultz/feature/expert/controller/profile_share_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:showcaseview/showcaseview.dart';

class FollowAndShare extends StatelessWidget {
  const FollowAndShare({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    final expertProfileController = Get.find<ExpertProfileController>();
    final followUnfollowController = Get.find<FollowUnfollowController>();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        Obx(() {
          final expertData =
              expertProfileController.expertProfileModel.value.data;
          final isFollowing = expertData?.isFollowing ?? false;

          return PrimaryButton(
            onPressed: () async {
              if (expertData?.sId == null) return;
              if (isFollowing) {
                await followUnfollowController.unfolloweUser(
                  context,
                  userId: expertData!.sId!,
                );
              } else {
                await followUnfollowController.followeBackUser(
                  context,
                  userId: expertData!.sId!,
                );
              }
            },
            title: isFollowing ? 'Following' : 'Follow',
            fontSize: 10,
            textColor: isFollowing
                ? AppColors.darkGrey
                : AppColors.primaryColor,
            fontWeight: FontWeight.w500,
            backgroundColor: isFollowing
                ? Color(0xFFF8F8F8)
                : Colors.transparent,
            borderColor: isFollowing ? null : AppColors.primaryColor,
            buttonWidth: width * 0.16,
            buttonHeight: height * 0.044,
            radius: 8,
          );
        }),
        SizedBox(width: width * 0.025),
        Showcase(
          key: Get.find<ExpertDetailController>().shareButtonKey,
          description: 'Click here to share this expert profile',
          descTextStyle: const TextStyle(
            color: AppColors.black,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          child: GestureDetector(
            onTap: () {
              final expertId =
                  expertProfileController.expertProfileModel.value.data?.sId;
              Get.find<ProfileShareController>().shareProfile(
                expertId: expertId,
              );
            },
            child: Container(
              width: width * 0.1,
              height: height * 0.044,
              padding: EdgeInsets.all(scaleFactor * 4),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(scaleFactor * 10),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withValues(alpha: 0.08),
                    blurRadius: 10,
                    spreadRadius: 0.5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Transform.scale(
                scaleX: -1,
                child: Icon(
                  Icons.reply,
                  size: scaleFactor * 22,
                  color: AppColors.darkGrey,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
