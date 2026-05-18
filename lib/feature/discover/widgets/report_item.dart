import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/form_field/custom_form_field.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/discover/controller/report_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportItem extends StatelessWidget {
  const ReportItem({super.key});

  @override
  Widget build(BuildContext context) {
    final height = Screen.screenHeight(context);
    final width = Screen.screenWidth(context);
    final scaleFactor = width / Screen.designWidth;
    final reportController = Get.find<ReportController>();

    return Obx(() {
      return Column(
        children: [
          for (int i = 0; i < 6; i++) ...[
            Obx(() {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  reportController.selectedIndex.value = i;
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: scaleFactor * 16,
                      height: scaleFactor * 16,
                      margin: EdgeInsets.only(top: scaleFactor * 2.5),
                      decoration: BoxDecoration(
                        color: reportController.selectedIndex.value == i
                            ? AppColors.primaryColor
                            : Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.grey),
                      ),
                    ),
                    SizedBox(width: width * 0.02),
                    Expanded(
                      child: CustomText(
                        text: reportController.reportReasons[i],
                        color: AppColors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }),
            if (i != 5)
              Divider(color: AppColors.warmGrey, height: height * 0.032),
          ],
          if (reportController.selectedIndex.value == 5) ...[
            SizedBox(height: height * 0.0175),
            CustomFormField(
              controller: reportController.reasonController,
              hintText: 'Please enter report reason',
              minLine: 2,
              maxLine: 3,
              padding: scaleFactor * 10,
            ),
          ],
        ],
      );
    });
  }
}
