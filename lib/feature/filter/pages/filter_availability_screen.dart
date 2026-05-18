import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/feature/filter/model/availibity_data.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/widgets/interest_value_container.dart';
import 'package:consultz/feature/filter/widgets/filter_save_button.dart';
import 'package:flutter/material.dart';

import 'package:consultz/feature/filter/controller/filter_controller.dart';
import 'package:consultz/feature/filter/pages/filter_result_screen.dart';
import 'package:get/get.dart';

class FilterAvailabilityScreen extends StatelessWidget {
  const FilterAvailabilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final filterController = Get.find<FilterController>();

    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Availability',
      ),
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
                      'Find to the right experts by choosing the timeframe that would suit your schedule.',
                  color: AppColors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  lineHeight: 1.6,
                ),
                const SizedBox(),
                CustomText(
                  text: 'Days',
                  color: AppColors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(),
                Obx(() {
                  return Wrap(
                    spacing: width * 0.02,
                    runSpacing: height * 0.02,
                    children: [
                      for (int i = 0; i < AvailibityData.days.length; i++)
                        InterestValueContainer(
                          title: AvailibityData.days[i],
                          isSelected: filterController.selectedAvailability
                              .contains(AvailibityData.days[i]),
                          onTap: () => filterController
                              .toggleAvailability(AvailibityData.days[i]),
                        ),
                    ],
                  );
                }),
                SizedBox(height: height * 0.01),
                CustomText(
                  text: 'Times',
                  color: AppColors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(),
                Obx(() {
                  return Wrap(
                    spacing: width * 0.02,
                    runSpacing: height * 0.02,
                    children: [
                      for (int i = 0; i < AvailibityData.times.length; i++)
                        InterestValueContainer(
                          title: AvailibityData.times[i],
                          isSelected: filterController.selectedAvailability
                              .contains(AvailibityData.times[i]),
                          onTap: () => filterController
                              .toggleAvailability(AvailibityData.times[i]),
                        ),
                    ],
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
