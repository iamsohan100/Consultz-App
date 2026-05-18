// lib/feature/discover/widgets/reply_container.dart

import 'package:cached_network_image/cached_network_image.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_read_more_text.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/core/utils/different_text_format/time_format.dart';
import 'package:consultz/feature/discover/model/comment_model.dart';
import 'package:consultz/feature/discover/widgets/comment_reply_delete.dart';
import 'package:flutter/material.dart';

class ReplyContainer extends StatelessWidget {
  const ReplyContainer({super.key, required this.reply});

  final ReplyItem reply;

  @override
  Widget build(BuildContext context) {
    final double width = Screen.screenWidth(context);
    final double height = Screen.screenHeight(context);
    final double scaleFactor = width / Screen.designWidth;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: width * 0.02,
      children: [
        // Avatar
        Container(
          clipBehavior: Clip.antiAlias,
          width: scaleFactor * 28,
          height: scaleFactor * 28,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: reply.user?.photoUrl != null
              ? CachedNetworkImage(
                  imageUrl: reply.user!.photoUrl!,
                  fit: BoxFit.cover,
                  errorWidget: (_, _, _) => _placeholderAvatar(scaleFactor),
                )
              : _placeholderAvatar(scaleFactor),
        ),

        // Bubble
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: scaleFactor * 10,
              vertical: scaleFactor * 8,
            ),
            decoration: BoxDecoration(
              color: AppColors.midGrey.withValues(alpha: 0.35),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(scaleFactor * 4),
                topRight: Radius.circular(scaleFactor * 12),
                bottomLeft: Radius.circular(scaleFactor * 12),
                bottomRight: Radius.circular(scaleFactor * 12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: reply.user?.fullName ?? 'Unknown',
                  color: AppColors.black,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(height: height * 0.004),
                CustomReadMoreText(
                  text: reply.comment ?? '',
                  color: AppColors.black,
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  moreColor: AppColors.black,
                ),
                SizedBox(height: height * 0.004),
                Row(
                  spacing: width * 0.04,
                  children: [
                    CustomText(
                      text: timeFormat(reply.updatedAt!),
                      color: AppColors.darkGrey,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                    CommentReplyDelete(
                      commentId: reply.sId ?? '',
                      userName: reply.user?.fullName ?? '',
                      isDeletable: reply.isDeletable ?? false,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _placeholderAvatar(double scaleFactor) {
    return Container(
      color: AppColors.midGrey,
      child: Icon(Icons.person, size: scaleFactor * 18, color: AppColors.grey),
    );
  }
}
