import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/feature/post/controller/post_controller.dart';
import 'package:consultz/feature/post/widgets/video_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DisplayPostMedia extends StatelessWidget {
  const DisplayPostMedia({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final postController = Get.find<PostController>();

    return Obx(() {
      final bool hasImages = postController.imageList.isNotEmpty;
      final bool hasVideos = postController.videoList.isNotEmpty;

      if (!hasImages && !hasVideos) return const SizedBox();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ Images section
          if (hasImages)
            SizedBox(
              height: height * 0.2,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: postController.imageList.length,
                itemBuilder: (context, index) {
                  return _MediaThumbnail(
                    height: height,
                    width: width,
                    scaleFactor: scaleFactor,
                    onRemove: () => postController.removeImage(index),
                    child: Image.file(
                      postController.imageList[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),

          // ✅ Videos section
          if (hasVideos) ...[
            if (hasImages) SizedBox(height: scaleFactor * 8),
            SizedBox(
              height: height * 0.2,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: postController.videoList.length,
                itemBuilder: (context, index) {
                  return _MediaThumbnail(
                    height: height,
                    width: width,
                    scaleFactor: scaleFactor,
                    onRemove: () => postController.removeVideo(index),
                    child: VideoPreview(file: postController.videoList[index]),
                  );
                },
              ),
            ),
          ],
        ],
      );
    });
  }
}

// ─── Thumbnail wrapper ─────────────────────────────────────────────────────
class _MediaThumbnail extends StatelessWidget {
  const _MediaThumbnail({
    required this.height,
    required this.width,
    required this.scaleFactor,
    required this.onRemove,
    required this.child,
  });

  final double height, width, scaleFactor;
  final VoidCallback onRemove;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.all(scaleFactor * 4),
      height: height * 0.2,
      width: width * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(scaleFactor * 8),
        color: Colors.black12,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          child,
          Positioned(
            right: width * 0.01,
            top: height * 0.005,
            child: GestureDetector(
              onTap: onRemove,
              child: Icon(
                Icons.cancel_rounded,
                color: AppColors.white,
                size: scaleFactor * 22,
                shadows: const [Shadow(blurRadius: 4, color: Colors.black45)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
