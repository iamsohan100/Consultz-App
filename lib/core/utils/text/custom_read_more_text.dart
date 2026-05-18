import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

class CustomReadMoreText extends StatelessWidget {
  const CustomReadMoreText({
    super.key,
    required this.text,

    required this.fontSize,
    required this.fontWeight,
    required this.color,
    this.letterSpacing,
    this.lineHeight,
    this.moreColor,
    this.trimLine,
  });
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final double? letterSpacing;
  final double? lineHeight;
  final Color? moreColor;
  final int? trimLine;
  @override
  Widget build(BuildContext context) {
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    return ReadMoreText(
      text,
      trimLines: trimLine ?? 3,
      style: GoogleFonts.figtree(
        fontSize: scaleFactor * fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing ?? 0.4,
        height: lineHeight,
      ),
      trimMode: TrimMode.Line,
      trimCollapsedText: 'more',
      trimExpandedText: '  less',
      moreStyle: GoogleFonts.figtree(
        fontSize: scaleFactor * 14,
        fontWeight: FontWeight.w400,
        color: moreColor ?? AppColors.primaryColor,
        letterSpacing: letterSpacing ?? 0.4,
      ),
      lessStyle: GoogleFonts.figtree(
        fontSize: scaleFactor * 14,
        fontWeight: FontWeight.w400,
        color: moreColor ?? AppColors.primaryColor,
        letterSpacing: letterSpacing ?? 0.4,
      ),
    );
  }
}
