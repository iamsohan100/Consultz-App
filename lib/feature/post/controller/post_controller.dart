// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'package:consultz/core/network/api_caller_with_progress.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/core/utils/message/top_message.dart';
import 'package:consultz/feature/discover/controller/discover_controller.dart';
import 'package:consultz/feature/discover/model/content_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PostController extends GetxController {
  RxList<File> imageList = <File>[].obs;
  RxList<File> videoList = <File>[].obs;
  RxBool isPosting = false.obs;
  RxDouble uploadProgress = 0.0.obs;

  static const int maxImages = 50;
  static const int maxVideos = 20;
  final captionController = TextEditingController();
  void addMixedMedia(List<XFile> files) {
    for (final file in files) {
      final path = file.path.toLowerCase();
      final isVideo =
          file.mimeType?.startsWith('video') == true ||
          path.endsWith('.mp4') ||
          path.endsWith('.mov') ||
          path.endsWith('.avi') ||
          path.endsWith('.mkv') ||
          path.endsWith('.webm');

      if (isVideo) {
        if (videoList.length < maxVideos) {
          videoList.add(File(file.path));
        }
      } else {
        if (imageList.length < maxImages) {
          imageList.add(File(file.path));
        }
      }
    }
  }

  void removeImage(int index) {
    if (index < imageList.length) imageList.removeAt(index);
  }

  void removeVideo(int index) {
    if (index < videoList.length) videoList.removeAt(index);
  }

  void clearAll() {
    imageList.clear();
    videoList.clear();
    captionController.clear();
  }

  Future<void> createPost() async {
    if (captionController.text.trim().isEmpty &&
        imageList.isEmpty &&
        videoList.isEmpty) {
      bottomMessage(msg: 'Write something or add media');
      return;
    }

    final desc = captionController.text.trim();
    final allFiles = [...imageList, ...videoList];

    clearAll();
    isPosting.value = true;
    uploadProgress.value = 0.0;

    try {
      final response = await ApiCallerWithProgress.formRequest(
        method: 'POST',
        url: ApiUrls.createPost,
        multipleFiles: allFiles.isNotEmpty ? {"content": allFiles} : null,
        fields: desc.isNotEmpty ? {"description": desc} : null,
        onProgress: (progress) {
          uploadProgress.value = progress;
        },
      );

      log("Post Response: ${response?.responseData.toString()}");

      if (response?.statusCode == 201 && response?.isSuccess == true) {
        uploadProgress.value = 1.0;
        final newPost = FeedList.fromJson(response?.responseData['data']);
        if (Get.isRegistered<DiscoverController>()) {
          Get.find<DiscoverController>().contentList.insert(0, newPost);
        }

        await Future.delayed(const Duration(milliseconds: 500));
        topMessage(
          title: 'Successful',
          msg: 'Post has been published successfully.',
        );
      } else {
        bottomMessage(msg: response?.message ?? 'Failed to publish post');
      }
    } catch (e) {
      log("Post error: $e");
      bottomMessage(msg: 'An error occurred while posting');
    } finally {
      isPosting.value = false;
      uploadProgress.value = 0.0;
    }
  }
}
