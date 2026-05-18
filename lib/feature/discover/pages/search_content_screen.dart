import 'dart:async';

import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/form_field/custom_form_field.dart';
import 'package:consultz/core/utils/loading.dart/circle_loading.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/widgets/content_container.dart';
import 'package:consultz/core/utils/widgets/no_data.dart';
import 'package:consultz/feature/discover/controller/discover_controller.dart';
import 'package:consultz/feature/discover/widgets/discover_shimmer.dart';
import 'package:consultz/feature/home/widgets/no_result_found.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchContentScreen extends StatefulWidget {
  const SearchContentScreen({super.key});

  @override
  State<SearchContentScreen> createState() => _SearchContentScreenState();
}

class _SearchContentScreenState extends State<SearchContentScreen> {
  final discoverController = Get.find<DiscoverController>();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      discoverController.searchInitialLoad(term: '');

      discoverController.searchScrollController.addListener(() {
        final position = discoverController.searchScrollController.position;
        if (position.pixels >= position.maxScrollExtent - 200 &&
            !discoverController.isSearchLoadingMore.value &&
            discoverController.searchHasMore.value) {
          discoverController.searchLoadMore();
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
                controller: discoverController.searchController,
                autofocus: true,
                hintText: 'Search Experts...',
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: AppColors.darkGrey,
                  size: scaleFactor * 22,
                ),
                backgroundColor: Color(0xFFF5F5F5),
                onChange: (value) {
                  if (_debounce?.isActive ?? false) _debounce!.cancel();
                  _debounce = Timer(const Duration(milliseconds: 400), () {
                    discoverController.searchInitialLoad(term: value);
                  });
                },
              ),
            ),
            SizedBox(height: height * 0.012),
            Divider(height: 0, thickness: 0.7),
            Expanded(
              child: Obx(() {
                if (discoverController.searchInProgress.value) {
                  return DiscoverShimmer();
                }

                final content = discoverController.searchContentList;

                if (discoverController.searchTerm.value.trim().isEmpty) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(top: height * 0.05),
                      child: const Center(child: NoResultFound()),
                    ),
                  );
                }

                if (content.isEmpty) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(top: height * 0.05),
                      child: const Center(child: NoResultFound()),
                    ),
                  );
                }

                return SingleChildScrollView(
                  controller: discoverController.searchScrollController,
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.02),
                      ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: content.length,
                        itemBuilder: (context, index) {
                          return ContentContainer(
                            feedList: content[index],
                            isDiscover: true,
                          );
                        },
                      ),
                      if (discoverController.isSearchLoadingMore.value)
                        CircleLoading(top: 0),
                      if (!discoverController.searchHasMore.value &&
                          content.isNotEmpty)
                        NoData(text: 'No more content'),
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
