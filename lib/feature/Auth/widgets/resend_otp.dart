import 'dart:async';

import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/text/custom_rich_text.dart';
import 'package:consultz/feature/Auth/controller/forgot_password_controller.dart';
import 'package:consultz/feature/Auth/controller/resend_otp_controller.dart';
import 'package:consultz/feature/Auth/controller/sign_up_controller.dart';
import 'package:consultz/feature/profile/controller/update_phone_number_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResendOtp extends StatefulWidget {
  const ResendOtp({
    super.key,
    this.email,
    this.phone,
    this.isMail = false,
    this.isUpdatePhone,
    this.isForgotPassword,
    this.isSignUp,
  });
  final String? email;
  final String? phone;
  final bool isMail;
  final bool? isUpdatePhone;
  final bool? isForgotPassword;
  final bool? isSignUp;
  @override
  State<ResendOtp> createState() => _ResendOtpState();
}

class _ResendOtpState extends State<ResendOtp> {
  RxInt timeInSecond = 60.obs;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeInSecond.value > 0) {
        timeInSecond.value--;
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final resendOtpController = Get.find<ResendOtpController>();
    final updatePhoneNumberController = Get.find<UpdatePhoneNumberController>();
    final forgotPasswordController = Get.find<ForgotPasswordController>();
    final signUpController = Get.find<SignUpController>();
    return Center(
      child: GestureDetector(
        onTap: () async {
          if (timeInSecond.value == 0) {
            final response = await resendOtpController.resendOtp(
              context,
              isMail: widget.isMail,
              email: widget.email,
              phone: widget.phone,
              isUpdatePhone: widget.isUpdatePhone,
            );
            if (response) {
              timeInSecond.value = 60;
              _timer = Timer.periodic(Duration(seconds: 1), (timer) {
                if (timeInSecond.value > 0) {
                  timeInSecond.value--;
                } else {
                  _timer?.cancel();
                }
              });
              if (widget.isUpdatePhone == true) {
                updatePhoneNumberController.verifyToken =
                    resendOtpController.verifyToken;
              }
              if (widget.isForgotPassword == true) {
                forgotPasswordController.verifyToken =
                    resendOtpController.verifyToken;
              }
              if (widget.isSignUp == true) {
                signUpController.verifyToken = resendOtpController.verifyToken;
              }
            }
          }
        },
        child: Obx(() {
          final minutes = (timeInSecond.value ~/ 60).toString().padLeft(2, '0');
          final seconds = (timeInSecond.value % 60).toString().padLeft(2, '0');

          return CustomRichText(
            text1: "Don’t Have OTP? ",

            fontSize1: 10,
            color1: AppColors.black,
            fontWeight: FontWeight.w600,
            fontWeight2: FontWeight.w600,

            text2: timeInSecond.value == 0 ? "Resend OTP" : "$minutes:$seconds",
            color2: AppColors.primaryColor,
            fontSize2: 12,
          );
        }),
      ),
    );
  }
}
