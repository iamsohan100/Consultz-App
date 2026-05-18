import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/feature/Auth/controller/set_key_expertise_controller.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';

import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/widgets/interest_value_container.dart';
import 'package:consultz/feature/filter/widgets/filter_save_button.dart';
import 'package:flutter/material.dart';

import 'package:consultz/feature/filter/controller/filter_controller.dart';
import 'package:consultz/feature/filter/pages/filter_result_screen.dart';
import 'package:get/get.dart';

class FilterInterestsScreen extends StatelessWidget {
  const FilterInterestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final filterController = Get.find<FilterController>();
    final setKeyExpertiseController = Get.find<SetKeyExpertiseController>();

    return Scaffold(
      appBar: customAppBar(context: context, title: 'Interests'),
      bottomNavigationBar: FilterSaveButton(
        onTap: () {
          filterController.initialLoad();
          Get.to(() => const FilterResultScreen());
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: scaleFactor * 8,
              left: scaleFactor * 20,
              right: scaleFactor * 20,
              bottom: scaleFactor * 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: height * 0.01,
              children: [
                CustomText(
                  text:
                      'Get matched with the right experts, choose a few topics you’d like to learn more about.',
                  color: AppColors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  lineHeight: 1.6,
                ),
                SizedBox(height: height * 0.02),
                Obx(() {
                  final categories = setKeyExpertiseController.allCategoryList;
                  return Align(
                    alignment: .center,
                    child: Wrap(
                      spacing: width * 0.02,
                      runSpacing: height * 0.02,
                      alignment: .center,
                      crossAxisAlignment: .center,
                      children: [
                        for (int i = 0; i < categories.length; i++)
                          InterestValueContainer(
                            title: categories[i].title ?? '',
                            isSelected: filterController.selectedInterests
                                .contains(categories[i].title),
                            onTap: () => filterController.toggleInterest(
                              categories[i].title ?? '',
                            ),
                          ),
                      ],
                    ),
                  );
                }),
                SizedBox(height: height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
