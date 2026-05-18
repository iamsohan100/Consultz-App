import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/feature/bookings/widgets/discussion_modal_container.dart';
import 'package:flutter/material.dart';

Future<void> discussionDetailsModalSheet(
  BuildContext context, {
  required String? bookingId,
  required String? expertId,
  required String firstName,
  required String lastName,
  required String formatedDate,
  required String timeRange,
   bool? isDetailScreen,
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
      minHeight: height * 0.24,
      maxHeight: height * 0.9,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(scalefactor * 20),
      ),
    ),
    builder: (context) {
      return DiscussionModalContainer(
        bookingId: bookingId,
        expertId: expertId,
        firstName: firstName,
        lastName: lastName,
        formatedDate: formatedDate,
        timeRange: timeRange, isDetailScreen: isDetailScreen,
      );
    },
  );
}
