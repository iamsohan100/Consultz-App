import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/feature/Auth/controller/set_key_expertise_controller.dart';
import 'package:consultz/feature/Auth/widgets/interest_value_container.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/widgets/profile_completation_progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KeyExpertiseScreen extends StatelessWidget {
  const KeyExpertiseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
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
              final categories = setKeyExpertiseController.allCategoryList;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: height * 0.016,
                children: [
                  ProfileCompletationProgress(),
                  SizedBox(),
                  CustomText(
                    text: "Please select category",
                    color: AppColors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                  CustomText(
                    text:
                        'Choose the category that best describes your skills or area of expertise',
                    color: AppColors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    lineHeight: 1.6,
                  ),
                  SizedBox(),
                  Align(
                    alignment: Alignment.center,
                    child: Wrap(
                      spacing: width * 0.02,
                      runSpacing: height * 0.02,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.center,
                      children: [
                        for (final category in categories)
                          InterestValueContainer(
                            onTap: () {
                              if (setKeyExpertiseController.selectedCategoryList
                                  .any((e) => e.sId == category.sId)) {
                                setKeyExpertiseController.selectedCategoryList
                                    .removeWhere(
                                  (e) => e.sId == category.sId,
                                );
                              } else {
                                setKeyExpertiseController.selectedCategoryList
                                    .add(category);
                              }
                            },
                            title: category.title ?? '',
                            isSelected: setKeyExpertiseController
                                .selectedCategoryList
                                .any((e) => e.sId == category.sId),
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
  final setKeyExpertiseController = Get.find<SetKeyExpertiseController>();
  if (setKeyExpertiseController.selectedCategoryList.isEmpty) {
    bottomMessage(msg: "Please select your expertise");
    return;
  }

  final response = await setKeyExpertiseController.updateExpertise(context);
  if (response) {
    Get.toNamed(RoutesConstant.expertSkillsScreen);
  }
}
