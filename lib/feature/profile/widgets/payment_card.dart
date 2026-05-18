import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/profile/model/my_cards_response_model.dart';
import 'package:consultz/feature/profile/widgets/delete_card_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:consultz/feature/profile/controller/payment_details_controller.dart';

class PaymentCard extends StatelessWidget {
  const PaymentCard({super.key, required this.cardModel});
  final CardDataModel cardModel;
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    // Determine card image based on card number (simplified logic)
    String cardImage = AppImages.visa;
    if (cardModel.cardNumber?.startsWith('5') ?? false) {
      cardImage = AppImages.masterCard;
    } else if (cardModel.cardNumber?.startsWith('3') ?? false) {
      cardImage = AppImages.americanExpress;
    }

    return Container(
      width: width,
      padding: EdgeInsets.all(scaleFactor * 14),
      decoration: BoxDecoration(
        color: Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(scaleFactor * 12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: height * 0.001,
              children: [
                CustomText(
                  text: cardModel.holderName ?? '',
                  color: AppColors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                CustomText(
                  text: 'Card: ${_formatCardNumber(cardModel.cardNumber)}',
                  color: AppColors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
                CustomText(
                  text: 'Exp: ${cardModel.expiryDate}',
                  color: AppColors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: height * 0.008),
                Row(
                  spacing: width * 0.015,
                  children: [
                    Icon(
                      cardModel.status == 'expired'
                          ? Icons.error_outline
                          : Icons.check_circle_outlined,
                      color: cardModel.status == 'expired'
                          ? AppColors.red
                          : AppColors.green,
                      size: scaleFactor * 17,
                    ),
                    CustomText(
                      text: cardModel.setAsDefault == true
                          ? 'Default payment method'
                          : (cardModel.status == 'expired'
                                ? 'This card has expired'
                                : 'Active'),
                      color: cardModel.status == 'expired'
                          ? AppColors.red
                          : AppColors.darkGrey,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                SizedBox(height: height * 0.01),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        final controller = Get.find<PaymentDetailsController>();
                        final lastFour = cardModel.cardNumber != null && cardModel.cardNumber!.length >= 4 
                            ? cardModel.cardNumber!.substring(cardModel.cardNumber!.length - 4)
                            : "****";
                        
                        deleteCardDialog(
                          context: context,
                          holderName: cardModel.holderName ?? '',
                          lastFour: lastFour,
                          expiry: cardModel.expiryDate ?? '',
                          onDelete: () {
                            controller.deleteCard(context, cardModel.sId ?? '');
                          },
                        );
                      },
                      child: CustomText(
                        text: 'Delete',
                        color: AppColors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        textDecoration: TextDecoration.underline,
                        textDecorationColor: AppColors.red,
                      ),
                    ),
                    SizedBox(width: width * 0.05),
                    if (cardModel.setAsDefault == false)
                      GestureDetector(
                        onTap: () {
                          final controller = Get.find<PaymentDetailsController>();
                          controller.setDefaultCard(context, cardModel.sId ?? '');
                        },
                        child: CustomText(
                          text: 'Set as default',
                          color: AppColors.darkNavyBlue,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          textDecoration: TextDecoration.underline,
                          textDecorationColor: AppColors.darkNavyBlue,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: height * 0.035,
            width: width * 0.11,
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.02,
              vertical: height * 0.01,
            ),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: AppColors.grey),
              borderRadius: BorderRadius.circular(scaleFactor * 4),
            ),
            child: Image.asset(
              cardImage,
              width: scaleFactor * 22,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  String _formatCardNumber(String? cardNumber) {
    if (cardNumber == null || cardNumber.isEmpty) return "";
    String digitsOnly = cardNumber.replaceAll(RegExp(r'\D'), '');

    if (digitsOnly.startsWith('34') || digitsOnly.startsWith('37')) {
      // AMEX: 4-6-5
      final buffer = StringBuffer();
      for (int i = 0; i < digitsOnly.length; i++) {
        if (i == 4 || i == 10) buffer.write(' ');
        buffer.write(digitsOnly[i]);
      }
      return buffer.toString();
    } else {
      // Standard: 4-4-4-4
      final buffer = StringBuffer();
      for (int i = 0; i < digitsOnly.length; i++) {
        if (i > 0 && i % 4 == 0) buffer.write(' ');
        buffer.write(digitsOnly[i]);
      }
      return buffer.toString();
    }
  }
}
