import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/image/display_network_image.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_rich_text.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/core/utils/different_text_format/time_format.dart';
import 'package:consultz/feature/expert/widgets/view_my_profile_modal_sheet.dart';
import 'package:consultz/feature/discover/model/content_model.dart';
import 'package:consultz/feature/discover/widgets/view_profile_modal_sheet.dart';
import 'package:flutter/material.dart';

class ContentProfile extends StatelessWidget {
  const ContentProfile({
    super.key,
    this.isProfile,
    this.feedList,
    this.isDiscover,
  });
  final bool? isProfile;
  final FeedList? feedList;
  final bool? isDiscover;
  @override
  Widget build(BuildContext context) {
    // double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    return GestureDetector(
      onTap: () {
        if (isProfile == true) {
          viewMyProfileModalSheet(
            context: context,
            isProfile: isProfile,
            isDiscover: isDiscover,
            feedList: feedList,
          );
          // return;
        } else {
          viewProfileModalSheet(
            context: context,
            isProfile: isProfile,
            isDiscover: isDiscover,
            feedList: feedList,
          );
        }
      },
      child: Row(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            width: scaleFactor * 50,
            height: scaleFactor * 50,
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: feedList?.author?.photoUrl != null
                ? DisplayNetworkImage(
                    imageUrl: feedList?.author?.photoUrl,
                    imageFit: .cover,
                    imageSize: scaleFactor * 50,
                  )
                : Image.asset(AppImages.profileImage),
          ),
          SizedBox(width: width * 0.02),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: width * 0.04,
                  children: [
                    Expanded(
                      child: CustomText(
                        text:
                            "${feedList?.author?.firstName} ${feedList?.author?.lastName}",

                        color: AppColors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        maxLine: 1,
                        textOverflow: .ellipsis,
                      ),
                    ),
                    SizedBox(width: width * 0.02),
                    // if (isProfile != true)
                    Icon(
                      Icons.more_vert,
                      color: AppColors.grey,
                      size: scaleFactor * 18,
                    ),
                  ],
                ),
                if (feedList?.author?.headline != null &&
                    feedList?.author?.headline != '')
                  CustomText(
                    text: '${feedList?.author?.headline}',
                    color: AppColors.black,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    maxLine: 1,
                    textOverflow: .ellipsis,
                  ),

                CustomRichText(
                  text1: isProfile != true ? 'Book now  ' : '',
                  color1: AppColors.primaryColor,
                  fontSize1: 10,
                  fontWeight: FontWeight.w500,
                  text2: timeFormat(feedList?.createdAt ?? ''),
                  color2: AppColors.grey,
                  fontSize2: 10,
                  fontWeight2: FontWeight.w400,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
