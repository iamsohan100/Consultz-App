import 'dart:async';

import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/form_field/custom_form_field.dart';
import 'package:consultz/core/utils/loading.dart/circle_loading.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/feature/home/controller/search_expert_controller.dart';
import 'package:consultz/feature/home/widgets/no_result_found.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:consultz/core/utils/widgets/expert_container.dart';
import 'package:consultz/feature/expert/widgets/review_shimmer.dart';

class SearchExpertScreen extends StatefulWidget {
  const SearchExpertScreen({super.key});

  @override
  State<SearchExpertScreen> createState() => _SearchExpertScreenState();
}

class _SearchExpertScreenState extends State<SearchExpertScreen> {
  final searchExpertController = Get.find<SearchExpertController>();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchExpertController.initialLoad(term: '');

      searchExpertController.scrollController.addListener(() {
        final position = searchExpertController.scrollController.position;
        if (position.pixels >= position.maxScrollExtent - 200 &&
            !searchExpertController.isLoadingMore.value &&
            searchExpertController.hasMore.value) {
          searchExpertController.loadMore();
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
      appBar: customAppBar(context: context, title: 'Search'),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: scaleFactor * 14),
              child: CustomFormField(
                controller: searchExpertController.searchController,
                autofocus: true,
                hintText: 'Search experts...',
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: AppColors.darkGrey,
                  size: scaleFactor * 22,
                ),
                backgroundColor: Color(0xFFF5F5F5),
                onChange: (value) {
                  if (_debounce?.isActive ?? false) _debounce!.cancel();
                  _debounce = Timer(const Duration(milliseconds: 400), () {
                    searchExpertController.initialLoad(term: value);
                  });
                },
              ),
            ),
            SizedBox(height: height * 0.012),
            Divider(height: 0, thickness: 0.7),
            Expanded(
              child: Obx(() {
                if (searchExpertController.inProgress.value) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: scaleFactor * 16,
                        vertical: height * 0.02,
                      ),
                      child: ReviewShimmer(length: 5),
                    ),
                  );
                }

                final experts = searchExpertController.expertList;

                if (searchExpertController.searchTerm.value.trim().isEmpty) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(top: height * 0.05),
                      child: const Center(child: NoResultFound()),
                    ),
                  );
                }

                if (experts.isEmpty) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(top: height * 0.05),
                      child: const Center(child: NoResultFound()),
                    ),
                  );
                }

                return SingleChildScrollView(
                  controller: searchExpertController.scrollController,
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.02),
                      ListView.builder(
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
                      ),
                      if (searchExpertController.isLoadingMore.value)
                        CircleLoading(top: 0),
                      if (!searchExpertController.hasMore.value &&
                          experts.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: height * 0.02,
                          ),
                          child: Text(
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
