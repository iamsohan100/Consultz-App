import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/filter/widgets/expert_rating_container.dart';
import 'package:consultz/feature/filter/controller/filter_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterExpertsRating extends StatelessWidget {
  const FilterExpertsRating({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final filterController = Get.find<FilterController>();

    return Column(
      spacing: height * 0.02,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: scaleFactor * 4,
            left: scaleFactor * 14,
            right: scaleFactor * 14,
          ),
          child: CustomText(
            text: 'Expert rating',
            color: AppColors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),

        Obx(() {
          return Wrap(
            // spacing: scaleFactor * 14,
            runSpacing: scaleFactor * 14,
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              for (int i = 1; i < 6; i++)
                ExpertRatingContainer(
                  title: '$i',
                  isSelected: filterController.rating.value == i,
                  onTap: () => filterController.setRating(i),
                ),
            ],
          );
        }),
      ],
    );
  }
}
