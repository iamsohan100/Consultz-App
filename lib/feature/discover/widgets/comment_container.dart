import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/image/display_network_image.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_read_more_text.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/core/utils/different_text_format/time_format.dart';
import 'package:consultz/feature/discover/model/comment_model.dart';
import 'package:consultz/feature/discover/widgets/comment_reply_delete.dart';
import 'package:consultz/feature/discover/widgets/reply_container.dart';
import 'package:flutter/material.dart';

class CommentContainer extends StatefulWidget {
  const CommentContainer({super.key, required this.commentItem});

  final CommentItem commentItem;

  @override
  State<CommentContainer> createState() => _CommentContainerState();
}

class _CommentContainerState extends State<CommentContainer> {
  bool _repliesExpanded = false;

  @override
  Widget build(BuildContext context) {
    final double width = Screen.screenWidth(context);
    final double height = Screen.screenHeight(context);
    final double scaleFactor = width / Screen.designWidth;

    final item = widget.commentItem;
    final hasReplies = (item.reply ?? []).isNotEmpty;
    final replyCount = item.reply?.length ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Main comment row ─────────────────────────────────────
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: width * 0.02,
          children: [
            // Avatar
            Container(
              clipBehavior: Clip.antiAlias,
              width: scaleFactor * 35,
              height: scaleFactor * 35,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: item.user?.photoUrl != null
                  ? DisplayNetworkImage(
                      imageUrl: item.user?.photoUrl,
                      imageFit: BoxFit.cover,
                      imageSize: scaleFactor*35,
                    )
                  : Image.asset(AppImages.profile, fit: .cover),
            ),

            // Bubble
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                  left: scaleFactor * 12,
                  right: scaleFactor * 12,
                  top: scaleFactor * 10,
                  bottom: scaleFactor * 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.midGrey.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(scaleFactor * 6),
                    topRight: Radius.circular(scaleFactor * 14),
                    bottomLeft: Radius.circular(scaleFactor * 14),
                    bottomRight: Radius.circular(scaleFactor * 14),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: item.user?.fullName ?? 'Unknown',
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(height: height * 0.005),
                    CustomReadMoreText(
                      text: item.comment ?? '',
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      moreColor: AppColors.black,
                    ),

                    Row(
                      spacing: width * 0.04,
                      children: [
                        CustomText(
                          text: timeFormat(item.updatedAt!),
                          color: AppColors.darkGrey,
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                        CommentReplyDelete(
                          commentId: item.sId ?? '',
                          userName: item.user?.fullName ?? '',
                          isDeletable: item.isDeletable ?? false,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        // ── View / Hide replies toggle ────────────────────────────
        if (hasReplies) ...[
          SizedBox(height: height * 0.008),
          Padding(
            padding: EdgeInsets.only(left: scaleFactor * 47),
            child: GestureDetector(
              behavior: .opaque,
              onTap: () => setState(() => _repliesExpanded = !_repliesExpanded),
              child: Row(
                spacing: width * 0.015,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: scaleFactor * 20,
                    height: 1,
                    color: AppColors.darkGrey,
                  ),
                  CustomText(
                    text: _repliesExpanded
                        ? 'Hide replies'
                        : 'View $replyCount ${replyCount == 1 ? 'reply' : 'replies'}',
                    color: AppColors.darkGrey,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                  Icon(
                    _repliesExpanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    size: scaleFactor * 16,
                    color: AppColors.darkGrey,
                  ),
                ],
              ),
            ),
          ),
        ],

        // ── Expanded replies list ─────────────────────────────────
        if (hasReplies && _repliesExpanded) ...[
          SizedBox(height: height * 0.008),
          Padding(
            padding: EdgeInsets.only(left: scaleFactor * 47),
            child: Column(
              spacing: height * 0.008,
              children: (item.reply ?? [])
                  .map((reply) => ReplyContainer(reply: reply))
                  .toList(),
            ),
          ),
        ],
      ],
    );
  }
}
