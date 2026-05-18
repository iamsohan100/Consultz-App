// import 'package:consultz/feature/expert/model/content_data.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/loading.dart/circle_loading.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/widgets/content_container.dart';
import 'package:consultz/core/utils/widgets/no_data.dart';
import 'package:consultz/feature/discover/controller/discover_controller.dart';
import 'package:consultz/feature/discover/widgets/discover_shimmer.dart';
import 'package:consultz/feature/expert/controller/expert_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiscoverContent extends StatefulWidget {
  const DiscoverContent({super.key});

  @override
  State<DiscoverContent> createState() => _DiscoverContentState();
}

class _DiscoverContentState extends State<DiscoverContent> {
  final discoverController = Get.find<DiscoverController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Pagination listener
      discoverController.scrollController.addListener(() {
        final position = discoverController.scrollController.position;
        if (position.pixels >= position.maxScrollExtent - 200 &&
            !discoverController.isLoadingMore.value &&
            discoverController.hasMore.value) {
          discoverController.loadMore();
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
      final content = discoverController.contentList;

      // Initial loading shimmer
      if (discoverController.inProgress.value) {
        return DiscoverShimmer();
      } else if (content.isEmpty) {
        return Column(
          children: [
            SizedBox(height: height * 0.23),
            Icon(
              Icons.travel_explore_outlined,
              size: scaleFactor * 60,
              color: AppColors.grey,
            ),
            NoData(text: 'Nothing to discover yet!'),
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
                feedList: content[index],
                isDiscover: true,
                showcaseKey: index == 0
                    ? Get.find<ExpertDetailController>().postShareKey
                    : null,
              );
            },
          ),

          // Pagination loading
          if (discoverController.isLoadingMore.value) CircleLoading(top: 0),

          // End of list
          if (!discoverController.hasMore.value && content.isNotEmpty)
            NoData(text: 'No more content'),
        ],
      );
    });
  }
}
