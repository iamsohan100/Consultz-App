import 'dart:developer';
import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/loading.dart/main_loading.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/core/utils/message/top_message.dart';
import 'package:consultz/feature/bookings/controller/expert_booking_controller.dart';
import 'package:consultz/feature/bookings/model/booking_details_model.dart';
import 'package:consultz/core/utils/helper/time_helper.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingDetailsController extends GetxController {
  final bookingDetails = Rxn<BookingDetailsData>();
  final reasonController = TextEditingController();

  @override
  void onClose() {
    reasonController.dispose();
    super.onClose();
  }

  Future<void> getBookingDetails(
    BuildContext context, {
    required String bookingId,
  }) async {
    try {
      mainLoading(context, loadingText: 'Details...');
      final response = await ApiCaller.getRequest(
        url: ApiUrls.getBookingDetails(bookingId),
      );

      log("Booking details response: ${response?.responseData}");

      if (response?.statusCode == 200 && response?.isSuccess == true) {
        final model = BookingDetailsModel.fromJson(response?.responseData);
        
        // Convert UTC to local
        if (model.data?.slot?.time != null) {
          model.data!.slot!.time = TimeHelper.utcToLocalTime(model.data!.slot!.time!);
        }

        bookingDetails.value = model.data;

        // Pop the loading dialog
        Get.back();

        // Navigate to details page
        Get.toNamed(RoutesConstant.bookingDetailsScreen);
      } else {
        Get.back();
        bottomMessage(msg: response?.message ?? "Failed to fetch details");
      }
    } catch (e) {
      if (Navigator.canPop(context)) {
        Get.back();
      }
      bottomMessage(msg: e.toString());
      log("Error fetching booking details: $e");
    }
  }

  Future<void> confirmBooking(
    BuildContext context, {
    required String bookingId,
  }) async {
    try {
      mainLoading(context, loadingText: 'Confirming...');
      final response = await ApiCaller.patchRequest(
        url: ApiUrls.confirmBooking(bookingId),
        body: {},
      );

      log("Confirm booking response: ${response?.responseData}");

      if (response?.statusCode == 200 && response?.isSuccess == true) {
        // Update local state
        if (bookingDetails.value != null) {
          bookingDetails.value!.status = 'confirmed';
          bookingDetails.refresh();
        }

        // Refresh main bookings list
        try {
          final expertBookingController = Get.find<ExpertBookingController>();
          expertBookingController.fetchBookings();
        } catch (e) {
          log("ExpertBookingController not found: $e");
        }

        Get.back();
        topMessage(
          title: 'Success',
          msg: response?.message ?? "Booking confirmed successfully",
        );
      } else {
        Get.back();
        bottomMessage(msg: response?.message ?? "Failed to confirm booking");
      }
    } catch (e) {
      if (Navigator.canPop(context)) {
        Get.back();
      }
      bottomMessage(msg: e.toString());
      log("Error confirming booking: $e");
    }
  }

  Future<void> cancelBooking(
    BuildContext context, {
    required String bookingId,
  }) async {
    try {
      mainLoading(context, loadingText: 'Canceling...');
      final response = await ApiCaller.patchRequest(
        url: ApiUrls.cancelBooking(bookingId),
        body: {},
      );

      log("Cancel booking response: ${response?.responseData}");

      if (response?.statusCode == 200 && response?.isSuccess == true) {
        // Update local state
        if (bookingDetails.value != null) {
          bookingDetails.value!.status = 'canceled';
          bookingDetails.refresh();
        }

        // Refresh main bookings list
        try {
          final expertBookingController = Get.find<ExpertBookingController>();
          expertBookingController.fetchBookings();
        } catch (e) {
          log("ExpertBookingController not found: $e");
        }

        Get.back(); // Pop loading
        Get.back(); // Pop cancellation dialog
        topMessage(
          title: 'Success',
          msg: response?.message ?? "Booking canceled successfully",
        );
      } else {
        Get.back();
        bottomMessage(msg: response?.message ?? "Failed to cancel booking");
      }
    } catch (e) {
      if (Navigator.canPop(context)) {
        Get.back();
      }
      bottomMessage(msg: e.toString());
      log("Error canceling booking: $e");
    }
  }

  Future<void> declineBooking(
    BuildContext context, {
    required String bookingId,
  }) async {
    try {
      mainLoading(context, loadingText: 'Declining...');
      final response = await ApiCaller.patchRequest(
        url: ApiUrls.declineBooking(bookingId),
        body: {"reason": reasonController.text},
      );

      log("Decline booking response: ${response?.responseData}");

      if (response?.statusCode == 200 && response?.isSuccess == true) {
        // Update local state
        if (bookingDetails.value != null) {
          bookingDetails.value!.status = 'declined';
          bookingDetails.refresh();
        }

        // Refresh main bookings list
        try {
          final expertBookingController = Get.find<ExpertBookingController>();
          expertBookingController.fetchBookings();
        } catch (e) {
          log("ExpertBookingController not found: $e");
        }

        reasonController.clear();
        Get.back(); // Pop loading
        Get.back(); // Pop decline dialog
        topMessage(
          title: 'Success',
          msg: response?.message ?? "Booking declined successfully",
        );
      } else {
        Get.back();
        bottomMessage(msg: response?.message ?? "Failed to decline booking");
      }
    } catch (e) {
      if (Navigator.canPop(context)) {
        Get.back();
      }
      bottomMessage(msg: e.toString());
      log("Error declining booking: $e");
    }
  }
}
