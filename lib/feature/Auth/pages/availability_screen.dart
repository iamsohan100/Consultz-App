// import 'package:consultz/core/constants/app_colors.dart';
// import 'package:consultz/core/constants/app_images.dart';
// import 'package:consultz/feature/Auth/model/interest_page_data.dart';
// import 'package:consultz/core/utils/responsive/screen.dart';
// import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
// import 'package:consultz/core/utils/text/custom_text.dart';
// import 'package:consultz/feature/Auth/widgets/available_confirm.dart';
// import 'package:consultz/feature/Auth/widgets/available_time_container.dart';
// import 'package:consultz/feature/Auth/widgets/skip_interests.dart';
// import 'package:flutter/material.dart';

// class AvailabilityScreen extends StatelessWidget {
//   const AvailabilityScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     double height = Screen.screenHeight(context);
//     double width = Screen.screenWidth(context);
//     double scaleFactor = width / Screen.designWidth;
//     return Scaffold(
//       appBar: customAppBar(
//         context: context,
//         actions: [
//           SkipInterests(),
//           SizedBox(width: width * 0.06),
//         ],
//       ),
//       bottomNavigationBar: AvailableConfirm(),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsetsGeometry.only(
//               // top: scaleFactor * 8,
//               left: scaleFactor * 20,
//               right: scaleFactor * 20,
//               bottom: scaleFactor * 20,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               spacing: height * 0.01,
//               children: [
//                 Align(
//                   alignment: Alignment.center,
//                   child: Image.asset(
//                     AppImages.availability,
//                     width: scaleFactor * 240,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//                 SizedBox(),
//                 CustomText(
//                   text: 'When are you available for sessions?',
//                   color: AppColors.black,
//                   fontSize: 24,
//                   fontWeight: FontWeight.w700,
//                   lineHeight: 1.4,
//                 ),
//                 CustomText(
//                   text:
//                       'Get matched to the right experts by choosing the a timeframe that would suit your schedule.',
//                   color: AppColors.black,
//                   fontSize: 14,
//                   fontWeight: FontWeight.w400,
//                   lineHeight: 1.6,
//                 ),
//                 SizedBox(height: height * 0.02),

//                 ListView.separated(
//                   primary: false,
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   itemCount: InterestPageData.availabilityData.length,
//                   itemBuilder: (_, index) {
//                     return AvailableTimeContainer(
//                       dayName: InterestPageData.availabilityData[index],
//                     );
//                   },
//                   separatorBuilder: (_,_) {
//                     return SizedBox(height: height * 0.012);
//                   },
//                 ),
//                 SizedBox(height: height * 0.05),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
