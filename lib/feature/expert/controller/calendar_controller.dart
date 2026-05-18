// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/loading.dart/main_loading.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/core/utils/share_preference/auth_preference.dart';
import 'package:consultz/feature/Auth/controller/browse_first_controller.dart';
import 'package:consultz/feature/Auth/controller/login_controller.dart';
import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:consultz/feature/Auth/controller/sign_up_controller.dart';
import 'package:consultz/feature/expert/model/expert_profile_model.dart';
import 'package:consultz/feature/expert/model/available_time_model.dart';
import 'package:consultz/core/utils/helper/time_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalendarController extends GetxController {
  RxList<AvailableTimeModel> monday = RxList<AvailableTimeModel>();
  RxList<AvailableTimeModel> tuesday = RxList<AvailableTimeModel>();
  RxList<AvailableTimeModel> wednesday = RxList<AvailableTimeModel>();
  RxList<AvailableTimeModel> thursday = RxList<AvailableTimeModel>();
  RxList<AvailableTimeModel> friday = RxList<AvailableTimeModel>();
  RxList<AvailableTimeModel> saturday = RxList<AvailableTimeModel>();
  RxList<AvailableTimeModel> sunday = RxList<AvailableTimeModel>();

  // ── Get correct list by day name ──────────────────────────────────────────
  RxList<AvailableTimeModel> getDayList(String dayName) {
    switch (dayName.toLowerCase()) {
      case 'monday':
        return monday;
      case 'tuesday':
        return tuesday;
      case 'wednesday':
        return wednesday;
      case 'thursday':
        return thursday;
      case 'friday':
        return friday;
      case 'saturday':
        return saturday;
      case 'sunday':
        return sunday;
      default:
        return monday;
    }
  }

  // ── Day name → API short code ─────────────────────────────────────────────
  String _dayCode(String dayName) {
    switch (dayName.toLowerCase()) {
      case 'monday':
        return 'mon';
      case 'tuesday':
        return 'tue';
      case 'wednesday':
        return 'wed';
      case 'thursday':
        return 'thu';
      case 'friday':
        return 'fri';
      case 'saturday':
        return 'sat';
      case 'sunday':
        return 'sun';
      default:
        return 'mon';
    }
  }

  // ── Time conversions (Local ↔ UTC) ────────────────────────────────────────
  String _timeToUtc(String timeStr) {
    try {
      final parts = timeStr.split(':');
      if (parts.length != 2) return timeStr;
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);

      final now = DateTime.now();
      final localTime = DateTime(now.year, now.month, now.day, hour, minute);
      final utcTime = localTime.toUtc();

      return "${utcTime.hour.toString().padLeft(2, '0')}:${utcTime.minute.toString().padLeft(2, '0')}";
    } catch (e) {
      return timeStr;
    }
  }

  String _timeToLocal(String timeStr) {
    return TimeHelper.utcToLocalTime(timeStr);
  }

  // ── Build availability payload ────────────────────────────────────────────
  List<Map<String, dynamic>> _buildAvailabilityPayload() {
    final Map<String, RxList<AvailableTimeModel>> allDays = {
      'Monday': monday,
      'Tuesday': tuesday,
      'Wednesday': wednesday,
      'Thursday': thursday,
      'Friday': friday,
      'Saturday': saturday,
      'Sunday': sunday,
    };

    final List<Map<String, dynamic>> availability = [];

    allDays.forEach((dayName, slots) {
      if (slots.isNotEmpty) {
        availability.add({
          'day': _dayCode(dayName),
          'slots': slots
              .map((s) => {
                    'from': _timeToUtc(s.startTime),
                    'to': _timeToUtc(s.endTime)
                  })
              .toList(),
        });
      }
    });

    return availability;
  }

  // ── Load existing availability from profile ──────────────────────────────
  void loadFromProfile(List<Availability> availability) {
    // সব list আগে clear করো
    monday.clear();
    tuesday.clear();
    wednesday.clear();
    thursday.clear();
    friday.clear();
    saturday.clear();
    sunday.clear();

    for (final avail in availability) {
      final slots = avail.slots ?? [];
      final list = getDayList(_fullDayName(avail.day ?? ''));

      for (final slot in slots) {
        list.add(
          AvailableTimeModel(
            startTime: _timeToLocal(slot.from ?? '00:00'),
            endTime: _timeToLocal(slot.to ?? '00:00'),
          ),
        );
      }
    }
  }

  // ── API day code → full day name ──────────────────────────────────────────
  String _fullDayName(String code) {
    switch (code.toLowerCase()) {
      case 'mon':
        return 'monday';
      case 'tue':
        return 'tuesday';
      case 'wed':
        return 'wednesday';
      case 'thu':
        return 'thursday';
      case 'fri':
        return 'friday';
      case 'sat':
        return 'saturday';
      case 'sun':
        return 'sunday';
      default:
        return 'monday';
    }
  }

  // ── Submit to API ─────────────────────────────────────────────────────────
  // isProfileSetup: true শুধু signup-এর সময় pass করতে হবে
  Future<bool> submitAvailability(
    BuildContext context, {
    bool isProfileSetup = false,
  }) async {
    bool isSuccess = true;

    try {
      mainLoading(context, loadingText: 'Saving...');

      final Map<String, dynamic> body = {
        'availability': _buildAvailabilityPayload(),
        if (isProfileSetup) 'isProfileSetup': true,
      };
      log("body: $body");
      final response = await ApiCaller.putRequest(
        token: AuthPreference.accessToken,
        url: ApiUrls.updateProfile,
        body: body,
      );

      Navigator.pop(context);
      log('Calendar API response: ${response?.responseData}');

      if (response?.statusCode == 200 && response?.isSuccess == true) {
        if (isProfileSetup) {
          bool hasSignupInfo = false;
          String email = '';
          String password = '';

          if (Get.isRegistered<SignUpController>()) {
            final signUpController = Get.find<SignUpController>();
            email = signUpController.confirmEmailController.text.trim();
            password = signUpController.passwordController.text;
            if (email.isNotEmpty) {
              hasSignupInfo = true;
            }
          }

          if (hasSignupInfo) {
            // ── Signup flow: SignUpController-এ email আছে → login করো ──
            final loginController = Get.isRegistered<LoginController>()
                ? Get.find<LoginController>()
                : Get.put(LoginController());
            loginController.mailController.text = email;
            loginController.passwordController.text = password;

            final loginSuccess = await loginController.login(context);
            if (!loginSuccess) isSuccess = false;
          } else {
            // ── Social Login flow: token আছে → Update local status & Role ──
            if (AuthPreference.logInToken != null) {
              if (AuthPreference.logInInfo?.data?.user != null) {
                AuthPreference.logInInfo!.data!.user!.isProfileSetup = true;
                await AuthPreference().saveLoginToken(
                  logToken: AuthPreference.logInToken,
                  logInfo: AuthPreference.logInInfo,
                );
              }
            }

            final browseFirstController =
                Get.isRegistered<BrowseFirstController>()
                ? Get.find<BrowseFirstController>()
                : Get.put(BrowseFirstController());
            browseFirstController.isConsultee.value =
                AuthPreference.logInInfo?.data?.user?.role == 'expert'
                ? false
                : true;
          }
        } else {
          // ── Edit flow: profile refresh করো ───────────────────────────────
          await Get.find<ProfileController>().getMyProfile();
        }
      } else {
        bottomMessage(msg: response?.message);
        isSuccess = false;
      }
    } catch (e) {
      Navigator.pop(context);
      bottomMessage(msg: e.toString());
      isSuccess = false;
    }

    return isSuccess;
  }

  // ── Apply to all days ────────────────────────────────────────────────────
  void applyToAllDays(List<AvailableTimeModel> slots) {
    List<AvailableTimeModel> createCopy() => slots
        .map(
          (e) => AvailableTimeModel(startTime: e.startTime, endTime: e.endTime),
        )
        .toList();

    monday.assignAll(createCopy());
    tuesday.assignAll(createCopy());
    wednesday.assignAll(createCopy());
    thursday.assignAll(createCopy());
    friday.assignAll(createCopy());
    saturday.assignAll(createCopy());
    sunday.assignAll(createCopy());
  }
}
