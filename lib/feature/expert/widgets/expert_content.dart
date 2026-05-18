// lib/feature/expert/widgets/expert_content.dart

import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/loading.dart/circle_loading.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/widgets/content_container.dart';
import 'package:consultz/core/utils/widgets/no_data.dart';
import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:consultz/feature/discover/controller/content_controller.dart';
import 'package:consultz/feature/discover/widgets/discover_shimmer.dart';
import 'package:consultz/feature/expert/controller/expert_profile_controller.dart';
import 'package:consultz/feature/expert/controller/expert_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpertContent extends StatefulWidget {
  const ExpertContent({super.key, this.isProfile, this.expertId});

  final bool? isProfile;
  final String? expertId;
  @override
  State<ExpertContent> createState() => _ExpertContentState();
}

class _ExpertContentState extends State<ExpertContent> {
  final contentController = Get.find<ContentController>();
  final profileController = Get.find<ProfileController>();
  final expertProfileController = Get.find<ExpertProfileController>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      contentController.userId.value = widget.isProfile == true
          ? profileController.expertProfileModel.value.data?.sId ?? ''
          : widget.expertId ?? '';
      // Load only if list is empty
      if (contentController.contentList.isEmpty) {
        contentController.initialLoad();
      }

      // Pagination listener
      contentController.scrollController.addListener(() {
        final position = contentController.scrollController.position;
        if (position.pixels >= position.maxScrollExtent - 200 &&
            !contentController.isLoadingMore.value &&
            contentController.hasMore.value) {
          contentController.loadMore();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = Screen.screenHeight(context);
    final double width = Screen.screenWidth(context);
    final double scaleFactor = width / Screen.designWidth;

    return Obx(() {
      final content = contentController.contentList;

      // Initial loading shimmer
      if (contentController.inProgress.value) {
        return DiscoverShimmer();
      } else if (content.isEmpty) {
        return Column(
          children: [
            SizedBox(height: height * 0.15),
            Icon(
              Icons.travel_explore_outlined,
              size: scaleFactor * 50,
              color: AppColors.grey,
            ),
            NoData(text: 'No content found!'),
          ],
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height * 0.02),

          // Feed list
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: content.length,
            itemBuilder: (context, index) {
              return ContentContainer(
                isProfile: widget.isProfile,
                feedList: content[index],
                showcaseKey: index == 0
                    ? Get.find<ExpertDetailController>().postShareKey
                    : null,
              );
            },
          ),

          // Pagination loading
          if (contentController.isLoadingMore.value) CircleLoading(top: 0),

          // End of list
          if (!contentController.hasMore.value && content.isNotEmpty)
            NoData(text: 'No more content'),
        ],
      );
    });
  }
}
