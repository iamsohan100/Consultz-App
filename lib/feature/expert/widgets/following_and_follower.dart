import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/different_text_format/follow_format.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_rich_text.dart';
import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:consultz/feature/expert/controller/expert_profile_controller.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FollowingAndFollower extends StatelessWidget {
  const FollowingAndFollower({super.key, this.isProfile,required this.expertId});
  final bool? isProfile;
  final String expertId;
  @override
  Widget build(BuildContext context) {
    double width = Screen.screenWidth(context);
    final profileController = Get.find<ProfileController>();
    final expertProfileController = Get.find<ExpertProfileController>();

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Get.toNamed(RoutesConstant.followersScreen, arguments: {"isProfile":isProfile,'expertId':expertId});
      },
      child: Obx(() {
        final profileData = profileController.expertProfileModel.value.data;
        final expertProfileData =
            expertProfileController.expertProfileModel.value.data;

        // isProfile এর উপর ভিত্তি করে active data সিলেক্ট করো
        final activeData = isProfile == true ? profileData : expertProfileData;

        return Row(
          spacing: width * 0.07,
          children: [
            CustomRichText(
              text1:
                  "${followFormat(activeData?.following ?? 0)} ", // ✅ activeData থেকে following
              text2: 'Following',
              color1: AppColors.black,
              color2: AppColors.grey,
              fontSize1: 14,
              fontSize2: 14,
              fontWeight: FontWeight.w500,
            ),
            CustomRichText(
              text1:
                  "${followFormat(activeData?.followers ?? 0)} ", // ✅ activeData থেকে followers
              text2: 'Followers',
              color1: AppColors.black,
              color2: AppColors.grey,
              fontSize1: 14,
              fontSize2: 14,
              fontWeight: FontWeight.w500,
            ),
          ],
        );
      }),
    );
  }
}
