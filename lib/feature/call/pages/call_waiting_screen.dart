// import 'dart:async';

// import 'package:consultz/route/route_constant.dart';
// import 'package:consultz/core/constants/app_colors.dart';
// import 'package:consultz/core/utils/responsive/screen.dart';
// import 'package:consultz/core/utils/text/custom_text.dart';
// import 'package:consultz/feature/call/widgets/call_duration.dart';
// import 'package:consultz/feature/call/widgets/call_feature_button.dart';
// import 'package:consultz/feature/call/widgets/my_camera.dart';
// import 'package:consultz/feature/call/widgets/waiting_dots.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class CallWaitingScreen extends StatefulWidget {
//   const CallWaitingScreen({super.key});

//   @override
//   State<CallWaitingScreen> createState() => _CallWaitingScreenState();
// }

// class _CallWaitingScreenState extends State<CallWaitingScreen> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       Timer(Duration(seconds: 1), () {
//         Get.offNamed(RoutesConstant.receiveCallScreen);
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     double height = Screen.screenHeight(context);
//     double width = Screen.screenWidth(context);
//     // double scaleFactor = width / Screen.designWidth;
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(color: AppColors.black, width: width, height: height),
//           SafeArea(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 CallDuration(),
//                 MyCamera(),
//                 SizedBox(height: height * 0.16),
//                 CustomText(
//                   text: 'Waiting for Sam to join the call',
//                   color: AppColors.white,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w400,
//                 ),
//                 SizedBox(height: height * 0.015),

//                 WaitingDots(),
//                 Spacer(),
//                 CallFeatureButton(onTap: () {}),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
