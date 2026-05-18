// ignore_for_file: use_build_context_synchronously

import 'dart:ui';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/feature/discover/controller/report_controller.dart';
import 'package:consultz/feature/discover/widgets/report_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void reportDialog(BuildContext context, {required String feedId}) {
  final height = Screen.screenHeight(context);
  final width = Screen.screenWidth(context);
  final scaleFactor = width / Screen.designWidth;
  
  // Initialize controller
  final reportController = Get.find<ReportController>();

  showDialog(
    context: context,
    builder: (context) {
      return Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: const Color(
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
                padding: EdgeInsets.all(scaleFactor * 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const ReportItem(),

                    SizedBox(height: height * 0.03),

                    PrimaryButton(
                      onPressed: () async {
                        bool success = await reportController.submitReport(context, feedId: feedId);
                        if (success) {
                          Navigator.pop(context);
                        }
                      },
                      title: 'Submit',
                      radius: 12,
                      buttonHeight: height * 0.05,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
