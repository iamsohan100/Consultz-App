import 'package:consultz/core/utils/loading.dart/shimmer_loading.dart';
import 'package:consultz/feature/Auth/controller/set_key_expertise_controller.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/feature/Auth/widgets/interest_value_container.dart';
import 'package:consultz/core/utils/widgets/see_all.dart';
import 'package:consultz/feature/filter/controller/filter_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterInterests extends StatelessWidget {
  const FilterInterests({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final filterController = Get.find<FilterController>();
    final setKeyExpertiseController = Get.find<SetKeyExpertiseController>();
    return Obx(() {
      // This ensures Obx tracks changes to selectedInterests even though it's used inside itemBuilder
      final _ = filterController.selectedInterests.length;
      final categories = setKeyExpertiseController.allCategoryList;
      if (setKeyExpertiseController.inProgress.value) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: scaleFactor * 14),
          child: ShimmerLoading(width: width, height: height * 0.045),
        );
      } else if (categories.isEmpty) {
        return SizedBox.shrink();
      }
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
                Get.toNamed(RoutesConstant.filterInterestsScreen);
              },
              title: 'Interests',
              isFilter: true,
            ),
          ),

          SizedBox(
            height: height * 0.045,
            child: ListView.builder(
              itemCount: categories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                final interest = categories[index].title;
                return InterestValueContainer(
                  isFilter: true,
                  index: index,
                  title: interest ?? '',
                  isSelected: filterController.selectedInterests.contains(
                    interest ?? '',
                  ),
                  onTap: () => filterController.toggleInterest(interest ?? ''),
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
