import 'package:consultz/feature/profile/controller/update_phone_number_controller.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/form_field/phone_form_field.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditPhoneNumberScreen extends StatefulWidget {
  const EditPhoneNumberScreen({super.key});

  @override
  State<EditPhoneNumberScreen> createState() => _EditPhoneNumberScreenState();
}

class _EditPhoneNumberScreenState extends State<EditPhoneNumberScreen> {
  // final args = Get.arguments as EditProfileModel;
  final updatePhoneNumberController = Get.find<UpdatePhoneNumberController>();

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Phone',
        actions: [
          GestureDetector(
            onTap: () {
              updatePhoneNumberController.sendOtp(context);
            },
            child: CustomText(
              text: 'Verify',
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomText(
                  text:
                      'Your mobile number is never displayed or shared with anyone. We will send you a code to verify your number.',
                  color: AppColors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: height * 0.02),
                PhoneFormField(
                  controller: updatePhoneNumberController.phoneNumberController,
                  initCountryCode: updatePhoneNumberController.initCountryCode,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
