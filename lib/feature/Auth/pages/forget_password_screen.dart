import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/form_field/custom_form_field.dart';
import 'package:consultz/feature/Auth/controller/forgot_password_controller.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final forgotPasswordController = Get.find<ForgotPasswordController>();

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    return Scaffold(
      appBar: customAppBar(context: context, title: 'Forgot Password'),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.all(scaleFactor * 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomText(
                  text:
                      'Your email address is never displayed or shared with anyone. We will send you a code to verify your email address.',
                  color: AppColors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: height * 0.02),
                CustomFormField(
                  controller: forgotPasswordController.emailController,
                  title: 'Email',
                  hintText: 'Enter your email',
                  textInputAction: TextInputAction.done,
                  isMail: true,
                ),
                SizedBox(height: height * 0.05),
                PrimaryButton(
                  title: 'Send  OTP',
                  onPressed: () {
                    forgotPasswordController.sendOtp(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
