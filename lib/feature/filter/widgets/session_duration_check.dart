import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';

class SessionDurationCheck extends StatelessWidget {
  const SessionDurationCheck({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final width = Screen.screenWidth(context);
    final scalefactor = width / Screen.designWidth;
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          CustomText(
            text: title,
            color: AppColors.black,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          const Spacer(),
          Container(
            width: scalefactor * 18,
            height: scalefactor * 18,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primaryColor : Colors.white,
              borderRadius: BorderRadius.circular(scalefactor * 3),
              border: Border.all(color: AppColors.primaryColor, width: 2),
            ),
            child: isSelected
                ? Icon(
                    Icons.check,
                    color: Colors.white,
                    size: scalefactor * 14,
                  )
                : null,
          ),
          SizedBox(width: width * 0.02),
        ],
      ),
    );
  }
}
