import 'package:consultz/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

dynamic mainLoading(BuildContext context, {String? loadingText}) {
  // double height = Screen.screenHeight(context);
  // double width = Screen.screenWidth(context);
  // double scaleFactor = width / Screen.designWidth;
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return PopScope(
        canPop: false,
        child: Center(
          child: Container(
            height: 80,
            width: 100,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SpinKitChasingDots(color: AppColors.white, size: 35),
                SizedBox(height: 6),
                if (loadingText != null)
                  Text(
                    loadingText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.figtree(
                      decoration: .none,
                      decorationColor: Colors.transparent,
                      decorationThickness: 2,
                      fontSize: 12,
                      fontWeight: .w600,
                      color: AppColors.white,
                      letterSpacing: 0.4,
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
