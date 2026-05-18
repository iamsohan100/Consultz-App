import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetttingSwitch extends StatelessWidget {
  const SetttingSwitch({
    super.key,
    required this.title,
    required this.isSelect,
    required this.onChanged,
  });
  final String title;
  final RxBool isSelect;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    // double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    // double scaleFactor = width / Screen.designWidth;
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: title,
            color: AppColors.black,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(
            width: width * 0.08,
            child: Transform.scale(
              scale: 0.6,
              child: Switch(
                padding: EdgeInsets.only(right: width * 0),
                activeThumbColor: AppColors.white,
                inactiveThumbColor: AppColors.white,
                activeTrackColor: AppColors.primaryColor,
                inactiveTrackColor: AppColors.grey,
                value: isSelect.value,
                onChanged: onChanged,

                trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((
                  Set<WidgetState> states,
                ) {
                  if (states.contains(WidgetState.selected)) {
                    return AppColors.primaryColor;
                  }
                  return AppColors.grey;
                }),
              ),
            ),
          ),
        ],
      );
    });
  }
}
