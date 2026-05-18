import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:consultz/feature/expert/controller/expert_profile_controller.dart';
import 'package:consultz/feature/expert/widgets/experience_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpertEducation extends StatelessWidget {
  const ExpertEducation({super.key, this.isProfile});
  final bool? isProfile;
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final profileController = Get.find<ProfileController>();
    final expertProfileController = Get.find<ExpertProfileController>();

    return Obx(() {
      final profileData = profileController.expertProfileModel.value.data;
      final expertProfileData =
          expertProfileController.expertProfileModel.value.data;
      final activeData = isProfile == true ? profileData : expertProfileData;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: height * 0.018,
        children: [
          CustomText(
            text: 'Education',
            color: AppColors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          Container(
            width: width,
            padding: EdgeInsets.all(scaleFactor * 16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(scaleFactor * 8),
              border: Border.all(color: AppColors.midGrey),
            ),
            child: Column(
              spacing: height * 0.01,
              children: [
                ExperienceText(
                  title: 'Degree',
                  data: [(activeData?.education?.degree ?? '')], // ✅
                ),
                Divider(color: AppColors.midGrey),
                ExperienceText(
                  title: 'Certification',
                  data: activeData?.education?.certificate ?? [], // ✅
                ),
                Divider(color: AppColors.midGrey),
                ExperienceText(
                  title: 'Phd',
                  data: [(activeData?.education?.phd ?? '')], // ✅
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
