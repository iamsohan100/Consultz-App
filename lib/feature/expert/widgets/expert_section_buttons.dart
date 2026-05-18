import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/expert/controller/expert_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpertSectionButtons extends StatelessWidget {
  const ExpertSectionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final expertDetailViewModel = Get.find<ExpertDetailController>();
    GestureDetector button({
      required String title,
      required VoidCallback onTap,
      required bool isSelected,
    }) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.only(
            bottom: height * 0.01,
            right: width * 0.04,
            left: width * 0.03,
          ),
          decoration: BoxDecoration(
            color: Colors.transparent,

            border: Border(
              bottom: BorderSide(
                color: isSelected ? AppColors.primaryColor : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          alignment: Alignment.center,
          child: CustomText(
            text: title,
            color: isSelected ? AppColors.primaryColor : AppColors.black,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: scaleFactor * 14),
      child: Column(
        children: [
          Obx(() {
            return Row(
              spacing: width * 0.04,
              children: [
                button(
                  onTap: () {
                    expertDetailViewModel.isOverView.value = true;
                    expertDetailViewModel.isReviews.value = false;
                    expertDetailViewModel.isContent.value = false;
                  },
                  title: 'Overview',
                  isSelected: expertDetailViewModel.isOverView.value,
                ),
                button(
                  onTap: () {
                    expertDetailViewModel.isOverView.value = false;
                    expertDetailViewModel.isReviews.value = true;
                    expertDetailViewModel.isContent.value = false;
                  },
                  title: 'Reviews',
                  isSelected: expertDetailViewModel.isReviews.value,
                ),
                button(
                  onTap: () {
                    expertDetailViewModel.isOverView.value = false;
                    expertDetailViewModel.isReviews.value = false;
                    expertDetailViewModel.isContent.value = true;
                  },
                  title: 'Content',
                  isSelected: expertDetailViewModel.isContent.value,
                ),
              ],
            );
          }),
          Container(
            width: width,
            height: height * 0.002,
            decoration: BoxDecoration(
              color: Color(0xFFE5E5E5),
              borderRadius: BorderRadius.circular(scaleFactor * 4),
            ),
          ),
        ],
      ),
    );
  }
}
