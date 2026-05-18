import 'package:consultz/feature/Auth/controller/set_bank_controller.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/widgets/filling_steps.dart';
import 'package:consultz/feature/Auth/widgets/mobile_verification_progress_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetBankScreen extends StatefulWidget {
  const SetBankScreen({super.key});

  @override
  State<SetBankScreen> createState() => _SetBankScreenState();
}

class _SetBankScreenState extends State<SetBankScreen> {
  final _formKey = GlobalKey<FormState>();
  final setBankController = Get.find<SetBankController>();
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
                  FillingSteps(currentScreen: 3),
                  SizedBox(),
                  MobileVerificationProgressContainer(
                    progress: 1,
                    image: AppImages.priceRange,
                    imageSize: 31,
                  ),
                  SizedBox(),
                  CustomText(
                    text: "Payment details",
                    color: AppColors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.center,
                  ),
                  CustomText(
                    text: "Add your stripe account details to get paid. ",
                    color: AppColors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center,
                    lineHeight: 1.6,
                  ),
                  SizedBox(),
                  CustomText(
                    text:
                        "We’ll always take payment from your clients in advance and hold it in an escrow account. Payment is released to you when the call is completed.",
                    color: AppColors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    lineHeight: 1.6,
                  ),
                  SizedBox(height: height * 0.01),
                  PrimaryButton(
                    onPressed: () async {
                      final url = await setBankController.connectStripe(context);
                      if (url != null && url.isNotEmpty) {
                        Get.toNamed(RoutesConstant.stripeWebviewScreen,
                            arguments: {'url': url, 'from': 'onboarding'});
                      }
                    },
                    title: 'Connect with Stripe',
                  ),
                  SizedBox(height: height * 0.04),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}
