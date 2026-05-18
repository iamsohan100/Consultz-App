// lib/core/utils/widgets/images_and_videos.dart

import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/widgets/content_images.dart';
import 'package:consultz/core/utils/widgets/media_item.dart';
import 'package:consultz/feature/discover/model/content_model.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagesAndVideos extends StatefulWidget {
  const ImagesAndVideos({super.key, this.feedList});

  final FeedList? feedList;

  @override
  State<ImagesAndVideos> createState() => _ImagesAndVideosState();
}

class _ImagesAndVideosState extends State<ImagesAndVideos> {
  @override
  Widget build(BuildContext context) {
    final content = widget.feedList?.content;

    if (content == null || content.isEmpty) return const SizedBox.shrink();

    final double height = Screen.screenHeight(context);
    // final double width = Screen.screenWidth(context);
    // final double scaleFactor = width / Screen.designWidth;

    return GestureDetector(
      onTap: () => Get.toNamed(
        RoutesConstant.fullScreenContent,
        arguments: widget.feedList,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height * 0.015),

          if (content.length == 1)
            AspectRatio(
              aspectRatio: 1 / 1,
              child: MediaItem(
                url: content.first,
                fit: BoxFit.cover,
                isSingle: true,
              ),
            ),

          if (content.length > 1) ContentImages(content: content),
        ],
      ),
    );
  }
}
