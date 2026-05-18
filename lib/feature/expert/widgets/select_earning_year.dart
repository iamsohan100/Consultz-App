import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/expert/controller/withdraw_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectEarningYear extends StatelessWidget {
  const SelectEarningYear({
    super.key,

  });



  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WithdrawController());
    double width = Screen.screenWidth(context);

    double scaleFactor = width / Screen.designWidth;
    return Obx(
      () => PopupMenuButton<String>(
        color: AppColors.white,
        offset: const Offset(0, 45),
        onSelected: (year) => controller.initialLoad(year),
        itemBuilder: (context) => controller.availableYears
            .map(
              (year) => PopupMenuItem(
                value: year,
                child: CustomText(
                  text: year,
                  color: AppColors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
            .toList(),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: scaleFactor * 12,
            vertical: scaleFactor * 6,
          ),
          decoration: BoxDecoration(
            color: AppColors.midGrey.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(scaleFactor * 20),
          ),
          child: Row(
            children: [
              CustomText(
                text: controller.selectedYear.value,
                color: AppColors.black,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.black,
                size: scaleFactor * 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
