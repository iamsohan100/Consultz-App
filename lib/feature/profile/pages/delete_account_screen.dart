import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/form_field/custom_form_field.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:consultz/feature/profile/controller/delete_account_controller.dart';

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final deleteAccountController = Get.find<DeleteAccountController>();
    return Scaffold(
      appBar: customAppBar(context: context, title: 'Delete account'),

      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: EdgeInsetsGeometry.all(scaleFactor * 16),
            child: Column(
              spacing: height * 0.01,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Are you sure?',
                  color: AppColors.primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                CustomText(
                  text:
                      'Would you like to delete your Consultz account? This action cannot be undone. ',
                  color: AppColors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(),
                CustomFormField(
                  title: 'Type “deletemyaccount” to confirm',
                  hintText: 'Type the phrase above to confirm',
                  controller: deleteAccountController.confirmationController,
                ),
                SizedBox(height: height * 0.02),
                PrimaryButton(
                  onPressed: () {
                    deleteAccountController.deleteAccount(context);
                  },
                  title: 'Delete account',
                ),
                SizedBox(height: height * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
