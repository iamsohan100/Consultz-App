import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/loading.dart/circle_loading.dart';
import 'package:consultz/core/utils/widgets/no_data.dart';
import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:consultz/feature/expert/controller/expert_review_controller.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/feature/expert/widgets/review_content.dart';
import 'package:consultz/feature/expert/widgets/review_progress.dart';
import 'package:consultz/feature/expert/widgets/review_shimmer.dart';
import 'package:consultz/feature/expert/widgets/sort_by_button.dart';
import 'package:consultz/feature/expert/controller/expert_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpertReviews extends StatefulWidget {
  const ExpertReviews({super.key, this.isProfile, this.expertId});
  final bool? isProfile;
  final String? expertId;
  @override
  State<ExpertReviews> createState() => _ExpertReviewsState();
}

class _ExpertReviewsState extends State<ExpertReviews> {
  final profileController = Get.find<ProfileController>();
  final expertReviewController = Get.find<ExpertReviewController>();
  final expertDetailViewModel = Get.find<ExpertDetailController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      expertReviewController.expertId = widget.isProfile == true
          ? '${profileController.expertProfileModel.value.data?.sId}'
          : widget.expertId ?? '';

      expertReviewController.scrollController.addListener(() {
        if (expertReviewController.scrollController.position.pixels >=
                expertReviewController
                        .scrollController
                        .position
                        .maxScrollExtent -
                    200 &&
            !expertReviewController.isLoadingMore.value &&
            expertReviewController.hasMore.value) {
          expertReviewController.loadMore();
        }
      });
      if (expertReviewController.ratingBreakDown.value == null) {
        expertReviewController.getRating(
          expertId: expertReviewController.expertId,
        );
      }
      if (expertReviewController.reviewList.isEmpty) {
        expertReviewController.initialLoad();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    return Obx(() {
      // Show shimmer/loader on first load

      final reviews = expertReviewController.reviewList;

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: scaleFactor * 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.018),
            ReviewProgress(isProfile: widget.isProfile),
            SizedBox(height: height * 0.01),
            Divider(color: Color(0xFFE5E5E5)),

            SortByButton(),
            SizedBox(height: height * 0.025),
            if (expertReviewController.inReviewProgress.value)
              ReviewShimmer()
            else if (reviews.isEmpty)
              NoData(text: 'No reviews yet')
            else
              // Review list
              ListView.separated(
                padding: .zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: reviews.length,
                separatorBuilder: (_, _) => Divider(color: AppColors.midGrey),
                itemBuilder: (context, index) {
                  return ReviewContent(review: reviews[index]);
                },
              ),

            // Bottom loading indicator
            if (expertReviewController.isLoadingMore.value)
              CircleLoading(top: 0),

            // No more reviews indicator
            if (!expertReviewController.hasMore.value && reviews.isNotEmpty)
              NoData(text: 'No more reviews'),
          ],
        ),
      );
    });
  }
}
