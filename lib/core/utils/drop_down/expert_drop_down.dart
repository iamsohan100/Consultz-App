import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/model/all_category_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpertDropDown extends StatelessWidget {
  const ExpertDropDown({
    super.key,
    required this.items,
    required this.title,
    required this.value,
    required this.onChange,
  });

  final List<AllCategoryData> items;
  final String title;
  final AllCategoryData value;
  final Function(AllCategoryData?) onChange;

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
          child: DropdownButton<AllCategoryData>(
            underline: const SizedBox(),
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
            items: items.map((item) {
              return DropdownMenuItem<AllCategoryData>(
                value: item,
                child: Text(item.title ?? ''),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
