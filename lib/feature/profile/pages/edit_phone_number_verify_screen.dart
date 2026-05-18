import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/widgets/otp_field.dart';
import 'package:consultz/feature/Auth/widgets/resend_otp.dart';
import 'package:consultz/feature/profile/widgets/edit_confirmation_dialog.dart';
import 'package:flutter/material.dart';

import 'package:consultz/feature/profile/controller/update_phone_number_controller.dart';
import 'package:get/get.dart';

class EditPhoneNumberVerifyScreen extends StatelessWidget {
  const EditPhoneNumberVerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final updatePhoneNumberController = Get.find<UpdatePhoneNumberController>();
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Verify it’s you',
        actions: [
          GestureDetector(
            onTap: () {
              editConfarmatonDialog(
                context: context,
                title: 'Are you sure you want to change your phone number to\n',
                subtitle:
                    '${updatePhoneNumberController.initCountryCode.value} ${updatePhoneNumberController.phoneNumberController.text}',
                buttonText: '',
                onTapYes: () {
                  Navigator.of(context).pop();
                  updatePhoneNumberController.verifyOtpAndUpdatePhone(context);
                },
              );
            },
            child: CustomText(
              text: 'Done',
              color: AppColors.primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: width * 0.05),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.all(scaleFactor * 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text:
                      'Please enter 4 digit verification code that have been sent to your mobile phone',
                  color: AppColors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: height * 0.02),
                CustomText(
                  text:
                      ' ${updatePhoneNumberController.initCountryCode.value} ${updatePhoneNumberController.phoneNumberController.text} ',
                  color: AppColors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: height * 0.06),

                Center(
                  child: OtpField(
                    isOtpComplete: updatePhoneNumberController.isOtpComplete,
                    otp: updatePhoneNumberController.otp,
                  ),
                ),
                SizedBox(height: height * 0.02),
                ResendOtp(
                  isUpdatePhone: true,
                  phone:
                      "${updatePhoneNumberController.initCountryCode.value}${updatePhoneNumberController.phoneNumberController.text}",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
