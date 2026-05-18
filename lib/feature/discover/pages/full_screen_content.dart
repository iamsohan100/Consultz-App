import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/image/display_network_image.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/widgets/video_place_holder.dart';
import 'package:consultz/feature/discover/model/content_model.dart';
import 'package:consultz/feature/discover/model/media_helper.dart';
import 'package:consultz/feature/discover/widgets/full_screen_profile.dart';
import 'package:consultz/feature/discover/widgets/image_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FullScreenContent extends StatefulWidget {
  const FullScreenContent({super.key});

  @override
  State<FullScreenContent> createState() => _FullScreenContentState();
}

class _FullScreenContentState extends State<FullScreenContent> {
  FeedList? _feedList;
  bool _isLoading = false;

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
      _isLoading = true;
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
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    if (_feedList == null) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: Text("Feed not found", style: TextStyle(color: Colors.white))),
      );
    }

    final List<String> content = _feedList!.content ?? [];
    final double height = Screen.screenHeight(context);
    final double width = Screen.screenWidth(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FullScreenProfile(feedList: _feedList!),
              if (content.isNotEmpty) SizedBox(height: height * 0.015),
              if (content.length == 1)
                MediaHelper.isVideo(content.first)
                    ? VideoPlaceholder(url: content.first)
                    : InteractiveViewer(
                        child: DisplayNetworkImage(
                          imageUrl: content.first,
                          imageWidth: width,
                          imageHeight: height * 0.7,
                          radius: 0,
                        ),
                      ),
              if (content.length > 1) ImageSlider(content: content),
              SizedBox(height: height * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
