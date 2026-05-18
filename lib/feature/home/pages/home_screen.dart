// ignore_for_file: deprecated_member_use

import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/feature/home/widgets/based_on_interested.dart';
import 'package:consultz/feature/home/widgets/home_app_bar.dart';
import 'package:consultz/feature/home/widgets/property_experts.dart';
import 'package:consultz/feature/home/widgets/top_experts.dart';
import 'package:consultz/feature/home/widgets/no_result_found.dart';
import 'package:consultz/feature/home/controller/interest_expert_controller.dart';
import 'package:consultz/feature/home/controller/property_expert_controller.dart';
import 'package:consultz/feature/home/controller/top_expert_controller.dart';
import 'package:consultz/core/utils/share_preference/auth_preference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:showcaseview/showcaseview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (AuthPreference.isHomeShowcaseShown == false) {
        _startShowcase();
      }
    });
  }

  void _startShowcase() async {
    final interestExpertController = Get.find<InterestExpertController>();

    // Referral dialog বন্ধ হওয়া পর্যন্ত অপেক্ষা করবে
    if (AuthPreference.isReferralDialogShown == false) {
      while (AuthPreference.isReferralDialogShown == false && mounted) {
        await Future.delayed(const Duration(milliseconds: 500));
      }
    }

    // কনটেন্ট লোড হওয়া পর্যন্ত অপেক্ষা করবে
    for (int i = 0; i < 20; i++) {
      if (!interestExpertController.inProgress.value &&
          interestExpertController.expertList.isNotEmpty) {
        break;
      }
      await Future.delayed(const Duration(milliseconds: 500));
      if (!mounted) return;
    }

    // আরও সামান্য ওয়েট যাতে উইজেট ট্রি রেন্ডার হওয়ার সময় পায়
    await Future.delayed(const Duration(milliseconds: 500));

    if (mounted && interestExpertController.expertList.isNotEmpty) {
      ShowCaseWidget.of(context).startShowCase([
        interestExpertController.bookNowShowcaseKey,
      ]);
      AuthPreference().setHomeShowcaseShown();
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    final interestExpertController = Get.find<InterestExpertController>();
    final propertyExpertController = Get.find<PropertyExpertController>();
    final topExpertController = Get.find<TopExpertController>();

    return Scaffold(
      appBar: homeAppBar(height, scaleFactor, context, width, 'For You'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(() {
            final bool isAllEmpty = interestExpertController.expertList.isEmpty &&
                propertyExpertController.expertList.isEmpty &&
                topExpertController.expertList.isEmpty;
                
            final bool isAllFinished = !interestExpertController.inProgress.value &&
                !propertyExpertController.inProgress.value &&
                !topExpertController.inProgress.value;

            if (isAllEmpty && isAllFinished) {
              return SizedBox(
                height: height * 0.7,
                child: const Center(
                  child: NoResultFound(),
                ),
              );
            }

            return Column(
              children: [
                BasedOnInterested(),
                PropertyExperts(),
                TopExperts(),
                SizedBox(height: height * 0.02),
              ],
            );
          }),
        ),
      ),
    );
  }
}

