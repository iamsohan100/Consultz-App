import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    super.key,
    required this.items,
    required this.title,
    required this.value,
    required this.onChange,
  });

  final List<String> items;
  final String title;
  final String value;
  final Function(String?) onChange;

  @override
  Widget build(BuildContext context) {
    final width = Screen.screenWidth(context);
    final scaleFactor = width / Screen.designWidth;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          color: AppColors.black,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: width * 0.02),
        Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.03),
          width: width,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(scaleFactor * 14),
            border: Border.all(color: AppColors.midGrey, width: 1),
          ),
          child: DropdownButton<String>(
            underline: SizedBox(),
            dropdownColor: AppColors.white,
            borderRadius: BorderRadius.circular(scaleFactor * 10),
            isExpanded: true,
            value: value,
            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
              size: scaleFactor * 26,
              color: AppColors.darkGrey,
            ),
            style: GoogleFonts.figtree(
              fontSize: scaleFactor * 14,
              color: AppColors.black,
              fontWeight: FontWeight.w400,
            ),
            onChanged: onChange,
            items: items.map((String item) {
              return DropdownMenuItem<String>(value: item, child: Text(item));
            }).toList(),
          ),
        ),
      ],
    );
  }
}
