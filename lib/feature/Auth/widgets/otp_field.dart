import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpField extends StatefulWidget {
  final RxBool isOtpComplete;
  final RxString otp;
  const OtpField({super.key, required this.isOtpComplete, required this.otp});

  @override
  State<OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  final otpTEController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.isOtpComplete.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = Screen.screenWidth(context);
    final scaleFactor = width / Screen.designWidth;
    // final height = Screen.screenHeight(context);
    return Column(
      children: [
        SizedBox(
          width: width * 0.8,
          child: PinCodeTextField(
            controller: otpTEController,
            appContext: context,
            pastedTextStyle: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
            length: 4,
            obscureText: true,
            obscuringCharacter: '*',
            blinkWhenObscuring: true,

            animationType: AnimationType.fade,
            validator: (v) {
              if (v!.length < 4) {
                return "Fill up all the cells properly";
              } else {
                return null;
              }
            },
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(scaleFactor * 16),
              fieldHeight: scaleFactor * 64,
              fieldWidth: scaleFactor * 64,
              activeFillColor: AppColors.white,
              activeColor: AppColors.midGrey,
              selectedFillColor: AppColors.white,
              inactiveFillColor: AppColors.white,
              inactiveColor: AppColors.warmGrey,
            ),
            cursorColor: Colors.black,
            animationDuration: const Duration(milliseconds: 300),
            enableActiveFill: true,
            keyboardType: TextInputType.number,
            onCompleted: (_) {
              widget.isOtpComplete.value = true;
              widget.otp.value = otpTEController.text;
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    otpTEController.dispose();
    super.dispose();
  }
}
