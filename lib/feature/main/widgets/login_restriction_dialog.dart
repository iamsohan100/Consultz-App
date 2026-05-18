import 'dart:ui';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void loginRestrictionDialog({required BuildContext context}) {
  final height = Screen.screenHeight(context);
  final width = Screen.screenWidth(context);
  final scaleFactor = width / Screen.designWidth;

  showDialog(
    context: context,
    // prevent dismissal by tapping outside
    barrierDismissible: true,
    builder: (context) {
      return Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: const Color(0xFF171725).withValues(alpha: 0.24),
            ),
          ),
          Dialog(
            backgroundColor: AppColors.white,
            insetPadding: EdgeInsets.symmetric(horizontal: width * 0.08),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(scaleFactor * 16),
            ),
            child: Container(
              padding: EdgeInsets.all(scaleFactor * 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: scaleFactor * 80,
                    height: scaleFactor * 80,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.lock_person_rounded,
                        color: AppColors.primaryColor,
                        size: scaleFactor * 40,
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.025),
                  CustomText(
                    text: 'Login Required',
                    color: AppColors.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: height * 0.015),
                  CustomText(
                    text:
                        'To enjoy all the features, you need to sign up or log in first.',
                    color: AppColors.darkGrey,
                    fontSize: 14,
                    fontWeight: .w500,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: height * 0.035),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          title: 'Cancel',
                          radius: 12,
                          backgroundColor: AppColors.transparent,
                          textColor: AppColors.primaryColor,
                          borderColor: AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(width: width * 0.03),
                      Expanded(
                        child: PrimaryButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Get.offAllNamed(RoutesConstant.browseFirstScreen);
                          },
                          title: 'Login / Sign Up',
                          radius: 12,
                          backgroundColor: AppColors.primaryColor,
                          textColor: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    },
  );
}
