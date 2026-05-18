import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/widgets/content_container.dart';
import 'package:consultz/core/utils/widgets/no_data.dart';
import 'package:consultz/feature/discover/model/content_model.dart';
import 'package:consultz/feature/discover/widgets/discover_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedDetailScreen extends StatefulWidget {
  const FeedDetailScreen({super.key});

  @override
  State<FeedDetailScreen> createState() => _FeedDetailScreenState();
}

class _FeedDetailScreenState extends State<FeedDetailScreen> {
  FeedList? _feedList;
  RxBool isLoading = false.obs;

  @override
  void initState() {
    super.initState();
    if (Get.arguments is FeedList) {
      _feedList = Get.arguments as FeedList;
    } else if (Get.arguments is String) {
      _fetchFeed(Get.arguments as String);
    }
  }

  Future<void> _fetchFeed(String id) async {
    setState(() {
      isLoading.value = true;
    });
    try {
      final response = await ApiCaller.getRequest(url: ApiUrls.getFeed(id));
      if (response?.statusCode == 200 && response?.isSuccess == true) {
        setState(() {
          _feedList = FeedList.fromJson(response?.responseData['data']);
        });
      }
    } catch (e) {
      debugPrint('Error fetching feed: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    return Scaffold(
      appBar: customAppBar(context: context, title: 'Discover'),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(() {
            if (isLoading.value) {
              return DiscoverShimmer();
            } else if (_feedList == null) {
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
            return ContentContainer(feedList: _feedList, isDiscover: true);
          }),
        ),
      ),
    );
  }
}
