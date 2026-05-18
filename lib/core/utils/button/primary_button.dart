import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? title;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final double? buttonWidth;
  final double? buttonHeight;
  final double? fontSize;
  final double? padding;
  final double? radius;
  final bool? isShadow;
  final Color? shadowColor;
  final FontWeight? fontWeight;
  const PrimaryButton({
    super.key,
    this.onPressed,
    this.title,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.buttonWidth,
    this.buttonHeight,
    this.fontSize,
    this.padding,
    this.radius,
    this.icon,
    this.isShadow,
    this.shadowColor,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    // double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: buttonWidth ?? width,
        height: buttonHeight ?? 48,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: width * (padding ?? 0)),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.primaryColor,
          borderRadius: BorderRadius.circular(scaleFactor * (radius ?? 16)),
          border: borderColor != null
              ? Border.all(color: borderColor!, width: 1)
              : null,
          boxShadow: isShadow == true
              ? [
                  BoxShadow(
                    color: shadowColor ?? Colors.grey,
                    blurRadius: 15,
                    spreadRadius: 0.1,
                    offset: Offset(0, 0),
                  ),
                ]
              : null,
        ),

        child: icon != null
            ? Row(
                spacing: width * 0.02,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon!,
                  if (title != null)
                    Text(
                      title!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.figtree(
                        fontSize: scaleFactor * (fontSize ?? 14),
                        fontWeight: fontWeight ?? FontWeight.w700,
                        color: textColor ?? AppColors.white,
                        letterSpacing: 0.4,
                      ),
                    ),
                ],
              )
            : Text(
                title!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: GoogleFonts.figtree(
                  fontSize: scaleFactor * (fontSize ?? 14),
                  fontWeight: fontWeight ?? FontWeight.w700,
                  color: textColor ?? AppColors.white,
                  letterSpacing: 0.4,
                ),
              ),
      ),
    );
  }
}
