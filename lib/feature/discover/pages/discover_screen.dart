// ignore_for_file: deprecated_member_use

import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/feature/discover/controller/discover_controller.dart';
import 'package:consultz/feature/discover/widgets/discover_content.dart';
import 'package:consultz/feature/home/widgets/home_app_bar.dart';
import 'package:consultz/feature/main/controller/main_controller.dart';
import 'package:consultz/feature/post/widgets/posting_progress_widget.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/utils/share_preference/auth_preference.dart';
import 'package:consultz/feature/expert/controller/expert_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:showcaseview/showcaseview.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (AuthPreference.isDiscoverShowcaseShown == false) {
        _startShowcase();
      }
    });
  }

  void _startShowcase() async {
    final discoverController = Get.find<DiscoverController>();

    // Referral dialog বন্ধ হওয়া পর্যন্ত অপেক্ষা করবে
    if (AuthPreference.isReferralDialogShown == false) {
      while (AuthPreference.isReferralDialogShown == false && mounted) {
        await Future.delayed(const Duration(milliseconds: 500));
      }
    }

    // কনটেন্ট লোড হওয়া পর্যন্ত অপেক্ষা করবে
    for (int i = 0; i < 20; i++) {
      if (!discoverController.inProgress.value &&
          discoverController.contentList.isNotEmpty) {
        break;
      }
      await Future.delayed(const Duration(milliseconds: 500));
      if (!mounted) return;
    }

    // আরও সামান্য ওয়েট যাতে উইজেট ট্রি রেন্ডার হওয়ার সময় পায়
    await Future.delayed(const Duration(milliseconds: 500));

    if (mounted && discoverController.contentList.isNotEmpty) {
      ShowCaseWidget.of(context).startShowCase([
        Get.find<ExpertDetailController>().postShareKey,
      ]);
      AuthPreference().setDiscoverShowcaseShown();
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final discoverController = Get.find<DiscoverController>();

    return PopScope(
      canPop: false,
      onPopInvoked: (_) {
        Get.find<MainController>().changeIndex(index: 0);
      },
      child: Scaffold(
        appBar: homeAppBar(
          height,
          scaleFactor,
          context,
          width,
          'Discover',
          isFilter: false,
          onTap: () {
            Get.toNamed(RoutesConstant.searchContentScreen);
          },
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () => discoverController.initialLoad(),
            color: AppColors.primaryColor,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: discoverController.scrollController,
              child: Column(children: [
                const PostingProgressWidget(),
                DiscoverContent(),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
