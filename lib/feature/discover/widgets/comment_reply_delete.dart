// lib/feature/discover/widgets/comment_reply_delete.dart

import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/discover/controller/comment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentReplyDelete extends StatelessWidget {
  const CommentReplyDelete({
    super.key,
    required this.commentId,
    required this.userName,
    required this.isDeletable,
  });

  final String commentId;
  final String userName;
  final bool isDeletable;

  @override
  Widget build(BuildContext context) {
    final width = Screen.screenWidth(context);
    final scaleFactor = width / Screen.designWidth;
    final controller = Get.find<CommentController>();

    return PopupMenuButton<String>(
      color: AppColors.midGrey,
      icon: Icon(
        Icons.more_horiz,
        color: AppColors.darkGrey,
        size: scaleFactor * 20,
      ),
      onSelected: (value) {
        if (value == 'reply') {
          // Reply বাটনে tap করলে controller কে জানাই
          controller.setReplyingTo(
            commentId,
            userName,
          );
        }
        if (value == 'delete') {
          // No need to show alert dialog as per user request
          controller.deleteComment(commentId);
        }
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<String>(
          value: 'reply',
          child: Row(
            children: [
              Icon(
                Icons.reply,
                color: AppColors.darkGrey,
                size: scaleFactor * 18,
              ),
              SizedBox(width: scaleFactor * 8),
              CustomText(
                text: 'Reply',
                color: AppColors.darkGrey,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
        if (isDeletable)
          PopupMenuItem<String>(
            value: 'delete',
            child: Row(
              children: [
                Icon(
                  Icons.delete,
                  color: AppColors.darkGrey,
                  size: scaleFactor * 18,
                ),
                SizedBox(width: scaleFactor * 8),
                CustomText(
                  text: 'Delete',
                  color: AppColors.darkGrey,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
