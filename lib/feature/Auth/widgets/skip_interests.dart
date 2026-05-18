// import 'package:consultz/route/route_constant.dart';
// import 'package:consultz/core/constants/app_colors.dart';
// import 'package:consultz/core/utils/message/bottom_message.dart';
// import 'package:consultz/core/utils/share_preference/auth_preference.dart';
// import 'package:consultz/core/utils/text/custom_text.dart';
// import 'package:consultz/feature/Auth/controller/browse_first_controller.dart';
// import 'package:consultz/feature/Auth/controller/login_controller.dart';
// import 'package:consultz/feature/Auth/controller/sign_up_controller.dart';
// import 'package:consultz/feature/main/controller/main_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class SkipInterests extends StatelessWidget {
//   const SkipInterests({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () async {
//         bool hasSignupInfo = false;
//         String email = '';
//         String password = '';

//         if (Get.isRegistered<SignUpController>()) {
//           final signUpController = Get.find<SignUpController>();
//           email = signUpController.confirmEmailController.text.trim();
//           password = signUpController.passwordController.text;
//           if (email.isNotEmpty) {
//             hasSignupInfo = true;
//           }
//         }

//         if (hasSignupInfo) {
//           // ── Signup flow: SignUpController-এ email আছে → login করো ──
//           final loginController = Get.isRegistered<LoginController>()
//               ? Get.find<LoginController>()
//               : Get.put(LoginController());
//           loginController.mailController.text = email;
//           loginController.passwordController.text = password;

//           final loginSuccess = await loginController.login(context);
//           if (loginSuccess) {
//             Get.offNamed(RoutesConstant.loadingScreen);
//           } else {
//             bottomMessage(msg: 'Login failed. Please try again.');
//           }
//         } else {
//           // ── Login flow: token আছে → সরাসরি mainScreen-এ নাও ──
//           final browseFirstController = Get.find<BrowseFirstController>();
//           browseFirstController.isConsultee.value =
//               AuthPreference.logInInfo?.data?.user?.role == 'expert'
//                   ? false
//                   : true;
//           Get.offAllNamed(RoutesConstant.mainScreen, arguments: true);
//           if (!browseFirstController.isConsultee.value) {
//             Get.find<MainController>().changeIndex(index: 4);
//           }
//         }
//       },
//       child: CustomText(
//         text: 'Skip',
//         color: AppColors.darkGrey,
//         fontSize: 14,
//         fontWeight: FontWeight.w400,
//       ),
//     );
//   }
// }
