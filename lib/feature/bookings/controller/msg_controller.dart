import 'dart:developer';
import 'dart:io';
import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/feature/bookings/controller/socket_service_controller.dart';
import 'package:consultz/feature/bookings/model/chat_message_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MsgController extends GetxController {
  final inProgress = false.obs;
  final uploadInProgress = false.obs;
  final isLoadingMore = false.obs;
  final hasMore = true.obs;
  final messageList = <ChatMessageData>[].obs;

  int currentPage = 1;
  final int _limit = 20;
  final ScrollController scrollController = ScrollController();

  final msgController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent &&
        !isLoadingMore.value &&
        hasMore.value &&
        !inProgress.value) {
      final String? bookingId = Get.arguments is Map
          ? Get.arguments['bookingId']
          : null;
      if (bookingId != null) {
        loadMore(bookingId);
      }
    }
  }

  Future<void> initialLoad(String bookingId) async {
    currentPage = 1;
    messageList.clear();
    hasMore.value = true;
    await getMessages(bookingId);
  }

  Future<void> loadMore(String bookingId) async {
    currentPage++;
    await getMessages(bookingId);
  }

  Future<bool> getMessages(String bookingId) async {
    bool isSuccess = true;
    try {
      if (currentPage == 1) {
        inProgress.value = true;
      } else {
        isLoadingMore.value = true;
      }

      final response = await ApiCaller.getRequest(
        url: ApiUrls.getMessages(
          bookingId: bookingId,
          page: currentPage.toString(),
          limit: _limit,
        ),
      );

      // log("Messages response: ${response?.responseData}");

      if (response?.statusCode == 200 && response?.isSuccess == true) {
        final chatModel = ChatMessageModel.fromJson(response?.responseData);
        final messages = chatModel.data ?? [];

        if (messages.isEmpty || messages.length < _limit) {
          hasMore.value = false;
        }

        // Since it's a chat, the new (older) messages should be added to the END of the list
        // because the ListView is reversed.
        messageList.addAll(messages);
      } else {
        bottomMessage(msg: response?.message);
        isSuccess = false;
        if (currentPage > 1) currentPage--;
      }
    } catch (e) {
      bottomMessage(msg: e.toString());
      isSuccess = false;
      if (currentPage > 1) currentPage--;
    } finally {
      inProgress.value = false;
      isLoadingMore.value = false;
    }

    return isSuccess;
  }

  void addNewMessage(ChatMessageData message) {
    // Scroll list to bottom/top when new message arrives
    messageList.insert(0, message);
  }

  Future<void> uploadMultipleFiles({
    required String receiverId,
    required String bookingId,
  }) async {
    try {
      final ImagePicker picker = ImagePicker();
      final List<XFile> images = await picker.pickMultiImage();

      if (images.isNotEmpty) {
        uploadInProgress.value = true;

        List<File> imageFiles = images
            .map((xFile) => File(xFile.path))
            .toList();

        final response = await ApiCaller.formRequest(
          method: 'POST',
          url: ApiUrls.uploadMultiple,
          multipleFiles: {'files': imageFiles},
        );
        log(response?.responseData.toString() ?? "");

        if (response?.statusCode == 201 && response?.isSuccess == true) {
          final List<dynamic> data = response?.responseData['data'];
          final List<String> imageUrls = data
              .map((item) => item['url'].toString())
              .toList();

          if (imageUrls.isNotEmpty) {
            final socketController = Get.find<SocketServiceController>();
            socketController.sendMessageEmit(
              receiverId: receiverId,
              bookingId: bookingId,
              text: msgController.text.trim(),
              imageUrl: imageUrls,
            );
            msgController.clear();
          }
        } else {
          bottomMessage(msg: response?.message ?? 'Upload failed');
        }
      }
    } catch (e) {
      bottomMessage(msg: 'Error picking/uploading images: $e');
      log(e.toString());
    } finally {
      uploadInProgress.value = false;
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
