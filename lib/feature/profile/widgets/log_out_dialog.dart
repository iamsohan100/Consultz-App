import 'dart:developer';

import 'package:consultz/feature/bookings/controller/socket_service_controller.dart';
import 'package:consultz/core/utils/share_preference/auth_preference.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/main/controller/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

void logOutDialog({required BuildContext context}) {
  final height = Screen.screenHeight(context);
  final width = Screen.screenWidth(context);
  final scaleFactor = width / Screen.designWidth;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: width,
          margin: EdgeInsets.only(
            left: width * 0.04, // side padding
            right: width * 0.04, // side padding
            bottom: height * 0.03, // bottom padding
          ),
          padding: EdgeInsets.all(scaleFactor * 16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(scaleFactor * 20),
          ),
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
                  Icons.logout_outlined,
                  color: AppColors.black,
                  size: scaleFactor * 35,
                ),
              ),
              SizedBox(height: height * 0.025),
              CustomText(
                text: "Logout",
                color: AppColors.black,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: height * 0.025),
              CustomText(
                text: "Would you like to logout of Consultz?",
                color: AppColors.darkGrey,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: height * 0.05),

              PrimaryButton(
                onPressed: () => Navigator.of(context).pop(),
                title: 'Cancel',
                backgroundColor: AppColors.white,
                borderColor: AppColors.primaryColor,
                textColor: AppColors.primaryColor,
                buttonHeight: height * 0.045,
                radius: 8,
              ),
              SizedBox(height: height * 0.015),

              PrimaryButton(
                onPressed: () async {
                  Navigator.of(context).pop();

                  // Google Sign Out
                  try {
                    final googleSignIn = GoogleSignIn();
                    await googleSignIn.signOut();
                  } catch (e) {
                    log("Google Sign Out Error: $e");
                  }

                  Get.find<MainController>().changeIndex(index: 0);
                  AuthPreference().clearAuthData();
                  Get.find<SocketServiceController>().disconnect();
                  Get.offAllNamed(RoutesConstant.browseFirstScreen);
                },
                title: 'Yes, logout',
                buttonHeight: height * 0.045,
                radius: 8,
              ),
            ],
          ),
        ),
      );
    },
  );
}
