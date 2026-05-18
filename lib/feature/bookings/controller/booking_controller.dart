import 'dart:developer';

import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/loading.dart/main_loading.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/feature/bookings/model/booking_slots_model.dart';
import 'package:consultz/feature/bookings/model/create_booking_model.dart';
import 'package:consultz/core/utils/helper/time_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BookingController extends GetxController {
  final inProgress = false.obs;

  // Booking details
  final consultId = "".obs;
  final slotId = "".obs;
  final sessionType = "".obs;
  final sessionDuration = 0.obs;
  final price = 0.obs;
  final createdBookingData = Rxn<BookingData>();

  // Slots
  final bookingSlots = <BookingSlot>[].obs;
  final availableSlots = <BookingSlot>[].obs; // Slots for the selected date
  final morningSlots = <BookingSlot>[].obs;
  final afternoonSlots = <BookingSlot>[].obs;
  final eveningSlots = <BookingSlot>[].obs;

  final selectedYear = DateTime.now().year.obs;
  final selectedMonth = DateTime.now().month.obs;
  final selectedDay = Rxn<DateTime>();
  final selectedDateStr = "".obs; // yyyy-MM-dd for API
  final selectedDateDisplay = "".obs; // Fri, Sep 4 for UI

  // Questions
  final mainQuestionController = TextEditingController();
  final challengeQuestionController = TextEditingController();
  final backgroundQuestionController = TextEditingController();
  
  // ── Time conversion (UTC ↔ Local) ─────────────────────────────────────────
  String _utcToLocalTime(String timeStr) {
    return TimeHelper.utcToLocalTime(timeStr);
  }

  Future<void> fetchBookingSlots({
    int? year,
    int? month,
    required String author,
  }) async {
    if (year != null) selectedYear.value = year;
    if (month != null) selectedMonth.value = month;

    inProgress.value = true;
    try {
      final url = ApiUrls.getBookingSlots(
        year: selectedYear.value,
        month: selectedMonth.value,
      );

      final response = await ApiCaller.postRequest(
        url: url,
        body: {"author": author},
      );

      if (response?.statusCode == 200 && response?.isSuccess == true) {
        final slotsResponse = BookingSlotsResponse.fromJson(
          response?.responseData,
        );
        bookingSlots.assignAll(slotsResponse.data ?? []);
      } else {
        bookingSlots.clear();
      }
    } finally {
      inProgress.value = false;
    }
  }

  Future<void> getSlotsByExpertAndDate({
    required String expertId,
    required DateTime date,
  }) async {
    slotId.value = ""; // Reset previous selection
    selectedDay.value = date;
    selectedYear.value = date.year;
    selectedMonth.value = date.month;

    // Format: 2026-03-02
    selectedDateStr.value = DateFormat('yyyy-MM-dd').format(date);

    // Format: Fri, Sep 4
    selectedDateDisplay.value = DateFormat('EEE, MMM d').format(date);

    inProgress.value = true;
    try {
      final url = ApiUrls.getSlotsByExpert(
        expertId: expertId,
        year: selectedYear.value,
        month: selectedMonth.value,
        date: selectedDateStr.value,
      );

      final response = await ApiCaller.getRequest(url: url);
      log("url: $url");
      log("response: ${response?.responseData}");
      if (response?.statusCode == 200 && response?.isSuccess == true) {
        final slotsResponse = BookingSlotsResponse.fromJson(
          response?.responseData,
        );
        final slots = slotsResponse.data ?? [];

        // Filter only available slots
        final unbookedSlots = slots
            .where((slot) => slot.isBooked == false)
            .toList();
        availableSlots.assignAll(unbookedSlots);

        // Categorize slots using local lists first
        List<BookingSlot> morning = [];
        List<BookingSlot> afternoon = [];
        List<BookingSlot> evening = [];

        for (var slot in unbookedSlots) {
          if (slot.time != null) {
            // Convert UTC time from API to Local time
            slot.time = _utcToLocalTime(slot.time!);

            final hour = int.tryParse(slot.time!.split(':')[0]) ?? 0;
            if (hour < 12) {
              morning.add(slot);
            } else if (hour < 17) {
              afternoon.add(slot);
            } else {
              evening.add(slot);
            }
          }
        }

        // Update observable lists atomically
        morningSlots.assignAll(morning);
        afternoonSlots.assignAll(afternoon);
        eveningSlots.assignAll(evening);
      } else {
        availableSlots.clear();
        morningSlots.clear();
        afternoonSlots.clear();
        eveningSlots.clear();
      }
    } catch (e) {
      availableSlots.clear();
      morningSlots.clear();
      afternoonSlots.clear();
      eveningSlots.clear();
    } finally {
      inProgress.value = false;
    }
  }

  void setSessionDetails({
    required String type,
    required int duration,
    required int priceAmount,
    required String expertId,
  }) {
    sessionType.value = type;
    sessionDuration.value = duration;
    price.value = priceAmount;
    consultId.value = expertId;
  }

  Map<String, dynamic> getBookingBody() {
    return {
      "consult": consultId.value,
      "slot": slotId.value,
      "sessionType": sessionType.value,
      "sessionDuration": sessionDuration.value,
      "price": price.value,
      "mainQuestion": mainQuestionController.text.trim(),
      "challengeQuestion": challengeQuestionController.text.trim(),
      "backgroundQuestion": backgroundQuestionController.text.trim(),
    };
  }

  Future<bool> createBooking(BuildContext context) async {
    bool isSuccess = true;
    try {
      mainLoading(context, loadingText: 'Booking...');

      final response = await ApiCaller.postRequest(
        url: ApiUrls.createBooking,
        body: getBookingBody(),
      );

      Navigator.pop(context);
      // log("${response?.responseData.toString()}");
      if (response?.statusCode == 201 && response?.isSuccess == true) {
        final createBookingResponse = CreateBookingModel.fromJson(
          response?.responseData,
        );
        createdBookingData.value = createBookingResponse.data;
      } else {
        bottomMessage(msg: response?.message);
        log("${response?.message}");
        isSuccess = false;
      }
    } catch (e) {
      bottomMessage(msg: e.toString());
      isSuccess = false;
    }

    return isSuccess;
  }

  Future<bool> rescheduleBooking(BuildContext context, String bookingId) async {
    bool isSuccess = true;
    try {
      mainLoading(context, loadingText: 'Rescheduling...');

      final response = await ApiCaller.patchRequest(
        url: ApiUrls.rescheduleBooking(bookingId),
        body: {"slot": slotId.value},
      );

      Navigator.pop(context);
      // log("${response?.responseData.toString()}");
      if (response?.statusCode == 200 && response?.isSuccess == true) {
      } else {
        bottomMessage(msg: response?.message);
        log("${response?.message}");
        isSuccess = false;
      }
    } catch (e) {
      bottomMessage(msg: e.toString());
      isSuccess = false;
    }

    return isSuccess;
  }
}
