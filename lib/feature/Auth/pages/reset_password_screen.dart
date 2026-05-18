import 'package:consultz/core/utils/helpers/validation_helper.dart';
import 'package:consultz/core/utils/message/top_message.dart';
import 'package:consultz/feature/Auth/controller/forgot_password_controller.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/form_field/custom_form_field.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final forgotPasswordController = Get.find<ForgotPasswordController>();

  @override
  void initState() {
    super.initState();
    forgotPasswordController.passwordController.addListener(_onPasswordChanged);
  }

  @override
  void dispose() {
    forgotPasswordController.passwordController.removeListener(
      _onPasswordChanged,
    );
    super.dispose();
  }

  void _onPasswordChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    String password = forgotPasswordController.passwordController.text;

    return Scaffold(
      appBar: customAppBar(context: context, title: 'Password'),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.all(scaleFactor * 16),
            child: Form(
              key: _formKey,
              child: Column(
                spacing: height * 0.02,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text:
                        'Your new password must be between 8 and 20 characters long and include a mix of uppercase and lowercase letters, numbers, and special characters (!\$@%).',
                    color: AppColors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(),
                  CustomFormField(
                    controller: forgotPasswordController.passwordController,
                    title: 'New password',
                    hintText: 'New password',
                    isPassword: true,
                    isPasswordValidation: true,
                  ),

                  // Real-time Validation Checklist
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: height * 0.005,
                    children: [
                      _buildRequirementRow(
                        '8-20 characters',
                        ValidationHelper.hasMinLength(password) &&
                            ValidationHelper.hasMaxLength(password),
                      ),
                      _buildRequirementRow(
                        'At least one uppercase letter',
                        ValidationHelper.hasUppercase(password),
                      ),
                      _buildRequirementRow(
                        'At least one lowercase letter',
                        ValidationHelper.hasLowercase(password),
                      ),
                      _buildRequirementRow(
                        'At least one number',
                        ValidationHelper.hasNumber(password),
                      ),
                      _buildRequirementRow(
                        'At least one special character (!\$@%)',
                        ValidationHelper.hasSpecialChar(password),
                      ),
                    ],
                  ),

                  CustomFormField(
                    controller:
                        forgotPasswordController.confirmPasswordController,
                    title: 'Confirm new password',
                    hintText: 'Confirm new password',
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value !=
                          forgotPasswordController.passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: height * 0.02),

                  PrimaryButton(onPressed: reset, title: 'Reset password'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRequirementRow(String text, bool isMet) {
    return Row(
      children: [
        Icon(
          isMet ? Icons.check_circle : Icons.cancel,
          color: isMet ? Colors.green : Colors.grey,
          size: 16,
        ),
        const SizedBox(width: 8),
        CustomText(
          text: text,
          color: isMet ? Colors.green : Colors.grey,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }

  Future<void> reset() async {
    if (_formKey.currentState!.validate()) {
      bool isSuccess = await forgotPasswordController.resetPassword(context);
      if (isSuccess && mounted) {
        topMessage(msg: 'Password reset successful', title: 'Successful');
        Get.offAllNamed(RoutesConstant.loginScreen);
      }
    }
  }
}
