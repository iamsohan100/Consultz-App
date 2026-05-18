import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/image/display_network_image.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_read_more_text.dart';
import 'package:consultz/core/utils/text/custom_rich_text.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/core/utils/different_text_format/time_format.dart';
import 'package:consultz/feature/expert/model/expert_review_model.dart';
import 'package:flutter/material.dart';

class ReviewContent extends StatelessWidget {
  const ReviewContent({super.key, required this.review});
  final Reviews review; // ✅ real API model

  @override
  Widget build(BuildContext context) {
    final height = Screen.screenHeight(context);
    final width = Screen.screenWidth(context);
    final scaleFactor = width / Screen.designWidth;

    // Dynamic star rating
    final double rating = (review.rating ?? 0).toDouble();
    final int fullStars = rating.floor();
    final bool hasHalfStar = (rating - fullStars) > 0;
    final int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);

    final String userName =
        '${review.user?.firstName ?? ''} ${review.user?.lastName ?? ''}'.trim();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              width: scaleFactor * 38,
              height: scaleFactor * 38,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: review.user?.photoUrl != null
                  ? DisplayNetworkImage(
                      imageUrl: review.user?.photoUrl,
                      imageFit: .cover,
                      imageSize: scaleFactor*38,
                    )
                  : Image.asset(AppImages.profileImage, fit: BoxFit.cover),
            ),
            SizedBox(width: width * 0.03),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: userName,
                  color: AppColors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                CustomRichText(
                  text1: '${review.booking?.sessionType ?? ''}  ',
                  color1: AppColors.darkGrey,
                  fontSize1: 10,
                  fontWeight: FontWeight.w500,
                  text2: timeFormat(review.createdAt ?? ''),
                  color2: AppColors.grey,
                  fontSize2: 10,
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: height * 0.016),

        // ✅ Dynamic star rating
        Row(
          children: [
            for (int i = 0; i < fullStars; i++)
              Icon(
                Icons.star_rounded,
                size: scaleFactor * 16,
                color: AppColors.warmYellow,
              ),
            if (hasHalfStar)
              Icon(
                Icons.star_half_rounded,
                size: scaleFactor * 16,
                color: AppColors.warmYellow,
              ),
            for (int i = 0; i < emptyStars; i++)
              Icon(
                Icons.star_outline_rounded,
                size: scaleFactor * 16,
                color: AppColors.warmYellow,
              ),
          ],
        ),

        SizedBox(height: height * 0.014),
        CustomReadMoreText(
          text: review.review ?? '',
          color: Color(0xFF363F72),
          fontSize: 12,
          fontWeight: FontWeight.w400,
          lineHeight: 1.6,
        ),

        SizedBox(height: height * 0.016),
      ],
    );
  }
}
