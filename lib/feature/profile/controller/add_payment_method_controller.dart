import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/loading.dart/main_loading.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/feature/profile/model/add_card_response_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPaymentMethodController extends GetxController {
  final holderNameController = TextEditingController();
  final cardNumberController = TextEditingController();
  final expiryDateController = TextEditingController();
  final cvcController = TextEditingController();

  final RxBool saveAsDefault = false.obs;
  final RxBool termsAccepted = false.obs;
  Rx<AddCardResponseModel> addCardResponseModel = AddCardResponseModel().obs;

  Future<bool> addCard(BuildContext context) async {
    if (!termsAccepted.value) {
      bottomMessage(msg: "Please accept the Terms & Conditions to proceed.");
      return false;
    }

    bool isSuccess = true;
    try {
      mainLoading(context, loadingText: 'Adding...');

      final response = await ApiCaller.postRequest(
        url: ApiUrls.addCard,
        body: {
          "holderName": holderNameController.text.trim(),
          "cardNumber": cardNumberController.text.replaceAll(' ', ''),
          "expiryDate": expiryDateController.text.trim(),
          "cvc": cvcController.text.trim(),
          "setAsDefault": saveAsDefault.value,
        },
      );

      Navigator.pop(context); // Close loading

      if (response?.statusCode == 200 && response?.isSuccess == true) {
        addCardResponseModel.value = AddCardResponseModel.fromJson(
          response?.responseData,
        );
      } else {
        bottomMessage(msg: response?.message);
        isSuccess = false;
      }
    } catch (e) {
      bottomMessage(msg: e.toString());
      isSuccess = false;
    }

    return isSuccess;
  }

  @override
  void onClose() {
    holderNameController.dispose();
    cardNumberController.dispose();
    expiryDateController.dispose();
    cvcController.dispose();
    super.onClose();
  }
}
