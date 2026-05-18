// ignore_for_file: use_build_context_synchronously

import 'dart:ui';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/profile/controller/blocked_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void unblockDialog({
  required BuildContext context,
  required String title,
  required String userId,
}) {
  final height = Screen.screenHeight(context);
  final width = Screen.screenWidth(context);
  final scaleFactor = width / Screen.designWidth;
  final blockedUserController = Get.find<BlockedUserController>();
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
                  // SizedBox(height: height * 0.04),
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
                    text: "Unblock $title?",
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(height: height * 0.03),
                  CustomText(
                    text:
                        "You and $title will now be able to view each other’s content and book sessions.",
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
                          onPressed: () async {
                            await blockedUserController.unblockedUser(
                              context,
                              userId: userId,
                            );

                            Navigator.of(context).pop();
                          },
                          title: 'Yes, unblock',
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
