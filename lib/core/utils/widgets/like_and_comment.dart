// ignore_for_file: deprecated_member_use

import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/feature/discover/controller/content_controller.dart';
import 'package:consultz/feature/discover/controller/discover_controller.dart';
import 'package:consultz/feature/discover/controller/like_controller.dart';
import 'package:consultz/feature/discover/model/content_model.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/discover/widgets/comment_modal_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:showcaseview/showcaseview.dart';

class LikeAndComment extends StatelessWidget {
  const LikeAndComment({
    super.key,
    required this.feedList,
    this.isDiscover,
    this.isProfile,
    this.showcaseKey,
  });

  final FeedList? feedList;
  final bool? isDiscover;
  final bool? isProfile;
  final GlobalKey? showcaseKey;

  @override
  Widget build(BuildContext context) {
    final double width = Screen.screenWidth(context);
    final double scaleFactor = width / Screen.designWidth;

    final likeController = Get.find<LikeController>();
    final contentController = Get.find<ContentController>();
    final discoverController = Get.find<DiscoverController>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: scaleFactor * 14),
      child: Row(
        spacing: width * 0.02,
        children: [
          // ── Like ──────────────────────────────────────────────────────────
          Obx(() {
            // contentList থেকে সবসময় fresh data পড়ো
            final index = isDiscover == true
                ? discoverController.contentList.indexWhere(
                    (f) => f.sId == feedList?.sId,
                  )
                : contentController.contentList.indexWhere(
                    (f) => f.sId == feedList?.sId,
                  );

            final currentFeed = index != -1
                ? (isDiscover == true
                      ? discoverController.contentList[index]
                      : contentController.contentList[index])
                : feedList;

            final isLiked = currentFeed?.isLiked ?? false;
            final likeCount = currentFeed?.contentMeta?.like ?? 0;

            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (feedList?.sId == null) return;
                if (isLiked) {
                  likeController.unlikeContent(
                    feedList!.sId!,
                    isDiscover: isDiscover,
                  );
                } else {
                  likeController.likeContent(
                    feedList!.sId!,
                    isDiscover: isDiscover,
                  );
                }
              },
              child: Row(
                spacing: width * 0.02,
                children: [
                  Image.asset(
                    AppImages.love,
                    width: scaleFactor * 13.5,
                    color: isLiked ? AppColors.primaryColor : null,
                  ),
                  CustomText(
                    text: '$likeCount',
                    color: AppColors.darkGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            );
          }),

          SizedBox(width: width * 0.015),

          // ── Comment ───────────────────────────────────────────────────────
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if (feedList?.sId != null) {
                commentModalSheet(
                  context,
                  contentId: feedList!.sId!,
                  isDiscover: isDiscover,
                  userImage: feedList?.author?.photoUrl,
                );
              }
            },
            child: Row(
              spacing: width * 0.02,
              children: [
                Image.asset(AppImages.comment, width: scaleFactor * 13.5),
                Obx(() {
                  final index = isDiscover == true
                      ? discoverController.contentList.indexWhere(
                          (f) => f.sId == feedList?.sId,
                        )
                      : contentController.contentList.indexWhere(
                          (f) => f.sId == feedList?.sId,
                        );
                  final count = index != -1
                      ? (isDiscover == true
                                ? discoverController
                                      .contentList[index]
                                      .contentMeta
                                      ?.comment
                                : contentController
                                      .contentList[index]
                                      .contentMeta
                                      ?.comment) ??
                            0
                      : feedList?.contentMeta?.comment ?? 0;

                  return CustomText(
                    text: '$count',
                    color: AppColors.darkGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  );
                }),
              ],
            ),
          ),
          SizedBox(width: width * 0.015),
          // ── share ───────────────────────────────────────────────────────
          if (showcaseKey != null)
            Showcase(
              key: showcaseKey!,
              description: 'Click here to share this post',
              descTextStyle: const TextStyle(
                color: AppColors.black,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              child: _buildShareButton(width, scaleFactor),
            )
          else
            _buildShareButton(width, scaleFactor),

          SizedBox(width: width * 0.01),
        ],
      ),
    );
  }

  Widget _buildShareButton(double width, double scaleFactor) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (feedList?.sId != null) {
          final String authorName = feedList?.author?.firstName ?? "an expert";

          final String shareLink =
              "https://consultz-e39b8.web.app/post/${feedList!.sId}";

          Share.share(
            "Check out this interesting post by $authorName on Consultz!\n\n$shareLink",
            subject: "Interesting Post on Consultz",
          );
        }
      },
      child: Row(
        spacing: width * 0.02,
        children: [
          Transform.scale(
            scaleX: -1,
            child: Icon(
              Icons.reply,
              size: scaleFactor * 20,
              color: AppColors.darkGrey,
            ),
          ),
        ],
      ),
    );
  }
}
