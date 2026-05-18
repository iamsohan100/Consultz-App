import 'dart:developer';

import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/feature/Auth/controller/browse_first_controller.dart';
import 'package:consultz/feature/bookings/model/expert_booking_by_date_model.dart';
import 'package:consultz/core/utils/helper/time_helper.dart';
import 'package:get/get.dart';

class ExpertBookingController extends GetxController {
  final inProgress = false.obs;
  final bookingDateGroups = <BookingDateGroup>[].obs;

  final isDay = true.obs;
  final isWeek = false.obs;
  final isMonth = false.obs;

  final selectedFilter = 'today'.obs; // today, tomorrow, day, week, month
  final selectedDate = RxnString(); // For 'day' filterType

  // UI States for "Day" sub-filters
  final isToday = true.obs;
  final isTomorrow = false.obs;
  final isCustomDate = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBookings();
  }

  Future<void> fetchBookings() async {
    inProgress.value = true;
    try {
      final isConsultee = Get.find<BrowseFirstController>().isConsultee.value;
      final url = ApiUrls.getBookingsByDate(
        isConsultee: isConsultee,
        filterType: selectedFilter.value,
        date: selectedDate.value,
      );

      final response = await ApiCaller.getRequest(url: url);
      log("response data: ${response?.responseData}");
      if (response != null && response.isSuccess) {
        final model = ExpertBookingByDateResponse.fromJson(
          response.responseData,
        );
        
        // Convert UTC to local for each booking
        if (model.data != null) {
          for (var group in model.data!) {
            if (group.bookingList != null) {
              for (var booking in group.bookingList!) {
                if (booking.slot?.time != null) {
                  booking.slot!.time = TimeHelper.utcToLocalTime(booking.slot!.time!);
                }
              }
            }
          }
        }

        bookingDateGroups.assignAll(model.data ?? []);
      } else {
        bookingDateGroups.clear();
      }
    } finally {
      inProgress.value = false;
    }
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;

    // Reset specific date when switching filters
    if (filter != 'day') {
      selectedDate.value = null;
    }

    if (['today', 'tomorrow', 'day'].contains(filter)) {
      isDay.value = true;
      isWeek.value = false;
      isMonth.value = false;

      // Update sub-filters for Day
      isToday.value = (filter == 'today');
      isTomorrow.value = (filter == 'tomorrow');
      isCustomDate.value = (filter == 'day');
    } else if (filter == 'week') {
      isDay.value = false;
      isWeek.value = true;
      isMonth.value = false;
    } else if (filter == 'month') {
      isDay.value = false;
      isWeek.value = false;
      isMonth.value = true;
    }

    fetchBookings();
  }

  void pickDate(String date) {
    selectedFilter.value = 'day';
    selectedDate.value = date;

    isDay.value = true;
    isWeek.value = false;
    isMonth.value = false;

    isToday.value = false;
    isTomorrow.value = false;
    isCustomDate.value = true;

    fetchBookings();
  }

  bool isSelectedFilter(String filter) => selectedFilter.value == filter;
}
