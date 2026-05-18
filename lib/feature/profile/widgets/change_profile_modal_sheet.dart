import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/feature/profile/widgets/change_profile_option.dart';
import 'package:flutter/material.dart';

Future<void> changeProfileModalSheet(BuildContext context) {
  final width = Screen.screenWidth(context);
  final height = Screen.screenHeight(context);
  final scalefactor = width / Screen.designWidth;
  return showModalBottomSheet(
    context: (context),
    enableDrag: true,
    showDragHandle: true,
    backgroundColor: Colors.white,
    isScrollControlled: true,
    constraints: BoxConstraints(
      minHeight: height * 0.24,
      maxHeight: height * 0.9,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(scalefactor * 20),
      ),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: ChangeProfileOption(),
      );
    },
  );
}
