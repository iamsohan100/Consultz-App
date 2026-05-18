import 'package:consultz/feature/Auth/controller/set_hourly_rate_controller.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/form_field/custom_form_field.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/widgets/filling_steps.dart';
import 'package:consultz/feature/Auth/widgets/mobile_verification_progress_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetRateScreen extends StatefulWidget {
  const SetRateScreen({super.key});

  @override
  State<SetRateScreen> createState() => _SetRateScreenState();
}

class _SetRateScreenState extends State<SetRateScreen> {
  final setHourlyRateController = Get.find<SetHourlyRateController>();
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
                  FillingSteps(currentScreen: 2),
                  SizedBox(),
                  MobileVerificationProgressContainer(
                    progress: 0.8,
                    image: AppImages.hourlyRate,
                    imageSize: 30,
                  ),
                  SizedBox(),
                  CustomText(
                    text: "Set your hourly\nrate",
                    color: AppColors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(),
                  CustomFormField(
                    controller: setHourlyRateController.hourlyRateController,

                    title: 'Hourly rate',
                    hintText: '£200 / hr',
                    isTitleError: true,
                    isNumber: true,
                  ),
                  SizedBox(),
                  CustomText(
                    text:
                        'Earn 95% of client payments, minus a 5% Consultz service fee.',
                    color: AppColors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    lineHeight: 1.6,
                  ),
                  SizedBox(height: height * 0.02),
                  PrimaryButton(
                    onPressed: () {
                      great();
                    },
                    title: 'Great',
                  ),
                  SizedBox(height: height * 0.016),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> great() async {
    if (_formKey.currentState!.validate()) {
      final response = await setHourlyRateController.updateHourlyRate(context);
      if (response) {
        Get.toNamed(RoutesConstant.setBankScreen);
      }
    }
  }
}
