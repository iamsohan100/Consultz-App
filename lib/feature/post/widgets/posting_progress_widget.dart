import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/feature/post/controller/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PostingProgressWidget extends StatelessWidget {
  const PostingProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final postController = Get.find<PostController>();
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    return Obx(() {
      if (!postController.isPosting.value) {
        return const SizedBox.shrink();
      }

      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: 10,
        ),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.midGrey),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.cloud_upload_outlined,
                  color: AppColors.primaryColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  postController.uploadProgress.value >= 0.95
                      ? 'Finishing up...'
                      : 'Publishing your post...',
                  style: GoogleFonts.figtree(
                    fontSize: scaleFactor * 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
                const Spacer(),
                Text(
                  '${(postController.uploadProgress.value * 100).toInt()}%',
                  style: GoogleFonts.figtree(
                    fontSize: scaleFactor * 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: postController.uploadProgress.value,
                backgroundColor: AppColors.midGrey,
                color: AppColors.primaryColor,
                minHeight: 6,
              ),
            ),
          ],
        ),
      );
    });
  }
}
