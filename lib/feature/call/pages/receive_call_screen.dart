// import 'package:consultz/feature/Auth/controller/browse_first_controller.dart';
// import 'package:consultz/feature/call/widgets/user_rating_dialog.dart';
// import 'package:consultz/route/route_constant.dart';
// import 'package:consultz/core/constants/app_images.dart';
// import 'package:consultz/core/utils/responsive/screen.dart';
// import 'package:consultz/feature/call/widgets/call_duration.dart';
// import 'package:consultz/feature/call/widgets/call_feature_button.dart';
// import 'package:consultz/feature/call/widgets/my_camera.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ReceiveCallScreen extends StatelessWidget {
//   const ReceiveCallScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     double height = Screen.screenHeight(context);
//     double width = Screen.screenWidth(context);
//     // double scaleFactor = width / Screen.designWidth;
//     final browseFirstController = Get.find<BrowseFirstController>();
//     return Scaffold(
//       body: Stack(
//         children: [
//           Image.asset(
//             AppImages.videoPerson,
//             width: width,
//             height: height,
//             fit: BoxFit.cover,
//           ),
//           SafeArea(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 CallDuration(),
//                 MyCamera(),

//                 Spacer(),
//                 CallFeatureButton(
//                   onTap: () {
//                     if (browseFirstController.isConsultee.value) {
//                       Navigator.pop(context);
//                       userRatingDialog(context: context);
//                     } else {
//                       Get.offNamed(RoutesConstant.callCompletedScreen);
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
