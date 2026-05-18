// ignore_for_file: deprecated_member_use

import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/share_preference/auth_preference.dart';
import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:consultz/feature/discover/controller/content_controller.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:consultz/feature/expert/controller/expert_profile_controller.dart';
import 'package:consultz/feature/expert/controller/expert_review_controller.dart';
import 'package:consultz/feature/expert/widgets/expert_content.dart';
import 'package:consultz/feature/expert/widgets/expert_cover_photo.dart';
import 'package:consultz/feature/expert/widgets/expert_details_shimmer.dart';
import 'package:consultz/feature/expert/widgets/expert_info.dart';
import 'package:consultz/feature/expert/widgets/expert_over_view.dart';
import 'package:consultz/feature/expert/widgets/expert_reviews.dart';
import 'package:consultz/feature/expert/widgets/expert_section_buttons.dart';
import 'package:consultz/feature/expert/controller/expert_detail_controller.dart';
import 'package:consultz/feature/main/controller/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpertDetailsScreen extends StatefulWidget {
  const ExpertDetailsScreen({super.key, this.isProfile});
  final bool? isProfile;

  @override
  State<ExpertDetailsScreen> createState() => _ExpertDetailsScreenState();
}

class _ExpertDetailsScreenState extends State<ExpertDetailsScreen> {
  final expertDetailController = Get.find<ExpertDetailController>();
  final profileController = Get.find<ProfileController>();
  final expertReviewController = Get.find<ExpertReviewController>();
  final contentController = Get.find<ContentController>();
  final expertProfileController = Get.find<ExpertProfileController>();
  final args = Get.arguments is String
      ? Get.arguments as String
      : null; //expert Id
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.isProfile != true) {
        _forProfile();
      }
      _forReviewContent();

      if (AuthPreference.isExpertDetailShowcaseShown == false) {
        _startShowcase();
      }
    });
  }

  void _startShowcase() async {
    // Referral dialog বন্ধ হওয়া পর্যন্ত অপেক্ষা করবে (যদি এটি প্রথমবার হয়)
    if (AuthPreference.isReferralDialogShown == false) {
      while (AuthPreference.isReferralDialogShown == false && mounted) {
        await Future.delayed(const Duration(milliseconds: 500));
      }
    }

    // ডায়ালগ বন্ধ হওয়ার পর বা যদি আগে থেকেই দেখানো হয়ে থাকে, তবে শোকেস শুরু হবে
    await Future.delayed(const Duration(milliseconds: 500));

    if (mounted) {
      // First set of keys
      List<GlobalKey> firstKeys = [];
      if (widget.isProfile == true) {
        firstKeys.add(expertDetailController.dashboardKey);
      }
      firstKeys.add(expertDetailController.shareButtonKey);

      ShowCaseWidget.of(context).startShowCase(firstKeys);
      AuthPreference().setExpertDetailShowcaseShown();
    }
  }

  void _forReviewContent() {
    expertReviewController.ratingBreakDown.value = null;
    expertReviewController.reviewList.clear();
    expertReviewController.currentPage = 1;
    expertReviewController.sort = 'latest';
    contentController.contentList.clear();
    contentController.currentPage = 1;
  }

  void _forProfile() {
    expertProfileController.getExpertProfile(id: args!);
  }

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    // double width = Screen.screenWidth(context);
    // double scaleFactor = width / Screen.designWidth;

    return PopScope(
      canPop: widget.isProfile == true ? false : true,
      onPopInvoked: (_) {
        if (widget.isProfile != true) {
        } else {
          Get.find<MainController>().changeIndex(index: 0);
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          controller: expertDetailController.isReviews.value
              ? expertReviewController.scrollController
              : expertDetailController.isContent.value
              ? contentController.scrollController
              : null,

          child: Obx(() {
            if (profileController.inProgress.value ||
                expertProfileController.inProgress.value) {
              return ExpertDetailsShimmer();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExpertCoverPhoto(isProfile: widget.isProfile),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ExpertInfo(isProfile: widget.isProfile),

                    SizedBox(height: height * 0.03),

                    ExpertSectionButtons(),
                    if (expertDetailController.isOverView.value)
                      ExpertOverView(isProfile: widget.isProfile),
                    if (expertDetailController.isReviews.value)
                      ExpertReviews(
                        isProfile: widget.isProfile,
                        expertId: args,
                      ),
                    if (expertDetailController.isContent.value)
                      ExpertContent(
                        isProfile: widget.isProfile,
                        expertId: args,
                      ),
                    SizedBox(height: height * 0.04),
                  ],
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
