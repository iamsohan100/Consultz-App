import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/feature/Auth/controller/browse_first_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrentBoardDot extends StatelessWidget {
  const CurrentBoardDot({super.key, required this.screenNo});
  final int screenNo;
  @override
  Widget build(BuildContext context) {
    final width = Screen.screenWidth(context);
    final scaleFactor = width / Screen.designWidth;
    final browseFirstController = Get.find<BrowseFirstController>();

    final dotLength = browseFirstController.isConsultee.value ? 4 : 5;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        for (int i = 1; i < dotLength; i++)
          Container(
            height: scaleFactor * 8,
            width: screenNo == i ? width * 0.06 : scaleFactor * 8,
            margin: EdgeInsets.all(scaleFactor * 5),
            decoration: BoxDecoration(
              color: screenNo == i
                  ? AppColors.primaryColor
                  : AppColors.primaryColor.withValues(alpha: 0.5),
              borderRadius: (screenNo == i)
                  ? BorderRadius.circular(scaleFactor * 16)
                  : null,
              shape: screenNo == i ? BoxShape.rectangle : BoxShape.circle,
            ),
          ),
      ],
    );
  }
}
