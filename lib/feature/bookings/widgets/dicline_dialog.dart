import 'dart:ui';

import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/form_field/custom_form_field.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void diclineDialog({
  required String expertId,
  required BuildContext context,
  required TextEditingController reasonController,
  required VoidCallback onTap,
}) {
  final height = Screen.screenHeight(context);
  final width = Screen.screenWidth(context);
  final scaleFactor = width / Screen.designWidth;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    builder: (context) {
      return Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Color(
                0xFF171725,
              ).withValues(alpha: 0.24), // Slight dark overlay
            ),
          ),
          Dialog(
            backgroundColor: AppColors.white,
            insetPadding: EdgeInsets.symmetric(horizontal: width * 0.06),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(scaleFactor * 20),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(scaleFactor * 16),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Icon(
                            Icons.close_rounded,
                            color: AppColors.darkGrey,
                            size: scaleFactor * 20,
                          ),
                        ),
                      ),
                      Container(
                        width: scaleFactor * 76,
                        height: scaleFactor * 76,
                        decoration: BoxDecoration(
                          color: AppColors.warmGrey,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.warning_amber_rounded,
                          color: AppColors.black,
                          size: scaleFactor * 35,
                        ),
                      ),
                      SizedBox(height: height * 0.025),
                      CustomText(
                        text: "Decline, are you sure?",
                        color: AppColors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: height * 0.02),
                      CustomText(
                        text:
                            "If your availability has changed, you can offer Sam an alternative time.",
                        color: AppColors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: height * 0.025),
                      CustomFormField(
                        controller: reasonController,
                        hintText: "Reason for declining",
                        title: "Decline Reason",
                        isRequired: true,
                        isValidator: true,
                        minLine: 3,
                        maxLine: 5,
                        padding: scaleFactor * 10,
                        horPadding: scaleFactor * 10,
                      ),
                      SizedBox(height: height * 0.04),
                      PrimaryButton(
                        onPressed: () {
                          Get.back();
                          Get.toNamed(
                            RoutesConstant.selectSessionScreen,
                            arguments: expertId,
                          );
                        },
                        title: 'Reschedule',
                        backgroundColor: AppColors.white,
                        borderColor: AppColors.primaryColor,
                        textColor: AppColors.primaryColor,
                        buttonHeight: height * 0.045,
                        radius: 8,
                      ),
                      SizedBox(height: height * 0.015),
                      PrimaryButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            onTap();
                          }
                        },
                        title: 'Decline',
                        buttonHeight: height * 0.045,
                        radius: 8,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
