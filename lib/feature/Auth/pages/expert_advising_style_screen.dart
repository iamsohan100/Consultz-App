import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/feature/Auth/controller/expert_advising_controller.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/feature/Auth/model/interest_page_data.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/widgets/interest_value_container.dart';
import 'package:consultz/feature/Auth/widgets/profile_completation_progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpertAdvisingStyleScreen extends StatelessWidget {
  const ExpertAdvisingStyleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final expertAdvisingController = Get.find<ExpertAdvisingController>();
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
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: height * 0.016,
                children: [
                  ProfileCompletationProgress(),
                  SizedBox(),
                  CustomText(
                    text: "Your advising style",
                    color: AppColors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                  CustomText(
                    text:
                        'Get matched with the right clients, choose your advising style',
                    color: AppColors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
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
                            if (expertAdvisingController.selectedAdvisingStyles
                                .contains(InterestPageData.learningData[i])) {
                              expertAdvisingController.selectedAdvisingStyles
                                  .remove(InterestPageData.learningData[i]);
                            } else {
                              expertAdvisingController.selectedAdvisingStyles
                                  .add(InterestPageData.learningData[i]);
                            }
                          },
                          title: InterestPageData.learningData[i],
                          isSelected: expertAdvisingController
                              .selectedAdvisingStyles
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
    );
  }
}

Future<void> continu(BuildContext context) async {
  final expertAdvisingController = Get.find<ExpertAdvisingController>();

  if (expertAdvisingController.selectedAdvisingStyles.isEmpty) {
    bottomMessage(msg: "Please select your advising styles");
    return;
  }

  final response = await expertAdvisingController.setExpertAdvisingStyle(
    context,
  );
  if (response) {
    Get.toNamed(RoutesConstant.updateBioScreen);
  }
}
