import 'dart:ui';

import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/form_field/custom_form_field.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void userRatingDialog({required BuildContext context}) {
  final height = Screen.screenHeight(context);
  final width = Screen.screenWidth(context);
  final scaleFactor = width / Screen.designWidth;
  final rating = 0.obs;
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
            child: Padding(
              padding: EdgeInsets.all(scaleFactor * 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: height * 0.01),
                  Obx(() {
                    return Row(
                      mainAxisAlignment: .center,
                      spacing: width * 0.01,
                      children: [
                        for (int i = 1; i < 6; i++)
                          GestureDetector(
                            onTap: () {
                              rating.value = i;
                            },
                            child: Icon(
                              rating.value >= i
                                  ? Icons.star_rounded
                                  : Icons.star_border,
                              color: rating.value >= i
                                  ? Colors.amber
                                  : AppColors.grey,
                              size: scaleFactor * 34,
                            ),
                          ),
                      ],
                    );
                  }),
                  SizedBox(height: height * 0.01),

                  CustomText(
                    text: 'Rate your experience',
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: height * 0.01),

                  CustomText(
                    text:
                        'Your feedback helps improve our community and build trust between users. Please share your experience to continue using the app.',
                    color: AppColors.darkGrey,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: height * 0.02),

                  CustomFormField(
                    hintText: 'Add comments...',

                    minLine: 4,
                    maxLine: 4,
                    padding: scaleFactor * 10,
                    horPadding: scaleFactor * 9,
                  ),
                  SizedBox(height: height * 0.03),

                  Row(
                    spacing: width * 0.04,
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          title: 'Cancel',

                          backgroundColor: AppColors.white,
                          borderColor: AppColors.primaryColor,
                          textColor: AppColors.primaryColor,
                          buttonHeight: height * 0.045,
                          radius: 8,
                        ),
                      ),
                      Expanded(
                        child: PrimaryButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          title: 'Submit',
                          buttonHeight: height * 0.045,
                          radius: 8,
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
