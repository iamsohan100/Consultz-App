import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/feature/filter/widgets/filter_app_bar.dart';
import 'package:consultz/feature/filter/widgets/filter_availibility.dart';
import 'package:consultz/feature/filter/widgets/filter_experts_rating.dart';
import 'package:consultz/feature/filter/widgets/filter_interests.dart';
import 'package:consultz/feature/filter/widgets/filter_learning_style.dart';
import 'package:consultz/feature/filter/widgets/filter_price_range_slider.dart';
import 'package:consultz/feature/filter/widgets/filter_save_button.dart';
import 'package:consultz/feature/filter/widgets/session_duration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:consultz/feature/filter/controller/filter_controller.dart';
import 'package:consultz/feature/filter/pages/filter_result_screen.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final filterController = Get.find<FilterController>();

    return Scaffold(
      appBar: filterAppBar(height, scaleFactor, context, width, onClear: () {
        filterController.resetFilters();
      }),
      bottomNavigationBar: FilterSaveButton(
        onTap: () {
          filterController.initialLoad();
          Get.to(() => const FilterResultScreen());
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FilterPriceRangeSlider(
                  values: filterController.priceRange.value,
                  onChanged: (RangeValues values) {
                    filterController.priceRange.value = values;
                  },
                ),
                FilterInterests(),
                SizedBox(height: height * 0.022),
                FilterLearningStyle(),
                SizedBox(height: height * 0.022),
                FilterAvailibility(),
                SizedBox(height: height * 0.022),
                FilterExpertsRating(),
                SizedBox(height: height * 0.022),
                SessionDuration(),
                SizedBox(height: height * 0.03),
              ],
            );
          }),
        ),
      ),
    );
  }
}
