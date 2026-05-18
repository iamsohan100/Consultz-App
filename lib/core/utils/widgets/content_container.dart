// lib/core/utils/widgets/content_container.dart

import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_read_more_text.dart';
import 'package:consultz/core/utils/widgets/content_profile.dart';
import 'package:consultz/core/utils/widgets/images_and_video.dart';
import 'package:consultz/core/utils/widgets/like_and_comment.dart';
import 'package:consultz/feature/discover/model/content_model.dart';
import 'package:flutter/material.dart';

class ContentContainer extends StatelessWidget {
  const ContentContainer({
    super.key,
    this.isDiscover,
    this.isProfile,
    this.feedList,
    this.showcaseKey,
  });

  final bool? isDiscover;
  final bool? isProfile;
  final FeedList? feedList;
  final GlobalKey? showcaseKey;

  @override
  Widget build(BuildContext context) {
    final double height = Screen.screenHeight(context);
    final double width = Screen.screenWidth(context);
    final double scaleFactor = width / Screen.designWidth;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: scaleFactor * 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile row (avatar, name, time, follow button)
              ContentProfile(
                isProfile: isProfile,
                feedList: feedList,
                isDiscover: isDiscover,
              ),

              // Description text with read more
              if (feedList?.description != null &&
                  feedList!.description!.isNotEmpty) ...[
                SizedBox(height: height * 0.015),
                CustomReadMoreText(
                  text: feedList!.description!,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                  trimLine: 2,
                  moreColor: AppColors.grey,
                ),
              ],
            ],
          ),
        ),

        // Images / Videos (empty → shows nothing)
        ImagesAndVideos(feedList: feedList),

        SizedBox(height: height * 0.015),
        LikeAndComment(
          feedList: feedList,
          isDiscover: isDiscover,
          showcaseKey: showcaseKey,
        ),
        SizedBox(height: height * 0.008),
        Divider(color: AppColors.midGrey),
        SizedBox(height: height * 0.008),
      ],
    );
  }
}
