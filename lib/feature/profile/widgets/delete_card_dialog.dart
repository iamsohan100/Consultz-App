import 'dart:ui';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';

void deleteCardDialog({
  required BuildContext context,
  required String holderName,
  required String lastFour,
  required String expiry,
  required VoidCallback onDelete,
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
              color: const Color(0xFF171725).withValues(alpha: 0.24), // Slight dark overlay
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
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close_rounded,
                        color: AppColors.darkGrey,
                        size: scaleFactor * 20,
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  CustomText(
                    text:
                        "Would you like to delete the following payment method?",
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center,
                    lineHeight: 1.5,
                  ),
                  SizedBox(height: height * 0.03),

                  CustomText(
                    text: "Card Ending in ($lastFour)\n$holderName – Exp $expiry",
                    color: AppColors.darkGrey,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center,
                    lineHeight: 1.5,
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
                          onPressed: () {
                            Navigator.of(context).pop();
                            onDelete();
                          },
                          title: 'Yes, delete',
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
