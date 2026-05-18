import 'package:consultz/feature/Auth/widgets/time_picker.dart';
import 'package:flutter/material.dart';

// dayName is forwarded to TimePicker so the slot is saved to the correct day
void timePickerModalSheet(BuildContext context, String dayName) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    enableDrag: true,
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => TimePicker(dayName: dayName),
  );
}