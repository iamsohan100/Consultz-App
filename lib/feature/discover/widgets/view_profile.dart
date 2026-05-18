// ignore_for_file: deprecated_member_use

import 'package:consultz/core/utils/image/display_network_image.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/feature/discover/model/content_model.dart';
import 'package:consultz/feature/discover/widgets/report_dialog.dart';
import 'package:consultz/feature/profile/controller/blocked_user_controller.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewProfile extends StatelessWidget {
  const ViewProfile({
    super.key,
    this.isProfile,
    this.isDiscover,
    required this.feedList,
  });
  final bool? isProfile;
  final bool? isDiscover;
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
            if (title == 'View profile')
              Container(
                clipBehavior: Clip.antiAlias,
                height: scaleFactor * 24,
                width: scaleFactor * 24,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: DisplayNetworkImage(
                  imageUrl: feedList?.author?.photoUrl,
                  imageFit: .cover,
                  imageSize: scaleFactor*24,
                ),
              )
            else
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
            if (isDiscover == true)
              sectionContent(
                onTap: () {
                  Get.toNamed(
                    RoutesConstant.expertDetailsScreen,
                    arguments: feedList?.author?.sId,
                  );
                },
                title: 'View profile',
                image: AppImages.expert1,
              ),
            sectionContent(
              onTap: () {
                Get.toNamed(
                  RoutesConstant.selectSessionScreen,
                  arguments: feedList?.author?.sId ?? '',
                );
              },
              title: 'Book a call',

              image: AppImages.bookCall,
            ),
            sectionContent(
              onTap: () {
                if (feedList?.sId != null) {
                  final String authorName = feedList?.author?.firstName ?? "an expert";
                  
                  final String shareLink = "https://consultz-e39b8.web.app/post/${feedList!.sId}";
                  
                  Share.share(
                    "Check out this interesting post by $authorName on Consultz!\n\n$shareLink",
                    subject: "Interesting Post on Consultz",
                  );
                }
              },
              title: 'Share via',
              image: AppImages.shareVia,
            ),
            sectionContent(
              onTap: () {
                Navigator.pop(context);
                reportDialog(context, feedId: feedList?.sId ?? "");
              },
              title: 'Report',
              image: AppImages.report,
            ),
            sectionContent(
              onTap: () async {
                final response = await Get.find<BlockedUserController>()
                    .unblockedUser(
                      context,
                      userId: feedList?.author?.sId ?? "",
                      isBlock: true,
                    );
                if (response) {
                  Navigator.pop(context);
                  bottomMessage(msg: 'User blocked successfully.');
                }
              },
              title: 'Block',
              image: AppImages.block,
            ),
            SizedBox(height: height * 0.03),
          ],
        ),
      ),
    );
  }
}
