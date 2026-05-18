import 'dart:io';

import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/loading.dart/main_loading.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/core/utils/helper/time_helper.dart';
import 'package:consultz/core/utils/message/top_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  final inProgress = false.obs;
  final clientSecretId = "".obs;
  final paymentIntentId = "".obs;
  final customerId = "".obs;
  final ephemeralKey = "".obs;
  final confirmedBooking = Rxn<Map<String, dynamic>>();
  final confirmedPayment = Rxn<Map<String, dynamic>>();

  Future<bool> makePayment({
    required String amount,
    required String currency,
  }) async {
    try {
      // iOS: Stripe API blocks legacy ephemeral key access (403 more_permissions_required)
      // Android: Legacy ephemeral key still works fine
      final isIOS = Platform.isIOS;

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          customFlow: false,
          merchantDisplayName: 'Consultz',
          paymentIntentClientSecret: clientSecretId.value,
          customerEphemeralKeySecret: isIOS ? null : ephemeralKey.value,
          customerId: isIOS ? null : customerId.value,
        ),
      );
      return await displayPaymentSheet();
    } catch (e) {
      bottomMessage(msg: e.toString());
      return false;
    }
  }

  Future<bool> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      topMessage(title: 'Success', msg: 'Payment Successful');

      return true;
    } on Exception catch (e) {
      if (e is StripeException) {
        bottomMessage(msg: e.error.localizedMessage);
      } else {
        bottomMessage(msg: e.toString());
      }
      return false;
    } catch (e) {
      bottomMessage(msg: e.toString());
      return false;
    }
  }

  Future<bool> checkout({
    required BuildContext context,
    required String account,
    required String booking,
  }) async {
    bool isSuccess = true;

    try {
      mainLoading(context, loadingText: 'Confirming...');

      final response = await ApiCaller.postRequest(
        url: ApiUrls.checkout,
        body: {"account": account, "booking": booking},
      );
      Navigator.pop(context);
      if (response?.statusCode == 200 && response?.isSuccess == true) {
        final data = response?.responseData['data'];
        if (data != null && data['clientSecret'] != null) {
          clientSecretId.value = data['clientSecret'] ?? "";
          paymentIntentId.value = data['paymentIntentId'] ?? "";
          ephemeralKey.value = data['ephemeralKey'] ?? "";
          customerId.value = data['customer'] ?? "";
        }
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

  Future<bool> confirmPayment({
    required BuildContext context,
    required String paymentIntentId,
    required String booking,
    required String user,
  }) async {
    bool isSuccess = true;
    try {
      mainLoading(context, loadingText: 'Confirming Payment...');

      final response = await ApiCaller.postRequest(
        url: ApiUrls.confirmPayment,
        body: {
          "paymentIntentId": paymentIntentId,
          "booking": booking,
          "user": user,
        },
      );
      Navigator.pop(context);
      if (response?.statusCode == 200 && response?.isSuccess == true) {
        final data = response?.responseData['data'];
        if (data != null) {
          final bookingMap = data['booking'] as Map<String, dynamic>?;
          if (bookingMap != null && bookingMap['slot'] != null) {
            final slot = bookingMap['slot'] as Map<String, dynamic>;
            if (slot['time'] != null) {
              slot['time'] = TimeHelper.utcToLocalTime(slot['time']);
            }
          }
          confirmedBooking.value = bookingMap;
          confirmedPayment.value = data['payment'];
        }
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
}
