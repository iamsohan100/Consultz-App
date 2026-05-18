// import 'package:consultz/core/utils/responsive/screen.dart';
// import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
// import 'package:consultz/core/utils/form_field/custom_form_field.dart';
// import 'package:consultz/feature/profile/controller/add_payment_method_controller.dart';
// import 'package:consultz/feature/profile/widgets/add_payment_terms_policy.dart';
// import 'package:consultz/feature/profile/widgets/confirm_card_button.dart';
// import 'package:consultz/feature/profile/widgets/save_as_default_checkbox.dart';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class AddPaymentMethodScreen extends StatefulWidget {
//   const AddPaymentMethodScreen({super.key});

//   @override
//   State<AddPaymentMethodScreen> createState() => _AddPaymentMethodScreenState();
// }

// class _AddPaymentMethodScreenState extends State<AddPaymentMethodScreen> {
//   final addPaymentMethodController = Get.find<AddPaymentMethodController>();
//   final formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     double height = Screen.screenHeight(context);
//     double width = Screen.screenWidth(context);
//     double scaleFactor = width / Screen.designWidth;
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: customAppBar(context: context, title: 'Add Payment Method'),
//       bottomNavigationBar: ConfirmCardButton(
//         onTap: () async {
//           if (formKey.currentState!.validate()) {
//             final response = await addPaymentMethodController.addCard(context);
//             if (response) {
//               Navigator.pop(context);
//             }
//           }
//         },
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsetsGeometry.all(scaleFactor * 14),
//             child: Form(
//               key: formKey,
//               child: Column(
//                 spacing: height * 0.01,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CustomFormField(
//                     controller: addPaymentMethodController.holderNameController,
//                     title: 'Name',
//                     hintText: 'Enter card holder name',
//                     isRequired: true,
//                     isTitleError: true,
//                   ),
//                   SizedBox(),

//                   CustomFormField(
//                     controller: addPaymentMethodController.cardNumberController,
//                     title: 'Debit/Credit card number',
//                     hintText: 'Enter card number',
//                     isRequired: true,
//                     isTitleError: true,
//                   ),
//                   SizedBox(),
//                   Row(
//                     spacing: width * 0.05,
//                     children: [
//                       Expanded(
//                         child: CustomFormField(
//                           controller:
//                               addPaymentMethodController.expiryDateController,
//                           title: 'Expiry date',
//                           hintText: 'MM/YY',
//                           isRequired: true,
//                           isTitleError: true,
//                         ),
//                       ),

//                       Expanded(
//                         child: CustomFormField(
//                           controller: addPaymentMethodController.cvcController,
//                           title: 'CVC',
//                           hintText: 'CVC',
//                           isRequired: true,
//                           isTitleError: true,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: height * 0.02),

//                   SaveAsDefaultCheckbox(
//                     text: 'Save card as default',
//                     isSelected: addPaymentMethodController.saveAsDefault,
//                   ),
//                   SizedBox(),
//                   AddPaymentTermsPolicy(
//                     isSelected: addPaymentMethodController.termsAccepted,
//                     text1:
//                         'By ticking, you are confirming that you have read, understood and agree to Consultz',
//                     text2: 'T&Cs.',
//                   ),
//                   SizedBox(height: MediaQuery.of(context).viewInsets.bottom),

//                   SizedBox(height: height * 0.1),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
