import 'package:flutter/material.dart';
import 'package:get/get.dart';

void topMessage({
  required String title,
  required String msg,
  Color? textColor,
}) {
  Get.snackbar(
    title,
    msg,
    // colorText: textColor ?? AppColors.white,
    duration: const Duration(seconds: 3),
    snackPosition: SnackPosition.TOP,
  );
}
