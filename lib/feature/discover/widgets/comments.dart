// lib/feature/discover/widgets/comments.dart

import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/image/display_network_image.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/form_field/custom_form_field.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/core/utils/widgets/no_data.dart';
import 'package:consultz/feature/discover/controller/comment_controller.dart';
import 'package:consultz/feature/discover/widgets/comment_container.dart';
import 'package:consultz/feature/expert/widgets/review_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Comments extends StatefulWidget {
  const Comments({super.key, this.userImage});
  final String? userImage;
  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  final CommentController controller = Get.find<CommentController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initialLoad();

      controller.scrollController.addListener(() {
        final pos = controller.scrollController.position;
        if (pos.pixels >= pos.maxScrollExtent - 200 &&
            !controller.isLoadingMore.value &&
            controller.hasMore.value) {
          controller.loadMore();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = Screen.screenWidth(context);
    final double height = Screen.screenHeight(context);
    final double scaleFactor = width / Screen.designWidth;

    return Padding(
      padding: EdgeInsets.only(
        left: width * 0.04,
        right: width * 0.04,
        // keyboard উঠলে input উপরে উঠবে
        bottom: MediaQuery.of(context).viewInsets.bottom + height * 0.02,
      ),
      child: Column(
        // mainAxisSize.min নেই — Column পুরো modal space নেবে
        children: [
          // ── Comment list — Expanded মানে বাকি সব space নেবে ────
          Expanded(
            child: Obx(() {
              if (controller.inProgress.value) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: scaleFactor * 14,
                    vertical: scaleFactor * 20,
                  ),
                  child: ReviewShimmer(length: 5),
                );
              }

              if (controller.commentList.isEmpty) {
                return Center(
                  child: NoData(text: 'No comments yet. Be the first!'),
                );
              }

              return ListView.separated(
                controller: controller.scrollController,
                padding: EdgeInsets.only(top: height * 0.01),
                itemCount:
                    controller.commentList.length +
                    (controller.isLoadingMore.value ? 1 : 0) +
                    (!controller.hasMore.value &&
                            controller.commentList.isNotEmpty
                        ? 1
                        : 0),
                separatorBuilder: (_, _) => SizedBox(height: height * 0.012),
                itemBuilder: (context, index) {
                  if (index == controller.commentList.length &&
                      controller.isLoadingMore.value) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.01),
                      child: ReviewShimmer(length: 2),
                    );
                  }
                  if (index == controller.commentList.length) {
                    return NoData(text: 'No more comments');
                  }
                  return CommentContainer(
                    commentItem: controller.commentList[index],
                  );
                },
              );
            }),
          ),

          // ── Reply indicator — list এর নিচে, input এর উপরে ──────
          Obx(() {
            if (controller.replyingToId.value == null) {
              return const SizedBox.shrink();
            }
            return Container(
              margin: EdgeInsets.only(top: height * 0.01),
              padding: EdgeInsets.symmetric(
                horizontal: scaleFactor * 12,
                vertical: scaleFactor * 6,
              ),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(scaleFactor * 8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.reply_rounded,
                    size: scaleFactor * 14,
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(width: width * 0.02),
                  Expanded(
                    child: CustomText(
                      text: 'Replying to ${controller.replyingToName.value}',
                      color: AppColors.primaryColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: controller.cancelReply,
                    child: Icon(
                      Icons.close_rounded,
                      size: scaleFactor * 14,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            );
          }),

          SizedBox(height: height * 0.015),

          // ── Input row — সবসময় নিচে fixed ───────────────────────
          Row(
            spacing: width * 0.02,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // User avatar
              Container(
                clipBehavior: Clip.antiAlias,
                width: scaleFactor * 45,
                height: scaleFactor * 45,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: DisplayNetworkImage(
                  imageUrl: widget.userImage,

                  imageFit: .cover,
                  imageSize: scaleFactor*45,
                ),
              ),

              // Text field
              Expanded(
                child: CustomFormField(
                  controller: controller.textController,
                  focusNode: controller.focusNode,
                  hintText: 'Write a comment...',
                  maxLine: 7,
                  padding: height * 0.008,
                ),
              ),

              // Send button
              Obx(() {
                final sending = controller.isSending.value;
                return GestureDetector(
                  onTap: sending ? null : controller.sendComment,
                  child: Container(
                    height: scaleFactor * 44,
                    width: scaleFactor * 44,
                    decoration: BoxDecoration(
                      color: sending
                          ? AppColors.midGrey
                          : AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(scaleFactor * 14),
                    ),
                    alignment: Alignment.center,
                    child: sending
                        ? SizedBox(
                            width: scaleFactor * 18,
                            height: scaleFactor * 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.white,
                            ),
                          )
                        : Image.asset(
                            AppImages.send,
                            width: scaleFactor * 18,
                            color: AppColors.white,
                          ),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
