import 'package:consultz/core/utils/loading.dart/circle_loading.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/widgets/expert_container.dart';
import 'package:consultz/core/utils/widgets/no_data.dart';
import 'package:consultz/feature/home/controller/interest_expert_controller.dart';
import 'package:consultz/feature/home/controller/property_expert_controller.dart';
import 'package:consultz/feature/home/controller/top_expert_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpecificExpertScreen extends StatefulWidget {
  const SpecificExpertScreen({super.key});

  @override
  State<SpecificExpertScreen> createState() => _SpecificExpertScreenState();
}

class _SpecificExpertScreenState extends State<SpecificExpertScreen> {
  final args = Get.arguments as String;

  final interestExpertController = Get.find<InterestExpertController>();
  final propertyExpertController = Get.find<PropertyExpertController>();
  final topExpertController = Get.find<TopExpertController>();

  @override
  void initState() {
    super.initState();
    if (args == 'Based on your interests') {
      interestExpertController.scrollController.addListener(() {
        final position = interestExpertController.scrollController.position;
        if (position.pixels >= position.maxScrollExtent - 200 &&
            !interestExpertController.isLoadingMore.value &&
            interestExpertController.hasMore.value) {
          interestExpertController.loadMore();
        }
      });
    } else if (args == 'Property experts') {
      propertyExpertController.scrollController.addListener(() {
        final position = propertyExpertController.scrollController.position;
        if (position.pixels >= position.maxScrollExtent - 200 &&
            !propertyExpertController.isLoadingMore.value &&
            propertyExpertController.hasMore.value) {
          propertyExpertController.loadMore();
        }
      });
    } else if (args == 'Top experts') {
      topExpertController.scrollController.addListener(() {
        final position = topExpertController.scrollController.position;
        if (position.pixels >= position.maxScrollExtent - 200 &&
            !topExpertController.isLoadingMore.value &&
            topExpertController.hasMore.value) {
          topExpertController.loadMore();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    return Scaffold(
      appBar: customAppBar(context: context, title: args, isLine: true),

      body: SafeArea(
        child: Obx(() {
          final content = args == 'Based on your interests'
              ? interestExpertController.expertList
              : args == 'Property experts'
              ? propertyExpertController.expertList
              : args == 'Top experts'
              ? topExpertController.expertList
              : [];

          return SingleChildScrollView(
            controller: args == 'Based on your interests'
                ? interestExpertController.scrollController
                : args == 'Property experts'
                ? propertyExpertController.scrollController
                : args == 'Top experts'
                ? topExpertController.scrollController
                : null,
            child: Padding(
              padding: EdgeInsetsGeometry.all(scaleFactor * 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListView.separated(
                    primary: false,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: content.length,
                    itemBuilder: (_, index) {
                      return ExpertContainer(
                        index: index,
                        expertData: content[index],
                        isSpecific: true,
                      );
                    },
                    separatorBuilder: (_, _) {
                      return SizedBox(height: height * 0.025);
                    },
                  ),
                  // Pagination loading
                  if (interestExpertController.isLoadingMore.value ||
                      propertyExpertController.isLoadingMore.value ||
                      topExpertController.isLoadingMore.value) ...[
                    SizedBox(height: height * 0.02),
                    CircleLoading(top: 0),
                  ],

                  // End of list
                  if ((!interestExpertController.hasMore.value ||
                          !propertyExpertController.hasMore.value ||
                          !topExpertController.hasMore.value) &&
                      content.isNotEmpty)
                    NoData(text: 'No more content'),
                  SizedBox(height: height * 0.02),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
