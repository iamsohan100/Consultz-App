import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/share_preference/auth_preference.dart';
import 'package:consultz/feature/Auth/widgets/forgot_password_button.dart';
import 'package:consultz/feature/Auth/widgets/google_apple_login.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/feature/Auth/controller/browse_first_controller.dart';
import 'package:consultz/feature/main/controller/main_controller.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/form_field/custom_form_field.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final loginController = Get.find<LoginController>();
  final mainController = Get.find<MainController>();
  final browseFirstController = Get.find<BrowseFirstController>();
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    return Scaffold(
      appBar: customAppBar(context: context),
      // resizeToAvoidBottomInset: false,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: Padding(
      //   padding: EdgeInsets.all(scaleFactor * 20),
      //   child:
      // ),
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
                spacing: height * 0.015,
                children: [
                  CustomText(
                    text: 'Login or sign up',
                    color: AppColors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                  CustomText(
                    text:
                        'Unlock your earning potential by sharing your expertise. Sign up now to start helping and earning today!',
                    color: AppColors.darkGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.4,
                  ),
                  SizedBox(),
                  CustomFormField(
                    controller: loginController.mailController,
                    title: 'Email address',
                    hintText: 'Your email address',
                    isMail: true,
                  ),
                  CustomFormField(
                    controller: loginController.passwordController,
                    title: 'Password',
                    hintText: 'Your password',
                    isPassword: true,
                  ),

                  ForgotPasswordButton(),

                  SizedBox(),
                  PrimaryButton(title: 'Let’s go!', onPressed: _login),
                  SizedBox(),

                  Row(
                    spacing: width * 0.03,
                    children: [
                      Expanded(child: Divider(color: AppColors.midGrey)),
                      CustomText(
                        text: 'or email',
                        color: AppColors.darkGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      Expanded(child: Divider(color: AppColors.midGrey)),
                    ],
                  ),
                  SizedBox(),
                  GoogleAppleLogin(
                    onSocialLoginSuccess: _handleLoginSuccess,
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

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final response = await loginController.login(context);
      if (response) {
        _handleLoginSuccess();
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

    browseFirstController.isConsultee.value = user?.role == 'expert' ? false : true;
    Get.offAllNamed(RoutesConstant.mainScreen, arguments: true);
    if (!browseFirstController.isConsultee.value) {
      mainController.changeIndex(index: 4);
    }
  }
}
