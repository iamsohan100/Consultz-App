import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:consultz/feature/expert/controller/expert_profile_controller.dart';
import 'package:consultz/feature/expert/controller/expert_review_controller.dart';
import 'package:consultz/feature/expert/widgets/review_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewProgress extends StatelessWidget {
  const ReviewProgress({super.key, this.isProfile});
  final bool? isProfile;
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final profileController = Get.find<ProfileController>();
    final expertProfileController = Get.find<ExpertProfileController>();
    final expertReviewController = Get.find<ExpertReviewController>();

    Widget buildStarRating(dynamic rating) {
      int fullStars = rating.floor();
      bool hasHalfStar = (rating - fullStars) > 0;
      int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);

      return Row(
        children: [
          CustomText(
            text: rating.toStringAsFixed(1),
            color: AppColors.black,
            fontSize: 36,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(width: width * 0.02),
          for (int i = 0; i < fullStars; i++) ...[
            Icon(
              Icons.star_rounded,
              color: AppColors.warmYellow,
              size: scaleFactor * 25,
            ),
            SizedBox(width: width * 0.006),
          ],
          if (hasHalfStar) ...[
            Icon(
              Icons.star_half_rounded,
              color: AppColors.warmYellow,
              size: scaleFactor * 25,
            ),
            SizedBox(width: width * 0.006),
          ],
          for (int i = 0; i < emptyStars; i++) ...[
            Icon(
              Icons.star_outline_rounded,
              color: AppColors.warmYellow,
              size: scaleFactor * 25,
            ),
            SizedBox(width: width * 0.006),
          ],
        ],
      );
    }

    Row progress({required String title, required double value}) {
      return Row(
        children: [
          Expanded(
            flex: 2,
            child: CustomText(
              text: title,
              color: AppColors.black,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            flex: 6,
            child: SizedBox(
              height: height * 0.006,
              child: LinearProgressIndicator(
                value: value,
                backgroundColor: AppColors.midGrey,
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(scaleFactor * 10),
              ),
            ),
          ),
        ],
      );
    }

    return Obx(() {
      final profileData = profileController.expertProfileModel.value.data;
      final expertProfileData =
          expertProfileController.expertProfileModel.value.data;
      final activeData = isProfile == true ? profileData : expertProfileData;

      final ratingData = expertReviewController.ratingBreakDown.value;
      if (expertReviewController.inRatingProgress.value) {
        return ReviewShimmer();
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          buildStarRating(activeData?.avgRating ?? 0),

          CustomText(
            text:
                'Based on ${expertReviewController.totalReviews.value} reviews',
            color: AppColors.darkGrey,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: height * 0.015),
          progress(
            title: 'Excellent',
            value: ((ratingData?.excellent ?? 0).toDouble()),
          ),
          SizedBox(height: height * 0.01),
          progress(
            title: 'Very good',
            value: ((ratingData?.veryGood ?? 0).toDouble()),
          ),
          SizedBox(height: height * 0.01),
          progress(title: 'Good', value: ((ratingData?.good ?? 0).toDouble())),
          SizedBox(height: height * 0.01),
          progress(title: 'Fair', value: ((ratingData?.fair ?? 0).toDouble())),
          SizedBox(height: height * 0.01),
          progress(title: 'Poor', value: ((ratingData?.poor ?? 0).toDouble())),
        ],
      );
    });
  }
}
