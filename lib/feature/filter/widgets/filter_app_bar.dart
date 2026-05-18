  import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';

AppBar filterAppBar(double height, double scaleFactor, BuildContext context, double width, {VoidCallback? onClear}) {
    return customAppBar(
      title: 'Filter',

      context: context,
      actions: [
        GestureDetector(
          onTap: onClear,
          child: CustomText(
            text: 'Clear',
            color: AppColors.primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: width * 0.06),
      ],
    );
  }
