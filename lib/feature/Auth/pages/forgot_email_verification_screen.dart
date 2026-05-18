import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/controller/forgot_password_controller.dart';
import 'package:consultz/feature/Auth/widgets/otp_field.dart';
import 'package:consultz/feature/Auth/widgets/resend_otp.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ForgotEmailVerificationScreen extends StatelessWidget {
  const ForgotEmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final forgotPasswordController = Get.find<ForgotPasswordController>();
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    return Scaffold(
      appBar: customAppBar(context: context, title: 'Verify it’s you'),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.all(scaleFactor * 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text:
                      'Please enter 4 digit verification code that have been sent to your email address',
                  color: AppColors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: height * 0.02),
                CustomText(
                  text: ' ${forgotPasswordController.emailController.text}',
                  color: AppColors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: height * 0.06),

                Center(
                  child: OtpField(
                    isOtpComplete: forgotPasswordController.isOtpComplete,
                    otp: forgotPasswordController.otp,
                  ),
                ),

                SizedBox(height: height * 0.05),
                Obx(() {
                  return PrimaryButton(
                    title: 'Verify',
                    onPressed: forgotPasswordController.isOtpComplete.value
                        ? () {
                            forgotPasswordController.verifyOtpAndUpdateEmail(
                              context,
                            );
                          }
                        : null,
                    backgroundColor:
                        forgotPasswordController.isOtpComplete.value
                        ? AppColors.primaryColor
                        : AppColors.grey,
                  );
                }),
                SizedBox(height: height * 0.02),
                ResendOtp(
                  isForgotPassword: true,
                  email: forgotPasswordController.emailController.text,
                  isMail: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
