import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void bottomMessage({required String? msg}) {
  Get.snackbar(
    '',
    '',
    duration: const Duration(seconds: 3),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: AppColors.black.withValues(alpha: 0.7),
    margin: EdgeInsets.all(10),
    padding: .only(left: 16, right: 16, top: 10, bottom: 7),
    messageText: const SizedBox.shrink(),
    titleText: CustomText(
      text: msg ?? 'Something went wrong',
      color: AppColors.white,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
  );
}
