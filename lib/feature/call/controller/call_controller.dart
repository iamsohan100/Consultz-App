// ignore_for_file: use_build_context_synchronously
import 'dart:developer';

import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:get/get.dart';

class CallController extends GetxController {
  final roomId = ''.obs;
  final callId = ''.obs;
  final bookingId = ''.obs;
  final channelName = ''.obs;
  final token = ''.obs;
  final uid = 0.obs;
  final isVideo = true.obs;
  final isLoading = false.obs;
  final inProgress = false.obs;

  // This will be used when caller starts a call
  void setCallData(Map<String, dynamic> data) {
    callId.value = data['callId']?.toString() ?? '';
    bookingId.value = data['bookingId']?.toString() ?? '';
    channelName.value = data['channelName']?.toString() ?? '';
    token.value = data['token']?.toString() ?? '';
    uid.value = data['uid'] is int ? data['uid'] : int.tryParse(data['uid']?.toString() ?? '0') ?? 0;
    isVideo.value = data['isVideo'] ?? true;
  }

  Future<bool> getToken({String? callId}) async {
    bool isSuccess = true;
    try {
      inProgress.value = true;
      Map<String, dynamic> body = {
        "callId": callId ?? this.callId.value,
      };

      final response = await ApiCaller.postRequest(
        url: ApiUrls.callTokenUrl,
        body: body,
      );

      inProgress.value = false;

      if (response?.isSuccess == true) {
        token.value = response?.responseData['data']['token'] ?? '';
        uid.value = response?.responseData['data']['uid'] is int 
            ? response?.responseData['data']['uid'] 
            : int.tryParse(response?.responseData['data']['uid']?.toString() ?? '0') ?? 0;
        return true;
      } else {
        bottomMessage(msg: response?.message);
        isSuccess = false;
      }
    } catch (e) {
      bottomMessage(msg: e.toString());
      log('Error fetching token: $e');
      isSuccess = false;
    }
    return isSuccess;
  }
}