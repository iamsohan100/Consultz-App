import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/feature/shome_me_expert/controller/show_me_expert_category_controller.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/feature/Auth/model/interest_page_data.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/widgets/interest_background.dart';
import 'package:consultz/feature/Auth/widgets/interest_value_container.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowMeExpertLearningStyleScreen extends StatelessWidget {
  const ShowMeExpertLearningStyleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final showMeExpertCategoryController =
        Get.find<ShowMeExpertCategoryController>();

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
                AppImages.learningStyle2,
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
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: height * 0.01,
                      children: [
                        CustomText(
                          text: 'What is your preferred learning style?',
                          color: AppColors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,

                          lineHeight: 1.4,
                        ),
                        CustomText(
                          text:
                              'Get matched to the right experts by choosing a few words that describe your preferred learning style',
                          color: AppColors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          lineHeight: 1.6,
                        ),
                        SizedBox(height: height * 0.01),
                        Wrap(
                          spacing: width * 0.02,
                          runSpacing: height * 0.02,
                          children: [
                            for (
                              int i = 0;
                              i < InterestPageData.learningData.length;
                              i++
                            )
                              InterestValueContainer(
                                onTap: () {
                                  if (showMeExpertCategoryController
                                      .selectedLearningStyleList
                                      .contains(
                                        InterestPageData.learningData[i],
                                      )) {
                                    showMeExpertCategoryController
                                        .selectedLearningStyleList
                                        .remove(
                                          InterestPageData.learningData[i],
                                        );
                                  } else {
                                    showMeExpertCategoryController
                                        .selectedLearningStyleList
                                        .add(InterestPageData.learningData[i]);
                                  }
                                },
                                title: InterestPageData.learningData[i],
                                isSelected: showMeExpertCategoryController
                                    .selectedLearningStyleList
                                    .contains(InterestPageData.learningData[i]),
                              ),
                          ],
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
  final showMeExpertCategoryController =
      Get.find<ShowMeExpertCategoryController>();

  if (showMeExpertCategoryController.selectedLearningStyleList.isEmpty) {
    bottomMessage(msg: "Please select your learning styles");
    return;
  }

  Get.toNamed(RoutesConstant.showMeExpertLoadingScreen);
}
