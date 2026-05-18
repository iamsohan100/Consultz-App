import 'dart:ui';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/text/custom_rich_text.dart';
import 'package:flutter/material.dart';

void editConfarmatonDialog({
  required BuildContext context,
  required String title,
  required String subtitle,
  required String buttonText,
final VoidCallback? onTapYes,
}) {
  final height = Screen.screenHeight(context);
  final width = Screen.screenWidth(context);
  final scaleFactor = width / Screen.designWidth;

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
                  SizedBox(height: height * 0.04),
                  CustomRichText(
                    text1: title,
                    fontSize1: 16,
                    fontWeight: FontWeight.w400,
                    color1: AppColors.black,
                    text2: "$subtitle?",
                    fontWeight2: FontWeight.w500,
                    color2: AppColors.black,
                    fontSize2: 16,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: height * 0.05),

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
                          onPressed:onTapYes?? () {
                            Navigator.of(context).pop();
                          },
                          title: 'Yes, change $buttonText',
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
