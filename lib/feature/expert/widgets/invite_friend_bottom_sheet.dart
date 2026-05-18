import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/expert/controller/invite_friend_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void inviteFriendBottomSheet(BuildContext context) {
  final height = Screen.screenHeight(context);
  final width = Screen.screenWidth(context);
  final scaleFactor = width / Screen.designWidth;
  final inviteFriendController = Get.find<InviteFriendController>();
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    // backgroundColor: AppColors.primaryColor,
    barrierColor: Colors.transparent,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: .only(
        topRight: Radius.circular(scaleFactor * 32),
        topLeft: Radius.circular(scaleFactor * 32),
      ),
    ),

    builder: (context) {
      return Container(
        constraints: BoxConstraints(maxHeight: height * 0.8),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,

          borderRadius: .only(
            topRight: Radius.circular(scaleFactor * 32),
            topLeft: Radius.circular(scaleFactor * 32),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: scaleFactor * 22,
            right: scaleFactor * 22,
            top: scaleFactor * 28,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: .start,
            children: [
              Row(
                mainAxisSize: .min,
                children: [
                  CustomText(
                    text: 'Earn 500 Points!',
                    color: AppColors.white,
                    fontSize: 15,
                    fontWeight: .w500,
                  ),

                  Spacer(),
                  GestureDetector(
                    behavior: .opaque,
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close_rounded,
                      color: AppColors.white,
                      size: scaleFactor * 20,
                    ),
                  ),
                ],
              ),

              Flexible(
                child: SingleChildScrollView(
                  child: Obx(() {
                    return Column(
                      crossAxisAlignment: .start,
                      mainAxisSize: .min,
                      children: [
                        SizedBox(height: height * 0.008),

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
                        SizedBox(height: height * 0.02),
                        Align(
                          alignment: .topRight,
                          child: CustomText(
                            text: inviteFriendController.isCoppied.value
                                ? 'Coppied'
                                : 'Copy this referral code',
                            color: AppColors.white,
                            fontSize: 12,
                            fontWeight: .w400,
                          ),
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
                              borderRadius: BorderRadius.circular(
                                scaleFactor * 12,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: .center,
                              children: [
                                Expanded(
                                  child: CustomText(
                                    text:
                                        "Your code: ${inviteFriendController.referalCode.value}",
                                    color: AppColors.primaryColor,
                                    fontSize: 14,
                                    fontWeight: .w500,
                                    textOverflow: .ellipsis,
                                  ),
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
                        SizedBox(height: height * 0.02),
                        PrimaryButton(
                          onPressed: () {
                            inviteFriendController.inviteFriend();
                          },
                          title: 'Invite Friends',
                          radius: 24,
                          textColor: AppColors.primaryColor,
                          backgroundColor: AppColors.white,
                        ),
                        SizedBox(height: height * 0.04),
                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
