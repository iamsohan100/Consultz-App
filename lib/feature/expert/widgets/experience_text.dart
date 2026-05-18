import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';

class ExperienceText extends StatelessWidget {
  const ExperienceText({super.key, required this.title, required this.data});
  final String title;
  final List<String> data;

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    return Row(
      children: [
        CustomText(
          text: title,
          color: AppColors.black,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(width: width * 0.093),
        Expanded(
          child: Wrap(
            alignment: .end,

            runSpacing: scaleFactor * 6,
            spacing: scaleFactor * 6,
            children: [
              for (int i = 0; i < data.length; i++)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.03,
                    vertical: height * 0.006,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFF8F9FC),
                    borderRadius: BorderRadius.circular(scaleFactor * 16),
                  ),
                  child: CustomText(
                    text: data[i],
                    color: Color(0xFF363F72),
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
