import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/filter/widgets/session_duration_check.dart';
import 'package:flutter/material.dart';

import 'package:consultz/feature/filter/controller/filter_controller.dart';
import 'package:get/get.dart';

class SessionDuration extends StatelessWidget {
  const SessionDuration({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final filterController = Get.find<FilterController>();

    final List<Map<String, dynamic>> durationData = [
      {'title': 'Introduction・15 minutes', 'value': 15},
      {'title': 'Discussion・30 minutes', 'value': 30},
      {'title': 'Deep dive・60 minutes', 'value': 60},
    ];

    return Padding(
      padding: EdgeInsets.only(
        top: scaleFactor * 4,
        left: scaleFactor * 14,
        right: scaleFactor * 14,
      ),
      child: Column(
        spacing: height * 0.015,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: 'Session duration',
            color: AppColors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          Obx(() {
            // Accessing the observable list length to ensure Obx works properly
            final _ = filterController.selectedSessionDurations.length;
            return ListView.separated(
              primary: false,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: durationData.length,
              itemBuilder: (_, index) {
                final item = durationData[index];
                return SessionDurationCheck(
                  title: item['title'],
                  isSelected: filterController.selectedSessionDurations
                      .contains(item['value']),
                  onTap: () =>
                      filterController.toggleSessionDuration(item['value']),
                );
              },
              separatorBuilder: (_, _) {
                return SizedBox(height: height * 0.015);
              },
            );
          }),
        ],
      ),
    );
  }
}
