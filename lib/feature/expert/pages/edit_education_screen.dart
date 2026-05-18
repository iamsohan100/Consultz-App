import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/message/top_message.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/form_field/custom_form_field.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:consultz/feature/expert/controller/expert_education_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditEducationScreen extends StatefulWidget {
  const EditEducationScreen({super.key});

  @override
  State<EditEducationScreen> createState() => _EditEducationScreenState();
}

class _EditEducationScreenState extends State<EditEducationScreen> {
  final profileController = Get.find<ProfileController>();
  final educationController = Get.find<ExpertEducationController>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final education =
          profileController.expertProfileModel.value.data?.education;

      educationController.degreeController.text = education?.degree ?? '';
      educationController.certificationController.text =
          (education?.certificate == null || education!.certificate!.isEmpty)
          ? ''
          : education.certificate?.first ?? '';
      educationController.phdController.text = education?.phd ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    return Scaffold(
      appBar: customAppBar(context: context, title: 'Education'),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.all(scaleFactor * 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: height * 0.02,
              children: [
                CustomText(
                  text:
                      'Highlight your education and completed courses to build trust and credibility. Sharing your qualifications helps consultees feel confident in choosing you as their expert.',
                  color: AppColors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(),
                CustomFormField(
                  controller: educationController.degreeController,
                  title: 'Degree',
                  hintText: 'Enter your degree',
                ),
                CustomFormField(
                  controller: educationController.certificationController,
                  title: 'Certification',
                  hintText: 'Enter your certification',
                ),
                CustomFormField(
                  controller: educationController.phdController,
                  title: 'Phd',
                  hintText: 'Enter your Phd',
                ),
                SizedBox(height: height * 0.02),
                PrimaryButton(onPressed: save, title: 'Save'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> save() async {
    bool isSuccess = await educationController.updateEducation(context);
    if (isSuccess && mounted) {
      topMessage(msg: 'Education updated successfully', title: 'Successful');
      Navigator.pop(context);
    }
  }
}
