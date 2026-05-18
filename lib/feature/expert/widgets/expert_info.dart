
import 'package:consultz/core/utils/image/display_network_image.dart';
import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:consultz/feature/expert/controller/expert_profile_controller.dart';
import 'package:consultz/feature/expert/widgets/following_and_follower.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/expert/widgets/edit_and_share.dart';
import 'package:consultz/feature/expert/widgets/follow_and_share.dart';
import 'package:consultz/feature/expert/widgets/name_and_book_now.dart';
import 'package:consultz/feature/expert/controller/expert_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:showcaseview/showcaseview.dart';

class ExpertInfo extends StatelessWidget {
  const ExpertInfo({super.key, this.isProfile});
  final bool? isProfile;
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final profileController = Get.find<ProfileController>();
    final expertProfileController = Get.find<ExpertProfileController>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: scaleFactor * 14),
      child: Obx(() {
        final profileData = profileController.expertProfileModel.value.data;
        final expertProfileData =
            expertProfileController.expertProfileModel.value.data;

        // isProfile এর উপর ভিত্তি করে active data সিলেক্ট করো
        final activeData = isProfile == true ? profileData : expertProfileData;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.02),
            Showcase(
              key: Get.find<ExpertDetailController>().dashboardKey,
              description: 'Click here to go to your dashboard',
              descTextStyle: const TextStyle(
                color: AppColors.black,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  if (isProfile == true) {
                    Get.toNamed(RoutesConstant.expertDashboardScreen);
                  }
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildGradientCircle(
                      size: scaleFactor * 65,
                      colors: [Color(0xFFF63636), Color(0xFFFCC26B)],
                      image: CircleAvatar(
                        radius: scaleFactor * 30,
                        backgroundColor: Colors.white,
                        child: Container(
                          height: scaleFactor * 57,
                          width: scaleFactor * 57,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: DisplayNetworkImage(
                            imageUrl: activeData?.photoUrl,
                            imageFit: BoxFit.cover,
                            imageSize: scaleFactor * 57,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: width * 0.02),
                    NameAndBookNow(isProfile: isProfile),
                    SizedBox(width: width * 0.025),
                    if (isProfile == true) EditAndShare() else FollowAndShare(),
                  ],
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
            if (activeData?.headline != null && activeData?.headline != '') ...[
              CustomText(
                text: activeData?.headline ?? '',
                color: AppColors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: height * 0.005),
            ],

            FollowingAndFollower(
              isProfile: isProfile,
              expertId: activeData?.sId ?? '',
            ),
          ],
        );
      }),
    );
  }
}

Container _buildGradientCircle({
  required double size,
  required List<Color> colors,
  required Widget image,
}) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: colors,
      ),
    ),
    alignment: Alignment.center,
    child: image,
  );
}
