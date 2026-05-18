import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SaveAsDefaultCheckbox extends StatelessWidget {
  const SaveAsDefaultCheckbox({super.key, required this.text, this.isSelected});
  final String text;
  final RxBool? isSelected;
  @override
  Widget build(BuildContext context) {
    final RxBool internalIsSelected = false.obs;
    final RxBool activeSelected = isSelected ?? internalIsSelected;
    final width = Screen.screenWidth(context);
    final scalefactor = width / Screen.designWidth;
    return GestureDetector(
      onTap: () {
        activeSelected.value = !activeSelected.value;
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(() {
            return Container(
              width: scalefactor * 18,
              height: scalefactor * 18,
              decoration: BoxDecoration(
                color: activeSelected.value ? AppColors.primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(scalefactor * 3),
                border: Border.all(color: AppColors.primaryColor, width: 2),
              ),

              child: activeSelected.value
                  ? Icon(
                      Icons.check,
                      color: Colors.white,
                      size: scalefactor * 14,
                    )
                  : null,
            );
          }),
          SizedBox(width: width * 0.03),
          Expanded(
            child: CustomText(
              text: text,
              color: AppColors.black,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              lineHeight: 1,
            ),
          ),
        ],
      ),
    );
  }
}
