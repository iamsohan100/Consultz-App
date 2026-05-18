// lib/feature/discover/widgets/comment_modal_sheet.dart

import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/feature/discover/controller/comment_controller.dart';
import 'package:consultz/feature/discover/controller/content_controller.dart';
import 'package:consultz/feature/discover/controller/discover_controller.dart';
import 'package:consultz/feature/discover/widgets/comments.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> commentModalSheet(
  BuildContext context, {
  required String contentId,
  required bool? isDiscover,
  required String? userImage,
}) async {
  final double width = Screen.screenWidth(context);
  final double height = Screen.screenHeight(context);
  final double scaleFactor = width / Screen.designWidth;

  final controller = Get.find<CommentController>();
  controller.contentId = contentId;

  await showModalBottomSheet(
    context: context,
    enableDrag: true,
    showDragHandle: true,
    backgroundColor: Colors.white,
    isScrollControlled: true,
    constraints: BoxConstraints(
      minHeight: height * 0.6,
      maxHeight: height * 0.9,
    ),
    shape: RoundedRectangleBorder(
      side: BorderSide(color: AppColors.grey, width: 3),
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(scaleFactor * 20),
      ),
    ),
    builder: (context) => Comments(userImage: userImage),
  );

  // Modal বন্ধ হলে comment হয়ে থাকলে feed count আপডেট করো
  if (controller.commentSentCount > 0) {
    isDiscover == true
        ? Get.find<DiscoverController>().refreshFeedCount(contentId)
        : Get.find<ContentController>().refreshFeedCount(contentId);
  }

  controller.reset();
}
