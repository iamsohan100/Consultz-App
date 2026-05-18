import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';

class FilterPriceRangeSlider extends StatelessWidget {
  final RangeValues values;
  final Function(RangeValues) onChanged;
  final double min;
  final double max;

  const FilterPriceRangeSlider({
    super.key,
    required this.values,
    required this.onChanged,
    this.min = 10,
    this.max = 200,
  });

  @override
  Widget build(BuildContext context) {
    final height = Screen.screenHeight(context);
    final width = Screen.screenWidth(context);
    final scaleFactor = width / Screen.designWidth;

    return Padding(
      padding: EdgeInsets.all(scaleFactor * 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          CustomText(
            text: 'Price range',
            color: AppColors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(height: height * 0.005),
          CustomText(
            text: '£${values.start.toInt()} - £${values.end.toInt()}/hour',
            color: AppColors.darkGrey,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),

          SizedBox(height: height * 0.01),
          SliderTheme(
            data: SliderThemeData(
              rangeThumbShape: RoundRangeSliderThumbShape(
                enabledThumbRadius: scaleFactor * 9,
                elevation: 2,
              ),
              overlayShape: RoundSliderOverlayShape(
                overlayRadius: scaleFactor * 16,
              ),
              activeTrackColor: AppColors.primaryColor,
              inactiveTrackColor: AppColors.midGrey,
              thumbColor: AppColors.primaryColor,
              overlayColor: AppColors.primaryColor.withValues(alpha: 0.2),
              rangeTrackShape: RoundedRectRangeSliderTrackShape(),
              trackHeight: scaleFactor * 4,
            ),
            child: RangeSlider(
              values: values,
              min: min,
              max: max,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
