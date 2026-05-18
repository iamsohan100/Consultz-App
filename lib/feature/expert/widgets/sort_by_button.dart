import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/expert/controller/expert_detail_controller.dart';
import 'package:consultz/feature/expert/controller/expert_review_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SortByButton extends StatelessWidget {
  const SortByButton({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    // double scaleFactor = width / Screen.designWidth;
    final expertDetailController = Get.find<ExpertDetailController>();
    final reviewController = Get.find<ExpertReviewController>(); 

    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height * 0.01),
          CustomText(
            text: 'Sorty by',
            color: AppColors.black,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(height: height * 0.012),
          Row(
            spacing: width * 0.04,
            children: [
              PrimaryButton(
                onPressed: () {
                  expertDetailController.isLatest.value = true;
                  expertDetailController.isHighest.value = false;
                  expertDetailController.isLowest.value = false;
                   reviewController.initialLoad(sor: 'latest');
                },
                title: 'Latest',
                backgroundColor: expertDetailController.isLatest.value
                    ? AppColors.primaryColor.withValues(alpha: 0.08)
                    : AppColors.darkGrey.withValues(alpha: 0.05),
                textColor: expertDetailController.isLatest.value
                    ? AppColors.primaryColor
                    : AppColors.darkGrey,
                fontSize: 10,
                fontWeight: FontWeight.w500,
                buttonWidth: width * 0.155,
                buttonHeight: height * 0.032,
                radius: 12,
              ),
              PrimaryButton(
                onPressed: () {
                  expertDetailController.isLatest.value = false;
                  expertDetailController.isHighest.value = true;
                  expertDetailController.isLowest.value = false;
                  reviewController.initialLoad(sor: 'highest');
                },
                title: 'Highest',
                backgroundColor: expertDetailController.isHighest.value
                    ? AppColors.primaryColor.withValues(alpha: 0.08)
                    : AppColors.darkGrey.withValues(alpha: 0.05),
                textColor: expertDetailController.isHighest.value
                    ? AppColors.primaryColor
                    : AppColors.darkGrey,
                fontSize: 10,
                fontWeight: FontWeight.w500,
                buttonWidth: width * 0.155,
                buttonHeight: height * 0.032,
                radius: 12,
              ),
              PrimaryButton(
                onPressed: () {
                  expertDetailController.isLatest.value = false;
                  expertDetailController.isHighest.value = false;
                  expertDetailController.isLowest.value = true;
                  reviewController.initialLoad(sor: 'lowest');
                },
                title: 'Lowest',
                backgroundColor: expertDetailController.isLowest.value
                    ? AppColors.primaryColor.withValues(alpha: 0.08)
                    : AppColors.darkGrey.withValues(alpha: 0.05),
                textColor: expertDetailController.isLowest.value
                    ? AppColors.primaryColor
                    : AppColors.darkGrey,
                fontSize: 10,
                fontWeight: FontWeight.w500,
                buttonWidth: width * 0.155,
                buttonHeight: height * 0.032,
                radius: 12,
              ),
            ],
          ),
        ],
      );
    });
  }
}
