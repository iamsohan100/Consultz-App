import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/feature/Auth/controller/expert_skill_controller.dart';
import 'package:consultz/feature/Auth/controller/set_key_expertise_controller.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/widgets/interest_background.dart';
import 'package:consultz/feature/Auth/widgets/interest_value_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InterestedSubCategoryScreen extends StatelessWidget {
  const InterestedSubCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final expertSkillController = Get.find<ExpertSkillController>();
    final setKeyExpertiseController = Get.find<SetKeyExpertiseController>();
    return Scaffold(
      appBar: customAppBar(
        context: context,
        color: Color(0xFFF9AEBA).withValues(alpha: 0.25),
        actions: [
          // SkipInterests(),
          SizedBox(width: width * 0.06),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SafeArea(
        bottom: true,
        top: false,
        left: false,
        right: false,
        child: Padding(
          padding: EdgeInsets.all(scaleFactor * 20),
          child: PrimaryButton(
            onPressed: () => continu(context),
            title: 'Continue',
          ),
        ),
      ),
      body: InterestBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                AppImages.interests_2,
                width: scaleFactor * 260,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: height * 0.01),

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(scaleFactor * 20),
                  child: Obx(() {
                    final categories =
                        setKeyExpertiseController.subCategoryItems;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: height * 0.01,
                      children: [
                        CustomText(
                          text: 'Select your interests in detail',
                          color: AppColors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          lineHeight: 1.4,
                        ),

                        CustomText(
                          text:
                              'Help us refine your preferences by choosing specific topics.',
                          color: AppColors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          lineHeight: 1.6,
                        ),
                        SizedBox(height: height * 0.01),
                        Align(
                          alignment: Alignment.center,
                          child: Wrap(
                            spacing: width * 0.02,
                            runSpacing: height * 0.02,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.center,
                            children: [
                               for (final skill in categories)
                                  InterestValueContainer(
                                    onTap: () {
                                      if (expertSkillController.selectedSkills
                                          .contains(skill)) {
                                        expertSkillController.selectedSkills
                                            .remove(skill);
                                      } else {
                                        expertSkillController.selectedSkills
                                            .add(skill);
                                      }
                                    },
                                    title: skill,
                                    isSelected: expertSkillController
                                        .selectedSkills
                                        .contains(skill),
                                  ),
                            ],
                          ),
                        ),

                        SizedBox(height: height * 0.1),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> continu(BuildContext context) async {
  final expertSkillController = Get.find<ExpertSkillController>();

  if (expertSkillController.selectedSkills.isEmpty) {
    bottomMessage(msg: "Please select your skills");
    return;
  }

  final response = await expertSkillController.setExpertSkill(
    context,
    isInterested: true,
  );
  if (response) {
    Get.toNamed(RoutesConstant.learningStyleScreen);
  }
}
