// import 'package:consultz/feature/bookings/controller/booking_controller.dart';
// import 'package:consultz/route/route_constant.dart';
// import 'package:consultz/core/constants/app_colors.dart';
// import 'package:consultz/core/constants/app_images.dart';
// import 'package:consultz/core/utils/responsive/screen.dart';
// import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
// import 'package:consultz/core/utils/form_field/custom_form_field.dart';
// import 'package:consultz/core/utils/text/custom_rich_text.dart';
// import 'package:consultz/core/utils/text/custom_text.dart';
// import 'package:consultz/feature/Auth/widgets/mobile_verification_progress_container.dart';
// import 'package:consultz/feature/bookings/widgets/booking_steps.dart';
// import 'package:consultz/feature/bookings/widgets/confirm_date_time_button.dart';
// import 'package:consultz/feature/profile/widgets/add_payment_terms_policy.dart';
// import 'package:consultz/feature/profile/widgets/cards.dart';
// import 'package:consultz/feature/profile/widgets/debit_credit_card.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class BookingPaymentMethodScreen extends StatelessWidget {
//   BookingPaymentMethodScreen({super.key});

//   final bookingController = Get.find<BookingController>();

//   @override
//   Widget build(BuildContext context) {
//     double height = Screen.screenHeight(context);
//     double width = Screen.screenWidth(context);
//     double scaleFactor = width / Screen.designWidth;
//     return Scaffold(
//       appBar: customAppBar(title: '', context: context),
//       bottomNavigationBar: ConfirmDateTimeButton(
//         onTap: () {
//           Get.offAllNamed(RoutesConstant.thankYouScreen);
//         },
//         title: 'Confirm payment',
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsetsGeometry.only(
//               top: scaleFactor * 8,
//               left: scaleFactor * 20,
//               right: scaleFactor * 20,
//               bottom: scaleFactor * 20,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               // spacing: height * 0.016,
//               children: [
//                 BookingSteps(currentScreen: 4),
//                 SizedBox(height: height * 0.032),

//                 MobileVerificationProgressContainer(
//                   progress: 1,
//                   image: AppImages.priceRange,
//                   imageSize: 32,
//                   color: AppColors.black,
//                 ),
//                 SizedBox(height: height * 0.016),
//                 CustomText(
//                   text: 'Payment method',
//                   color: AppColors.black,
//                   fontSize: 24,
//                   fontWeight: FontWeight.w700,
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(height: height * 0.01),

//                 CustomText(
//                   text: 'Discussion with Kristy Campbell',
//                   color: AppColors.black,
//                   fontSize: 14,
//                   fontWeight: FontWeight.w400,
//                 ),
//                 SizedBox(height: height * 0.001),
//                 Obx(() => CustomRichText(
//                       text1:
//                           '${bookingController.selectedDateDisplay.value}・${bookingController.availableSlots.firstWhereOrNull((slot) => slot.sId == bookingController.slotId.value)?.time ?? ""}・',
//                       color1: AppColors.black,
//                       fontSize1: 14,
//                       fontWeight: FontWeight.w400,
//                       textAlign: TextAlign.center,
//                       text2: ' £${bookingController.price.value}.00',
//                       color2: AppColors.primaryColor,
//                       fontSize2: 14,
//                     )),
//                 SizedBox(height: height * 0.02),
//                 DebitCreditCard(),

//                 SizedBox(height: height * 0.02),
//                 Cards(),
//                 SizedBox(height: height * 0.02),
//                 CustomFormField(
//                   title: 'Name on card',
//                   hintText: 'Name on card',
//                   isRequired: true,
//                 ),
//                 SizedBox(height: height * 0.02),

//                 CustomFormField(
//                   title: 'Debit/Credit card number',
//                   hintText: 'Card number',
//                   isRequired: true,
//                 ),
//                 SizedBox(height: height * 0.02),
//                 Row(
//                   spacing: width * 0.05,
//                   children: [
//                     Expanded(
//                       child: CustomFormField(
//                         title: 'Expiry date*',
//                         hintText: 'MM/YY',
//                         isRequired: true,
//                       ),
//                     ),

//                     Expanded(
//                       child: CustomFormField(
//                         title: 'CVC*',
//                         hintText: 'CVC',
//                         isRequired: true,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: height * 0.03),
//                 AddPaymentTermsPolicy(
//                   text1: 'Save card details, for faster future checkout.',
//                   text2: '',
//                 ),

//                 AddPaymentTermsPolicy(
//                   text1:
//                       'By ticking, you are confirming that you have read, understood and agree to Consultz',
//                   text2: 'T&Cs.',
//                 ),
//                 SizedBox(height: height * 0.03),

//                 Container(
//                   width: width,
//                   padding: EdgeInsets.all(scaleFactor * 16),
//                   decoration: BoxDecoration(
//                     color: Color(0xFFF8F9FC),
//                     borderRadius: BorderRadius.circular(scaleFactor * 10),
//                   ),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Column(
//                             spacing: height * 0.001,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               CustomText(
//                                 text: 'Total to pay',
//                                 color: AppColors.black,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w700,
//                               ),
//                               CustomText(
//                                 text: 'VAT Included',
//                                 color: AppColors.darkGrey,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ],
//                           ),
//                           Obx(() => CustomText(
//                                 text: '£  ${bookingController.price.value}.00',
//                                 color: AppColors.black,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w700,
//                               )),
//                         ],
//                       ),
//                       SizedBox(height: height * 0.01),
//                       CustomText(
//                         text:
//                             'You have 0 day/s to Reschedule or Cancel this session to get a full refund. Any cancellations 24 hours before the call, you won’t be eligible for a refund. ',
//                         color: AppColors.darkGrey,
//                         fontSize: 10,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ],
//                   ),
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
