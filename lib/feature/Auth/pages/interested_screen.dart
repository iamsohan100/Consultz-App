import 'package:consultz/core/utils/message/bottom_message.dart';
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

class InterestedScreen extends StatelessWidget {
  const InterestedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
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
                        setKeyExpertiseController.allCategoryList;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: height * 0.01,
                      children: [
                        CustomText(
                          text: 'What topics are you interested in?',
                          color: AppColors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,

                          lineHeight: 1.4,
                        ),
                        CustomText(
                          text:
                              'Get matched with the right experts, choose a few topics you’d like to learn more about.',
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
                               for (final category in categories)
                                  InterestValueContainer(
                                    onTap: () {
                                      if (setKeyExpertiseController
                                          .selectedCategoryList
                                          .any((e) => e.sId == category.sId)) {
                                        setKeyExpertiseController
                                            .selectedCategoryList
                                            .removeWhere(
                                              (e) => e.sId == category.sId,
                                            );
                                      } else {
                                        setKeyExpertiseController
                                            .selectedCategoryList
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
          ],
        ),
      ),
    );
  }
}

Future<void> continu(BuildContext context) async {
  final setKeyExpertiseController = Get.find<SetKeyExpertiseController>();
  if (setKeyExpertiseController.selectedCategoryList.isEmpty) {
    bottomMessage(msg: "Please select your interests");
    return;
  }

  setKeyExpertiseController.loadCategoryItems();

  Get.toNamed(RoutesConstant.interestedSubCategoryScreen);
}
