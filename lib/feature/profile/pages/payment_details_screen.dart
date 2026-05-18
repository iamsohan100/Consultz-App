// import 'package:consultz/core/utils/loading.dart/circle_loading.dart';
// import 'package:consultz/core/utils/widgets/no_data.dart';
// import 'package:consultz/feature/expert/widgets/review_shimmer.dart';
// import 'package:consultz/feature/profile/controller/payment_details_controller.dart';
// import 'package:consultz/route/route_constant.dart';
// import 'package:consultz/core/constants/app_colors.dart';
// import 'package:consultz/core/utils/responsive/screen.dart';
// import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
// import 'package:consultz/core/utils/button/primary_button.dart';
// import 'package:consultz/core/utils/text/custom_text.dart';
// import 'package:consultz/feature/profile/widgets/payment_card.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class PaymentDetailsScreen extends StatefulWidget {
//   const PaymentDetailsScreen({super.key});

//   @override
//   State<PaymentDetailsScreen> createState() => _PaymentDetailsScreenState();
// }

// class _PaymentDetailsScreenState extends State<PaymentDetailsScreen> {
//   final controller = Get.find<PaymentDetailsController>();

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       controller.initialLoad();

//       controller.scrollController.addListener(() {
//         if (controller.scrollController.position.pixels >=
//                 controller.scrollController.position.maxScrollExtent - 200 &&
//             !controller.isLoadingMore.value &&
//             controller.hasMore.value) {
//           controller.loadMore();
//         }
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     double height = Screen.screenHeight(context);
//     double width = Screen.screenWidth(context);
//     double scaleFactor = width / Screen.designWidth;

//     return Scaffold(
//       appBar: customAppBar(context: context, title: 'Payment details'),
//       body: SafeArea(
//         child: Obx(() {
//           if (controller.inProgress.value) {
//             return Padding(
//               padding: .symmetric(
//                 horizontal: scaleFactor * 16,
//                 vertical: scaleFactor * 10,
//               ),
//               child: ReviewShimmer(length: 7),
//             );
//           }

//           final cards = controller.cardList;

//           return RefreshIndicator(
//             onRefresh: controller.initialLoad,
//             child: SingleChildScrollView(
//               controller: controller.scrollController,
//               physics: const AlwaysScrollableScrollPhysics(),
//               child: Padding(
//                 padding: EdgeInsetsGeometry.all(scaleFactor * 14),
//                 child: Column(
//                   spacing: height * 0.01,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CustomText(
//                       text: 'Saved card details',
//                       color: AppColors.black,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                     ),
//                     SizedBox(),
//                     if (cards.isEmpty)
//                       Center(child: NoData(text: 'No saved cards found'))
//                     else
//                       ListView.separated(
//                         primary: false,
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: cards.length,
//                         itemBuilder: (context, index) {
//                           return PaymentCard(cardModel: cards[index]);
//                         },
//                         separatorBuilder: (_, _) {
//                           return SizedBox(height: height * 0.02);
//                         },
//                       ),
//                     if (controller.isLoadingMore.value) ...[
//                       SizedBox(height: height * 0.015),
//                       CircleLoading(top: 0),
//                     ],
//                     SizedBox(),
//                     PrimaryButton(
//                       onPressed: () async {
//                         await Get.toNamed(
//                           RoutesConstant.addPaymentMethodScreen,
//                         );
//                         controller.initialLoad();
//                       },
//                       title: 'Add payment method',
//                       backgroundColor: AppColors.white,
//                       borderColor: AppColors.primaryColor,
//                       textColor: AppColors.primaryColor,
//                       buttonHeight: height * 0.045,
//                       radius: 8,
//                     ),
//                     SizedBox(height: height * 0.1),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }
