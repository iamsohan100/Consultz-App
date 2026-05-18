import 'package:consultz/feature/Auth/controller/set_expert_bio_controller.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/form_field/custom_form_field.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/widgets/profile_completation_progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateBioScreen extends StatefulWidget {
  const UpdateBioScreen({super.key});

  @override
  State<UpdateBioScreen> createState() => _UpdateBioScreenState();
}

class _UpdateBioScreenState extends State<UpdateBioScreen> {
  final setExpertBioController = Get.find<SetExpertBioController>();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: height * 0.016,
                children: [
                  ProfileCompletationProgress(),
                  SizedBox(),

                  CustomText(
                    text: "Update bio",
                    color: AppColors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                  CustomText(
                    text:
                        'Highlight your credentials, achievements, and how you can help. We recommend you keep it between 200-500 characters.',
                    color: AppColors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    lineHeight: 1.6,
                  ),
                  SizedBox(),
                  CustomFormField(
                    controller: setExpertBioController.headlineController,

                    hintText: 'Headline..',
                    title: 'Headline',
                    minLine: 1,
                    maxLine: 2,

                    padding: scaleFactor * 10,
                    horPadding: scaleFactor * 9,
                  ),
                  SizedBox(),

                  CustomFormField(
                    controller: setExpertBioController.bioController,

                    hintText: 'Write here..',
                    title: 'Bio',
                    minLine: 6,
                    maxLine: 6,

                    padding: scaleFactor * 10,
                    horPadding: scaleFactor * 9,
                  ),
                  SizedBox(height: height * 0.02),
                  PrimaryButton(
                    onPressed: continu,
                    title: 'Continue to time zone',
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

  Future<void> continu() async {
    if (_formKey.currentState!.validate()) {
      final response = await setExpertBioController.updateBio(context);
      if (response) {
        Get.toNamed(RoutesConstant.expertTimeZoneScreen);
      }
    }
  }
}
