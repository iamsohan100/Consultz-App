import 'package:consultz/route/route_constant.dart';
import 'package:consultz/feature/Auth/model/interest_page_data.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/feature/Auth/widgets/interest_value_container.dart';
import 'package:consultz/core/utils/widgets/see_all.dart';
import 'package:consultz/feature/filter/controller/filter_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterLearningStyle extends StatelessWidget {
  const FilterLearningStyle({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final filterController = Get.find<FilterController>();

    return Column(
      spacing: height * 0.02,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: scaleFactor * 4,
            left: scaleFactor * 14,
            right: scaleFactor * 14,
          ),
          child: SeeAll(
            onTap: () {
              Get.toNamed(RoutesConstant.filterLearningStyleScreen);
            },
            title: 'Learning style',
            isFilter: true,
          ),
        ),

        SizedBox(
          height: height * 0.045,
          child: Obx(() {
            // Accessing the observable list length to ensure Obx works properly
            final _ = filterController.selectedLearningStyles.length;
            return ListView.builder(
              itemCount: InterestPageData.learningData.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                final style = InterestPageData.learningData[index];
                return InterestValueContainer(
                  isFilter: true,
                  index: index,
                  title: style,
                  isSelected:
                      filterController.selectedLearningStyles.contains(style),
                  onTap: () => filterController.toggleLearningStyle(style),
                );
              },
            );
          }),
        ),
      ],
    );
  }
}
