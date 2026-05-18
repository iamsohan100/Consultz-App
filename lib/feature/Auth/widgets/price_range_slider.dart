import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/form_field/custom_form_field.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:consultz/core/utils/responsive/screen.dart';

class PriceRangeSlider extends StatelessWidget {
  final RangeValues values;
  final Function(RangeValues) onChanged;
  final double min;
  final double max;

  const PriceRangeSlider({
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
    final padding = scaleFactor * 20;
    final availableWidth = width - (padding * 2);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: Column(
            children: [
              SizedBox(height: scaleFactor * 24),
              SizedBox(
                height: height * 0.065,
                width: availableWidth,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      left:
                          ((values.start - min) / (max - min)) *
                              availableWidth -
                          (scaleFactor * 20),
                      top: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: scaleFactor * 8,
                          vertical: scaleFactor * 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.midGrey,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(scaleFactor * 4),
                            topRight: Radius.circular(scaleFactor * 4),
                            bottomLeft: Radius.circular(scaleFactor * 4),
                          ),
                        ),
                        child: CustomText(
                          text: '£${values.start.toInt()}',

                          color: AppColors.darkGrey,
                          fontSize: scaleFactor * 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Positioned(
                      right:
                          (1 - ((values.end - min) / (max - min))) *
                              availableWidth -
                          (scaleFactor * 20),
                      top: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: scaleFactor * 8,
                          vertical: scaleFactor * 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.midGrey,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(scaleFactor * 4),
                            topRight: Radius.circular(scaleFactor * 4),
                            bottomRight: Radius.circular(scaleFactor * 4),
                          ),
                        ),
                        child: CustomText(
                          text: '£${values.end.toInt()}',
                          color: AppColors.darkGrey,
                          fontSize: scaleFactor * 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: SliderTheme(
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
                          overlayColor: AppColors.primaryColor.withValues(
                            alpha: 0.2,
                          ),
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
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.014),
            ],
          ),
        ),
        SizedBox(height: height * 0.01),

        CustomFormField(
          title: 'Price range selected',
          controller: TextEditingController(
            text: '£${values.start.toInt()} - £${values.end.toInt()} ',
          ),
        ),
      ],
    );
  }
}
