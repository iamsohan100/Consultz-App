import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/form_field/custom_form_field.dart';
import 'package:consultz/core/utils/message/top_message.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/profile/controller/support_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final _formKey = GlobalKey<FormState>();
  final supportController = Get.find<SupportController>();
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    return Scaffold(
      appBar: customAppBar(context: context, title: 'Support message'),

      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: EdgeInsets.all(scaleFactor * 16),
            child: Form(
              key: _formKey,
              child: Column(
                spacing: height * 0.01,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'How can we help?',
                    color: AppColors.primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  CustomText(
                    text:
                        'Please describe your concern, issue, or feedback below. Our support team will review it and get back to you as soon as possible.',
                    color: AppColors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  const SizedBox(),
                  CustomFormField(
                    controller: supportController.subjectController,
                    title: 'Subject',
                    hintText: 'Write your subject here',
                    isRequired: true,
                    isTitleError: true,
                  ),
                  const SizedBox(),
                  CustomFormField(
                    controller: supportController.messageController,
                    title: 'Tell us what’s on your mind',
                    hintText: 'Describe your issue or feedback...',
                    minLine: 3,
                    maxLine: 5,
                    padding: 10,
                    isRequired: true,
                    isTitleError: true,
                  ),
                  SizedBox(height: height * 0.02),
                  PrimaryButton(onPressed: _send, title: 'Send'),
                  SizedBox(height: height * 0.1),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _send() async {
    if (_formKey.currentState!.validate()) {
      final response = await supportController.sendSupportMessage(context);
      if (response && mounted) {
        topMessage(title: 'Success', msg: "Support message sent successfully");

        Navigator.pop(context);
      }
    }
  }
}
