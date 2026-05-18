import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/feature/discover/model/content_model.dart';
import 'package:consultz/feature/expert/widgets/view_my_profile.dart';
import 'package:flutter/material.dart';

Future<void> viewMyProfileModalSheet({
  required BuildContext context,
  required bool? isProfile,
  required bool? isDiscover,
  required FeedList? feedList,
}) {
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
      minHeight: height * 0.25,
      maxHeight: height * 0.9,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(scalefactor * 20),
      ),
    ),
    builder: (context) {
      return ViewMyProfile(
        feedList: feedList,
      );
    },
  );
}
