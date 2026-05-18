import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_read_more_text.dart';
import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:consultz/feature/expert/controller/expert_profile_controller.dart';
import 'package:consultz/feature/expert/widgets/discover_ai_power.dart';
import 'package:consultz/feature/expert/widgets/expert_skills.dart';
import 'package:consultz/feature/expert/widgets/expert_consultz_stats.dart';
import 'package:consultz/feature/expert/widgets/expert_education.dart';
import 'package:consultz/feature/expert/widgets/top_expert_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpertOverView extends StatelessWidget {
  const ExpertOverView({super.key, this.isProfile});
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
        final activeData = isProfile == true ? profileData : expertProfileData;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpertConsultzStats(isProfile: isProfile),
            SizedBox(height: height * 0.02),
            CustomReadMoreText(
              text: activeData?.bio ?? '', // ✅
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.black,
            ),
            SizedBox(height: height * 0.028),
            if (activeData?.isTopExpert == true) ...[
              TopExpertContainer(),
              SizedBox(height: height * 0.025),
            ],
            ExpertSkills(isProfile: isProfile),
            SizedBox(height: height * 0.02),
            ExpertEducation(isProfile: isProfile),
            SizedBox(height: height * 0.025),
            DiscoverAiPower(),
          ],
        );
      }),
    );
  }
}
