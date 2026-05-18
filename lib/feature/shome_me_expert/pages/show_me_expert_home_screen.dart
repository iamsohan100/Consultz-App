import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/feature/home/widgets/home_app_bar.dart';
import 'package:consultz/feature/home/widgets/no_result_found.dart';
import 'package:consultz/feature/shome_me_expert/controller/show_me_expert_interest_controller.dart';
import 'package:consultz/feature/shome_me_expert/controller/show_me_expert_property_controller.dart';
import 'package:consultz/feature/shome_me_expert/controller/show_me_expert_top_controller.dart';
import 'package:consultz/feature/shome_me_expert/widgets/show_me_expert_based_on_interested.dart';
import 'package:consultz/feature/shome_me_expert/widgets/show_me_expert_property.dart';
import 'package:consultz/feature/shome_me_expert/widgets/show_me_expert_top.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowMeExpertHomeScreen extends StatelessWidget {
  const ShowMeExpertHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    final interestExpertController = Get.find<ShowMeExpertInterestController>();
    final propertyExpertController = Get.find<ShowMeExpertPropertyController>();
    final topExpertController = Get.find<ShowMeExpertTopController>();

    return Scaffold(
      appBar: homeAppBar(
        height,
        scaleFactor,
        context,
        width,
        'For You',
        isShowMeExpert: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(() {
            final bool isAllEmpty =
                interestExpertController.expertList.isEmpty &&
                propertyExpertController.expertList.isEmpty &&
                topExpertController.expertList.isEmpty;

            final bool isAllFinished =
                !interestExpertController.inProgress.value &&
                !propertyExpertController.inProgress.value &&
                !topExpertController.inProgress.value;

            if (isAllEmpty && isAllFinished) {
              return SizedBox(
                height: height * 0.7,
                child: const Center(child: NoResultFound()),
              );
            }

            return Column(
              children: [
                ShowMeExpertBasedOnInterested(),
                ShowMeExpertProperty(),
                ShowMeExpertTop(),
                SizedBox(height: height * 0.02),
              ],
            );
          }),
        ),
      ),
    );
  }
}
