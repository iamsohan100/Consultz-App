import 'dart:ui';

import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/share_preference/auth_preference.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:consultz/feature/expert/controller/invite_friend_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void referralDialog({required BuildContext context}) {
  final height = Screen.screenHeight(context);
  final width = Screen.screenWidth(context);
  final scaleFactor = width / Screen.designWidth;
  final inviteFriendController = Get.find<InviteFriendController>();
  final profileController = Get.find<ProfileController>();
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
            backgroundColor: AppColors.primaryColor,
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
                    alignment: .topRight,
                    child: GestureDetector(
                      behavior: .opaque,
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.close_rounded,
                        color: AppColors.white,
                        size: scaleFactor * 20,
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: height * 0.005,
                                horizontal: width * 0.025,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFFFFE8E8),
                                borderRadius: BorderRadius.circular(
                                  scaleFactor * 33,
                                ),
                                border: Border.all(
                                  color: Color(
                                    0xFFFFBCBC,
                                  ).withValues(alpha: 0.68),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: .min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,

                                children: [
                                  Image.asset(
                                    AppImages.icon,
                                    width: scaleFactor * 24,
                                  ),
                                  SizedBox(width: width * 0.02),
                                  CustomText(
                                    text: '500',
                                    color: AppColors.primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: height * 0.012),
                            CustomText(
                              text: 'Earn 500 Points!',
                              color: AppColors.white,
                              fontSize: scaleFactor * 18,
                              fontWeight: FontWeight.w700,
                            ),
                            SizedBox(height: height * 0.007),
                            CustomText(
                              text:
                                  '''Know other experts who could monetise their knowledge on Consultz from day one?

Invite them to join and earn 500 Consultz Points for every approved expert referral.

Click the button below to share your referral link.''',
                              color: AppColors.white,
                              fontSize: 12,
                              fontWeight: .w400,
                              lineHeight: 1.5,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: width * 0.01),
                      Image.asset(AppImages.referralCongrate, scale: 4),
                    ],
                  ),
                  SizedBox(height: height * 0.01),
                  Align(
                    alignment: .topRight,
                    child: Obx(() {
                      return CustomText(
                        text: inviteFriendController.isCoppied.value
                            ? 'Coppied'
                            : 'Copy this referral code',
                        color: AppColors.white,
                        fontSize: 12,
                        fontWeight: .w400,
                      );
                    }),
                  ),
                  SizedBox(height: height * 0.01),
                  GestureDetector(
                    onTap: () async {
                      inviteFriendController.copyReferalCode();
                    },
                    child: Container(
                      width: width,
                      height: height * 0.055,
                      alignment: Alignment.center,
                      padding: .symmetric(
                        vertical: scaleFactor * 10,
                        horizontal: scaleFactor * 18,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(scaleFactor * 12),
                      ),
                      child: Row(
                        mainAxisAlignment: .center,
                        children: [
                          Expanded(
                            child: Obx(() {
                              if (profileController.inProgress.value) {
                                return CustomText(
                                  text: "Your code: Loading...",
                                  color: AppColors.primaryColor,
                                  fontSize: 14,
                                  fontWeight: .w500,
                                  textOverflow: .ellipsis,
                                );
                              }
                              return CustomText(
                                text:
                                    "Your code: ${inviteFriendController.referalCode.value}",
                                color: AppColors.primaryColor,
                                fontSize: 14,
                                fontWeight: .w500,
                                textOverflow: .ellipsis,
                              );
                            }),
                          ),
                          SizedBox(width: width * 0.03),

                          Icon(
                            Icons.copy_rounded,
                            size: scaleFactor * 18,
                            color: AppColors.primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.015),

                  PrimaryButton(
                    onPressed: () {
                      inviteFriendController.inviteFriend();
                    },
                    title: 'Invite Friends',
                    radius: 24,
                    // buttonHeight: 40,
                    textColor: AppColors.primaryColor,
                    backgroundColor: AppColors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    },
  ).then((_) async {
    await AuthPreference().setReferralDialogShown();
  });
}
