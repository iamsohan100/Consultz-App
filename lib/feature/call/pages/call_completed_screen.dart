// import 'package:consultz/core/constants/app_colors.dart';
// import 'package:consultz/core/constants/app_images.dart';
// import 'package:consultz/core/utils/responsive/screen.dart';
// import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
// import 'package:consultz/core/utils/text/custom_text.dart';
// import 'package:consultz/feature/call/widgets/call_completed_continue_button.dart';
// import 'package:flutter/material.dart';

// class CallCompletedScreen extends StatelessWidget {
//   const CallCompletedScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     double height = Screen.screenHeight(context);
//     double width = Screen.screenWidth(context);
//     double scaleFactor = width / Screen.designWidth;
//     return Scaffold(
//       appBar: customAppBar(
//         context: context,
//         title: 'Call completed',
//         isLeading: false,
//       ),
//       bottomNavigationBar: CallCompletedContinueButton(),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsetsGeometry.all(scaleFactor * 14),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Image.asset(AppImages.callCompleted, width: width),

//                 CustomText(
//                   text: 'You’re getting paid!',
//                   color: AppColors.black,
//                   fontSize: 24,
//                   fontWeight: FontWeight.w700,
//                 ),
//                 SizedBox(height: height * 0.01),
//                 CustomText(
//                   text:
//                       'Congratulations on completing your first call. Payment will be transferred soon. Share your experience with all your other followers.',
//                   color: AppColors.black,
//                   fontSize: 14,
//                   fontWeight: FontWeight.w400,
//                 ),
//                 SizedBox(height: height * 0.01),
//                 CustomText(
//                   text: 'See Billing Details',
//                   color: AppColors.darkGrey,
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
