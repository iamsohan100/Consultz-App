import 'package:consultz/core/utils/helpers/validation_helper.dart';
import 'package:consultz/core/utils/message/top_message.dart';
import 'package:consultz/feature/profile/controller/change_password_controller.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/form_field/custom_form_field.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final changePasswordController = Get.find<ChangePasswordController>();

  @override
  void initState() {
    super.initState();
    changePasswordController.newPassword.addListener(_onPasswordChanged);
  }

  @override
  void dispose() {
    changePasswordController.newPassword.removeListener(_onPasswordChanged);
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
    String newPassword = changePasswordController.newPassword.text;

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
                    controller: changePasswordController.currentPassword,
                    title: 'Current password',
                    hintText: 'Current password',
                    isPassword: true,
                    isRequired: true,
                  ),
                  CustomFormField(
                    controller: changePasswordController.newPassword,
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
                        ValidationHelper.hasMinLength(newPassword) &&
                            ValidationHelper.hasMaxLength(newPassword),
                      ),
                      _buildRequirementRow(
                        'At least one uppercase letter',
                        ValidationHelper.hasUppercase(newPassword),
                      ),
                      _buildRequirementRow(
                        'At least one lowercase letter',
                        ValidationHelper.hasLowercase(newPassword),
                      ),
                      _buildRequirementRow(
                        'At least one number',
                        ValidationHelper.hasNumber(newPassword),
                      ),
                      _buildRequirementRow(
                        'At least one special character (!\$@%)',
                        ValidationHelper.hasSpecialChar(newPassword),
                      ),
                    ],
                  ),

                  CustomFormField(
                    controller: changePasswordController.confirmPassword,
                    title: 'Confirm new password',
                    hintText: 'Confirm new password',
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != changePasswordController.newPassword.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: height * 0.02),
                  PrimaryButton(onPressed: reset, title: 'Change password'),
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

  Future<void> reset() async {
    if (_formKey.currentState!.validate()) {
      bool isSuccess = await changePasswordController.changePassword(
        context,
      );
      if (isSuccess && mounted) {
        topMessage(
          msg: 'Password changed successfully',
          title: 'Successful',
        );
        Navigator.pop(context);
        Navigator.pop(context);
      }
    }
  }

}
