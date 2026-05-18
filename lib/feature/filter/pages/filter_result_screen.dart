import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/loading.dart/circle_loading.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/filter/controller/filter_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:consultz/core/utils/widgets/expert_container.dart';
import 'package:consultz/feature/expert/widgets/review_shimmer.dart';

class FilterResultScreen extends StatefulWidget {
  const FilterResultScreen({super.key});

  @override
  State<FilterResultScreen> createState() => _FilterResultScreenState();
}

class _FilterResultScreenState extends State<FilterResultScreen> {
  final filterController = Get.find<FilterController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      filterController.scrollController.addListener(() {
        final position = filterController.scrollController.position;
        if (position.pixels >= position.maxScrollExtent - 200 &&
            !filterController.isLoadingMore.value &&
            filterController.hasMore.value) {
          filterController.loadMore();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    return Scaffold(
      appBar: customAppBar(context: context, title: 'Filtered Experts'),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (filterController.inProgress.value) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: scaleFactor * 16,
                        vertical: height * 0.02,
                      ),
                      child: const ReviewShimmer(length: 5),
                    ),
                  );
                }

                final experts = filterController.expertList;

                if (experts.isEmpty) {
                  return SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          Image.asset(AppImages.noResult),
                          CustomText(
                            text: 'No results',
                            color: AppColors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(height: height * 0.01),
                          CustomText(
                            text:
                                'We couldn’t find what you’re\nlooking for, try another filter',
                            color: AppColors.darkGrey,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return SingleChildScrollView(
                  controller: filterController.scrollController,
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.02),
                      ListView.separated(
                        padding: EdgeInsets.symmetric(
                          horizontal: scaleFactor * 16,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: experts.length,
                        itemBuilder: (context, index) {
                          return ExpertContainer(
                            index: index,
                            expertData: experts[index],
                            isSpecific: true,
                          );
                        },
                        separatorBuilder: (_, _) =>
                            SizedBox(height: height * 0.018),
                      ),
                      if (filterController.isLoadingMore.value)
                        const CircleLoading(top: 0),
                      if (!filterController.hasMore.value && experts.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: height * 0.02,
                          ),
                          child: const Text(
                            'No more experts',
                            style: TextStyle(color: AppColors.darkGrey),
                          ),
                        ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
