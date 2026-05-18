import 'package:consultz/feature/home/controller/property_expert_controller.dart';
import 'package:consultz/feature/home/widgets/home_shimmer.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/widgets/expert_container.dart';
import 'package:consultz/core/utils/widgets/see_all.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PropertyExperts extends StatelessWidget {
  const PropertyExperts({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final propertyExpertController = Get.find<PropertyExpertController>();

    return Obx(() {
      final expertList = propertyExpertController.expertList;
      if (propertyExpertController.inProgress.value) {
        return HomeShimmer();
      }else if (expertList.isEmpty) {
        return SizedBox();
      }
      return Column(
        spacing: height * 0.02,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: scaleFactor * 18,
              left: scaleFactor * 14,
              right: scaleFactor * 14,
            ),
            child: SeeAll(
              onTap: () {
                Get.toNamed(
                  RoutesConstant.specificExpertScreen,
                  arguments: 'Property experts',
                );
              },
              title: 'Property experts',
            ),
          ),
          SizedBox(
            height: height * 0.361,
            child: ListView.builder(
              itemCount: expertList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return ExpertContainer(
                  index: index,
                  expertData: expertList[index],
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
