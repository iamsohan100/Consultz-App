// ignore_for_file: deprecated_member_use

import 'package:consultz/feature/discover/model/content_model.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/feature/discover/controller/content_controller.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class ViewMyProfile extends StatelessWidget {
  const ViewMyProfile({super.key, required this.feedList});
  final FeedList? feedList;
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    GestureDetector sectionContent({
      required String title,
      required VoidCallback onTap,
      required String image,
    }) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Row(
          children: [
            Image.asset(
              image,
              width: scaleFactor * 21,
              color: AppColors.darkGrey,
            ),
            SizedBox(width: width * 0.04),
            CustomText(
              text: title,
              color: AppColors.black,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.darkGrey,
              size: scaleFactor * 15,
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      child: SingleChildScrollView(
        child: Column(
          spacing: height * 0.014,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            sectionContent(
              onTap: () {
           if (feedList?.sId != null) {
                  final String authorName = feedList?.author?.firstName ?? "an expert";
                  
                  final String shareLink = "https://consultz-e39b8.web.app/post/${feedList!.sId}";
                  
                  Share.share(
                    "Check out this interesting post by $authorName on Consultz!\n\n$shareLink",
                    subject: "Interesting Post on Consultz",
                  );
                }              },
              title: 'Share via',
              image: AppImages.shareVia,
            ),

            sectionContent(
              onTap: () async {
                final contentController = Get.find<ContentController>();
                await contentController.deleteContent(
                  context: context,
                  contentId: feedList?.sId ?? '',
                );
              },
              title: 'Delete Post',
              image: AppImages.delete,
            ),
            SizedBox(height: height * 0.03),
          ],
        ),
      ),
    );
  }
}
