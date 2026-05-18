import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/feature/Auth/controller/sign_up_controller.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/form_field/custom_form_field.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/widgets/terms_and_condition.dart';
import 'package:consultz/feature/Auth/widgets/google_apple_login.dart';
import 'package:consultz/core/utils/share_preference/auth_preference.dart';
import 'package:consultz/feature/Auth/controller/browse_first_controller.dart';
import 'package:consultz/feature/main/controller/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final signUpController = Get.find<SignUpController>();
  final _formKey = GlobalKey<FormState>();
  final mainController = Get.find<MainController>();
  final browseFirstController = Get.find<BrowseFirstController>();

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    return Scaffold(
      appBar: customAppBar(
        onTap: () => Get.offAllNamed(RoutesConstant.browseFirstScreen),
        title: '',
        context: context,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.only(
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
                    text: 'Sign up',
                    color: AppColors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),

                  CustomFormField(
                    controller: signUpController.firstNameController,
                    title: 'First name',
                    hintText: 'First name',
                  ),
                  CustomFormField(
                    controller: signUpController.lastNameController,
                    title: 'Last name',
                    hintText: 'Last name',
                  ),
                  CustomFormField(
                    controller: signUpController.dateOfBirthController,
                    readOnly: true,
                    title: 'Date of birth',
                    hintText: 'Select date',
                    suffixIcon: Image.asset(AppImages.bookCall, scale: 4.5),
                    onTap: () async {
                      DateTime currentDate = DateTime.now();
                      DateTime maxAllowedDate = DateTime(
                        currentDate.year - 120,
                        currentDate.month,
                        currentDate.day,
                      );
                      DateTime? dateTime = await showDatePicker(
                        context: context,
                        initialDate: currentDate,
                        firstDate: maxAllowedDate,
                        lastDate: currentDate,
                      );
                      String date = dateTime != null
                          ? DateFormat('MM/dd/yyyy').format(dateTime)
                          : '';
                      signUpController.dateOfBirthController.text = date;
                    },
                  ),
                  CustomFormField(
                    controller: signUpController.confirmEmailController,
                    title: 'Confirm email',
                    hintText: 'sam@gmail.com',
                    isMail: true,
                  ),
                  CustomFormField(
                    controller: signUpController.referralController,
                    title:
                        'Referral code ${!browseFirstController.isConsultee.value ? '' : '(optional)'}',
                    hintText: 'Enter referral code',
                    isValidator: !browseFirstController.isConsultee.value
                        ? true
                        : false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'A referral code is required for experts.';
                      }
                      return null;
                    },
                  ),
                  CustomText(
                    text:
                        'Sign up With a referral code and you and your referrer will each earn 500 Consultz Points.',
                    color: AppColors.darkGrey,
                    fontSize: 11,
                    fontWeight: .w400,
                  ),
                  SizedBox(),
                  TermsAndCondition(),
                  SizedBox(height: height * 0.01),
                  PrimaryButton(
                    onPressed: () {
                      _signUp();
                    },
                    title: 'Continue',
                  ),

                  Row(
                    spacing: width * 0.03,
                    children: [
                      Expanded(child: Divider(color: AppColors.midGrey)),
                      CustomText(
                        text: 'or continue with',
                        color: AppColors.darkGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      Expanded(child: Divider(color: AppColors.midGrey)),
                    ],
                  ),
                  SizedBox(),
                  GoogleAppleLogin(onSocialLoginSuccess: _handleLoginSuccess),

                  SizedBox(height: height * 0.1),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      if (signUpController.termsAndConditionCheckBox.value == true) {
        Get.toNamed(RoutesConstant.passwordScreen);
      } else {
        bottomMessage(msg: "Please select terms and policy");
      }
    }
  }

  void _handleLoginSuccess() {
    final user = AuthPreference.logInInfo?.data?.user;

    // expert এর জন্য প্রোফাইল সেটআপ চেক করা হবে
    if (user?.role == 'expert') {
      final isProfileSetup = user?.isProfileSetup;
      if (isProfileSetup == null || isProfileSetup == false) {
        Get.offAllNamed(RoutesConstant.socialProfileScreen);
        return;
      }
    }

    // consult এর জন্য প্রোফাইল সেটআপ চেক করা হবে
    if (user?.role == 'consult') {
      final isProfileSetup = user?.isProfileSetup;
      if (isProfileSetup == null || isProfileSetup == false) {
        Get.offAllNamed(RoutesConstant.timeZoneScreen);
        return;
      }
    }

    browseFirstController.isConsultee.value = user?.role == 'expert'
        ? false
        : true;
    Get.offAllNamed(RoutesConstant.mainScreen, arguments: true);
    if (!browseFirstController.isConsultee.value) {
      mainController.changeIndex(index: 4);
    }
  }
}
