// lib/feature/discover/controller/comment_controller.dart

import 'dart:developer';
import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/feature/discover/model/comment_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentController extends GetxController {
  String contentId = '';

  final inProgress = false.obs;
  final isLoadingMore = false.obs;
  final hasMore = true.obs;
  final isSending = false.obs;
  final commentList = <CommentItem>[].obs;

  final replyingToId = Rxn<String>();
  final replyingToName = ''.obs;
  int commentSentCount = 0; // modal বন্ধ হলে কতটা comment হয়েছে track করে

  int currentPage = 1;
  final int _limit = 20;

  final ScrollController scrollController = ScrollController();
  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  void reset() {
    contentId = '';
    currentPage = 1;
    commentList.clear();
    hasMore.value = true;
    inProgress.value = false;
    isLoadingMore.value = false;
    isSending.value = false;
    replyingToId.value = null;
    replyingToName.value = '';
    commentSentCount = 0;
    textController.clear();
    scrollController.removeListener(_scrollListener);
  }

  void _scrollListener() {
    final pos = scrollController.position;
    if (pos.pixels >= pos.maxScrollExtent - 200 &&
        !isLoadingMore.value &&
        hasMore.value) {
      loadMore();
    }
  }

  Future<void> initialLoad() async {
    currentPage = 1;
    commentList.clear();
    hasMore.value = true;
    await _fetchComments();
  }

  Future<void> loadMore() async {
    currentPage++;
    await _fetchComments();
  }

  Future<void> _fetchComments() async {
    try {
      if (currentPage == 1) {
        inProgress.value = true;
      } else {
        isLoadingMore.value = true;
      }

      final response = await ApiCaller.getRequest(
        url: ApiUrls.getComments(
          id: contentId,
          page: currentPage.toString(),
          limit: _limit,
        ),
      );

      log('Comments response: ${response?.responseData}');

      if (response?.statusCode == 200 && response?.isSuccess == true) {
        final model = CommentResponseModel.fromJson(response?.responseData);
        final list = model.data ?? [];
        if (list.isEmpty || list.length < _limit) hasMore.value = false;
        commentList.addAll(list);
      } else {
        bottomMessage(msg: response?.message);
        if (currentPage > 1) currentPage--;
      }
    } catch (e) {
      bottomMessage(msg: e.toString());
      if (currentPage > 1) currentPage--;
    } finally {
      inProgress.value = false;
      isLoadingMore.value = false;
    }
  }

  void setReplyingTo(String commentId, String name) {
    replyingToId.value = commentId;
    replyingToName.value = name;
    focusNode.requestFocus();
  }

  void cancelReply() {
    replyingToId.value = null;
    replyingToName.value = '';
  }

  Future<void> deleteComment(String commentId) async {
    try {
      final response = await ApiCaller.deleteRequest(
        url: ApiUrls.deleteComment(commentId),
      );

      log('Delete comment response: ${response?.responseData}');

      if (response?.statusCode == 200 || response?.statusCode == 201) {
        if (commentSentCount > 0) commentSentCount--;
        await initialLoad();
      } else {
        bottomMessage(msg: response?.message);
      }
    } catch (e) {
      bottomMessage(msg: e.toString());
    }
  }

  Future<void> sendComment() async {
    final text = textController.text.trim();
    if (text.isEmpty) return;

    try {
      isSending.value = true;

      final Map<String, dynamic> body = replyingToId.value != null
          ? {
              'content': contentId,
              'comment': text,
              'isReply': true,
              'replyRef': replyingToId.value,
            }
          : {
              'content': contentId,
              'comment': text,
            };

      final response = await ApiCaller.postRequest(
        url: ApiUrls.postComment,
        body: body,
      );

      log('Send comment response: ${response?.responseData}');

      if (response?.statusCode == 200 || response?.statusCode == 201) {
        textController.clear();
        cancelReply();
        commentSentCount++;
        await initialLoad();
      } else {
        bottomMessage(msg: response?.message);
      }
    } catch (e) {
      bottomMessage(msg: e.toString());
    } finally {
      isSending.value = false;
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    textController.dispose();
    focusNode.dispose();
    super.onClose();
  }
}