import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/feature/Auth/controller/sign_up_controller.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/form_field/phone_form_field.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/widgets/filling_steps.dart';
import 'package:consultz/feature/Auth/widgets/mobile_verification_progress_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FillMobileDataScreen extends StatefulWidget {
  const FillMobileDataScreen({super.key});

  @override
  State<FillMobileDataScreen> createState() => _FillMobileDataScreenState();
}

class _FillMobileDataScreenState extends State<FillMobileDataScreen> {
  final signUpController = Get.find<SignUpController>();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    return Scaffold(
      appBar: customAppBar(title: '', context: context),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.only(
              top: scaleFactor * 8,
              left: scaleFactor * 20,
              right: scaleFactor * 20,
              bottom: scaleFactor * 20,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: height * 0.016,
                children: [
                  FillingSteps(currentScreen: 1),
                  SizedBox(),
                  MobileVerificationProgressContainer(
                    progress: 0.24,
                    image: AppImages.mobile,
                    imageSize: 20,
                  ),
                  SizedBox(),
                  CustomText(
                    text: 'Verify your\nmobile number',
                    color: AppColors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.center,
                  ),
                  CustomText(
                    text:
                        'Your mobile number is never displayed or shared with anyone. We will send you a code to verify your number.',
                    color: AppColors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center,
                    lineHeight: 1.6,
                  ),
                  SizedBox(height: height * 0.01),
                  PhoneFormField(
                    controller: signUpController.phoneNumberController,
                    initCountryCode: signUpController.initCountryCode,
                  ),
                  SizedBox(height: height * 0.02),
                  PrimaryButton(onPressed: verify, title: 'Verify'),
                  SizedBox(height: height * 0.1),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> verify() async {
    if (_formKey.currentState!.validate()) {
      if (signUpController.phoneNumberController.text.isNotEmpty) {
        final response = await signUpController.signUP(context);
        if (response) {
          Get.toNamed(RoutesConstant.otpVerificationScreen);
        }
      } else {
        bottomMessage(msg: "Please enter your phone number");
      }
    }
  }
}
