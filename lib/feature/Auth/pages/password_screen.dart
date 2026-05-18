import 'package:consultz/core/utils/helpers/validation_helper.dart';
import 'package:consultz/feature/Auth/controller/sign_up_controller.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/form_field/custom_form_field.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final signUpController = Get.find<SignUpController>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    signUpController.passwordController.addListener(_onPasswordChanged);
  }

  @override
  void dispose() {
    signUpController.passwordController.removeListener(_onPasswordChanged);
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
    String password = signUpController.passwordController.text;

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
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: height * 0.016,
                children: [
                  CustomText(
                    text: 'Password',
                    color: AppColors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                  CustomText(
                    text:
                        'Your password must be between 8 and 20 characters long and include a mix of uppercase and lowercase letters, numbers, and special characters (!\$@%).',
                    color: AppColors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  // SizedBox(),
                  CustomFormField(
                    controller: signUpController.passwordController,
                    title: 'Create password',
                    hintText: 'Create password',
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
                    controller: signUpController.confirmPassController,
                    title: 'Confirm password',
                    hintText: 'Confirm password',
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != signUpController.passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: height * 0.02),
                  PrimaryButton(
                    onPressed: confirmPassword,
                    title: 'Confirm your password',
                  ),
                  SizedBox(height: height * 0.1),
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

  Future<void> confirmPassword() async {
    if (_formKey.currentState!.validate()) {
      Get.toNamed(RoutesConstant.fillMobileDataScreen);
    }
  }
}
