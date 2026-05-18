// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/loading.dart/main_loading.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/feature/profile/model/booking_details_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingHistoryDetailsController extends GetxController {
  final bookingDetails = Rxn<BookingDetailsData>();

  Future<bool> getBookingDetails(
    BuildContext context, {
    required String bookingId,
  }) async {
    bool isSuccess = true;
    try {
      mainLoading(context, loadingText: '');
      final response = await ApiCaller.getRequest(
        url: ApiUrls.getBookingDetails(bookingId),
      );

      log("Booking details response: ${response?.responseData}");

      if (response?.statusCode == 200 && response?.isSuccess == true) {
        final model = BookingDetailsModel.fromJson(response?.responseData);
        bookingDetails.value = model.data;
      } else {
        bottomMessage(msg: response?.message);
        isSuccess = false;
      }
    } catch (e) {
      bottomMessage(msg: e.toString());
      isSuccess = false;
    } finally {
      Navigator.pop(context);
    }

    return isSuccess;
  }
}
