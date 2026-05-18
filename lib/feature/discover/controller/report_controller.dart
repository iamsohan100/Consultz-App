// ignore_for_file: use_build_context_synchronously

import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/loading.dart/main_loading.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ReportController extends GetxController {
  final reasonController = TextEditingController();
  RxInt selectedIndex = (-1).obs;

  final List<String> reportReasons = [
    'Inappropriate Content',
    'Misinformation',
    'Harassment or Abuse',
    'Fake Expert Profile',
    'Fraud or Scam',
    'Other',
  ];

  Future<bool> submitReport(BuildContext context, {required String feedId}) async {
    if (selectedIndex.value == -1) {
      bottomMessage(msg: "Please select a reason");
      return false;
    }

    String reason = reportReasons[selectedIndex.value];
    if (selectedIndex.value == 5) {
      if (reasonController.text.trim().isEmpty) {
        bottomMessage(msg: "Please enter report reason");
        return false;
      }
      reason = reasonController.text.trim();
    }

    bool isSuccess = true;
    try {
      mainLoading(context, loadingText: 'Reporting...');

      final response = await ApiCaller.postRequest(
        url: ApiUrls.reportContent,
        body: {
          "feed": feedId,
          "reason": reason,
        },
      );

      Navigator.pop(context);

      if (response?.statusCode == 200 && response?.isSuccess == true) {
        bottomMessage(msg: "Report submitted successfully");
        reasonController.clear();
        selectedIndex.value = -1;
      } else {
        bottomMessage(msg: response?.message ?? "Failed to submit report");
        isSuccess = false;
      }
    } catch (e) {
      bottomMessage(msg: e.toString());
      isSuccess = false;
    }

    return isSuccess;
  }
}
