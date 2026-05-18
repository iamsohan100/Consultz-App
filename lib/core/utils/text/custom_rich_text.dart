import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomRichText extends StatelessWidget {
  final String text1;
  final String text2;
  final double fontSize1;
  final double fontSize2;
  final FontWeight fontWeight;
  final FontWeight? fontWeight2;
  final FontWeight? fontWeight3;
  final Color color1;
  final Color color2;
  final dynamic textAlign;
  final dynamic maxLine;
  final TextDecoration? textDecoration;
  final Color? textDecorationColor;
  final TextOverflow? textOverflow;
  final double? letterSpacing;
  final String? text3;
  const CustomRichText({
    super.key,
    required this.text1,
    required this.text2,
    required this.color1,
    required this.color2,
    required this.fontSize1,
    required this.fontSize2,
    required this.fontWeight,
    this.textAlign,
    this.maxLine,
    this.textDecoration,
    this.textDecorationColor,
    this.textOverflow,
    this.fontWeight2,
    this.letterSpacing,
    this.text3,
    this.fontWeight3,
  });

  @override
  Widget build(BuildContext context) {
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final TextAlign resolvedAlign = textAlign is TextAlign
        ? textAlign
        : TextAlign.start;
    final int? resolvedMaxLines = (maxLine is int) ? maxLine : null;
    final TextOverflow resolvedOverflow = textOverflow ?? TextOverflow.visible;

    return RichText(
      textAlign: resolvedAlign,
      maxLines: resolvedMaxLines,
      softWrap: true,
      overflow: resolvedOverflow,
      text: TextSpan(
        text: text1,
        style: GoogleFonts.figtree(
          fontSize: scaleFactor * fontSize1,
          fontWeight: fontWeight,
          color: color1,
          letterSpacing: letterSpacing,
          height: 1.5,
        ),
        children: [
          TextSpan(
            text: text2,
            style: GoogleFonts.figtree(
              fontSize: scaleFactor * fontSize2,
              fontWeight: fontWeight2 ?? fontWeight,
              color: color2,
              letterSpacing: letterSpacing,
              decoration: textDecoration,
              decorationColor: textDecorationColor,
              decorationThickness: 1.9,
            ),
          ),
          if (text3 != null)
            TextSpan(
              text: text3,
              style: GoogleFonts.figtree(
                fontSize: scaleFactor * fontSize2,
                fontWeight: fontWeight3 ?? fontWeight2 ?? fontWeight,
                color: color1,
                letterSpacing: letterSpacing,
              ),
            ),
        ],
      ),
    );
  }
}
