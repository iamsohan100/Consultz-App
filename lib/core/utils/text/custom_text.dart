import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final dynamic textAlign;
  final dynamic maxLine;
  final TextDecoration? textDecoration;
  final Color? textDecorationColor;
  final TextOverflow? textOverflow;
  final double? letterSpacing;
  final double? lineHeight;
  const CustomText({
    super.key,
    required this.text,
    required this.color,
    required this.fontSize,
    required this.fontWeight,
    this.textAlign,
    this.maxLine,
    this.textDecoration,
    this.textDecorationColor,
    this.textOverflow,
    this.letterSpacing, this.lineHeight,
  });

  @override
  Widget build(BuildContext context) {
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    return Text(
      text,
      maxLines: maxLine,
      
      overflow: textOverflow ?? TextOverflow.clip,
      textAlign: (textAlign == null) ? TextAlign.start : textAlign,
      style: GoogleFonts.figtree(
        decoration: textDecoration,
        decorationColor: textDecorationColor,
        decorationThickness: 2,
        fontSize: scaleFactor * fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing??0.4,
        height: lineHeight
      ),
    );
  }
}
