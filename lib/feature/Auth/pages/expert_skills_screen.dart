import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/feature/Auth/controller/expert_skill_controller.dart';
import 'package:consultz/feature/Auth/controller/set_key_expertise_controller.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/widgets/interest_value_container.dart';
import 'package:consultz/feature/Auth/widgets/profile_completation_progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpertSkillsScreen extends StatelessWidget {
  const ExpertSkillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final expertSkillController = Get.find<ExpertSkillController>();
    final setKeyExpertiseController = Get.find<SetKeyExpertiseController>();
    return Scaffold(
      appBar: customAppBar(title: '', context: context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SafeArea(
        bottom: true,
        top: false,
        left: false,
        right: false,
        child: Padding(
          padding: EdgeInsets.all(scaleFactor * 20),
          child: PrimaryButton(
            onPressed: () {
              continu(context);
            },
            title: 'Continue',
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.only(
              top: scaleFactor * 8,
              left: scaleFactor * 20,
              right: scaleFactor * 20,
              bottom: scaleFactor * 20,
            ),
            child: Obx(() {
              final categories = setKeyExpertiseController.subCategoryItems;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: height * 0.016,
                children: [
                  ProfileCompletationProgress(),
                  SizedBox(),
                  CustomText(
                    text: "Select sub-category",
                    color: AppColors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                  CustomText(
                    text:
                        'Get matched with the right clients, choose your niche and skill',
                    color: AppColors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
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
                                expertSkillController.selectedSkills.add(skill);
                              }
                            },
                            title: skill,
                            isSelected: expertSkillController.selectedSkills
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
    );
  }
}

Future<void> continu(BuildContext context) async {
  final expertSkillController = Get.find<ExpertSkillController>();

  if (expertSkillController.selectedSkills.isEmpty) {
    bottomMessage(msg: "Please select your skills");
    return;
  }

  final response = await expertSkillController.setExpertSkill(context);
  if (response) {
    Get.toNamed(RoutesConstant.expertAdvisingStyleScreen);
  }
}
