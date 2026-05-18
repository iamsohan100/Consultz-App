// ignore_for_file: use_build_context_synchronously

import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/loading.dart/main_loading.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupportController extends GetxController {
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  Future<bool> sendSupportMessage(BuildContext context) async {
    final String subject = subjectController.text.trim();
    final String message = messageController.text.trim();

    bool isSuccess = true;
    try {
      mainLoading(context, loadingText: 'Sending...');
      final response = await ApiCaller.postRequest(
        url: ApiUrls.supportMessage,
        body: {"subject": subject, "messages": message},
      );

      if (response?.statusCode == 201 && response?.isSuccess == true) {
      } else {
        bottomMessage(msg: "Failed to send message");
        isSuccess = true;
      }
    } catch (e) {
      bottomMessage(msg: e.toString());
      isSuccess = true;
    } finally {
      Navigator.pop(context);
    }

    return isSuccess;
  }

  @override
  void onClose() {
    subjectController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
