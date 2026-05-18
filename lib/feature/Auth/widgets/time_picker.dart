import 'dart:developer';

import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/expert/controller/calendar_controller.dart';
import 'package:consultz/feature/expert/model/available_time_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TimePicker extends StatefulWidget {
  // dayName passed so we add the slot to the correct day list
  final String dayName;
  const TimePicker({super.key, required this.dayName});

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  int startHour = 1;
  int startMinute = 0;
  int endHour = 5;
  int endMinute = 0;

  bool isStartAM = true;
  bool isEndAM = false;
  bool isStart = true;

  final calendarController = Get.find<CalendarController>();

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // AM / PM toggle
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              amPmButton("AM", true),
              SizedBox(width: width * 0.03),
              amPmButton("PM", false),
            ],
          ),

          SizedBox(height: height * 0.01),

          // Start / End toggle
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: width * 0.02),
              startEndButton("Start", true),
              SizedBox(width: width * 0.04),
              startEndButton("End", false),
            ],
          ),

          SizedBox(height: height * 0.01),

          // ── Time Wheel ────────────────────────────────────────────────────
          if (isStart)
            setTime(
              context: context,
              onChangeHour: (i) {
                setState(() => startHour = i + 1);
                log("startHour: $startHour");
              },
              onChangeMinute: (i) {
                setState(() => startMinute = i * 15);
                log("startMinute: $startMinute");
              },
            ),

          if (!isStart)
            setTime(
              context: context,
              onChangeHour: (i) {
                setState(() => endHour = i + 1);
                log("endHour: $endHour");
              },
              onChangeMinute: (i) {
                setState(() => endMinute = i * 15);
                log("endMinute: $endMinute");
              },
            ),

          SizedBox(height: height * 0.022),

          // ── Confirm Button ────────────────────────────────────────────────
          PrimaryButton(
            onPressed: () {
              int to24(int h, bool am) {
                if (am) {
                  return (h == 12) ? 0 : h;
                } else {
                  return (h == 12) ? 12 : h + 12;
                }
              }

              final h24Start = to24(startHour, isStartAM);
              final h24End = to24(endHour, isEndAM);

              // Add slot to the correct day list
              calendarController.getDayList(widget.dayName).add(
                    AvailableTimeModel(
                      startTime:
                          '${h24Start.toString().padLeft(2, '0')}:${startMinute.toString().padLeft(2, '0')}',
                      endTime:
                          '${h24End.toString().padLeft(2, '0')}:${endMinute.toString().padLeft(2, '0')}',
                    ),
                  );

              log('Added slot to ${widget.dayName}: $h24Start:$startMinute - $h24End:$endMinute');
              Navigator.pop(context);
            },
            title: 'Confirm Slot',
          ),

          SizedBox(height: height * 0.04),
        ],
      ),
    );
  }

  // ── Wheel Builder ─────────────────────────────────────────────────────────

  SizedBox setTime({
    required BuildContext context,
    required Function(int) onChangeHour,
    required Function(int) onChangeMinute,
  }) {
    double height = Screen.screenHeight(context);
    double width  = Screen.screenWidth(context);

    return SizedBox(
      height: height * 0.3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: width * 0.2,
            child: CupertinoPicker(
              itemExtent: 50,
              looping: true,
              onSelectedItemChanged: onChangeHour,
              children: List.generate(
                12,
                (i) => Center(
                  child: CustomText(
                    text: '${i + 1}'.padLeft(2, '0'),
                    color: AppColors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),

          const Text(' : ', style: TextStyle(fontSize: 26)),

          SizedBox(
            width: width * 0.2,
            child: CupertinoPicker(
              itemExtent: 50,
              looping: true,
              onSelectedItemChanged: onChangeMinute,
              children: List.generate(
                4,
                (i) => Center(
                  child: CustomText(
                    text: (i * 15).toString().padLeft(2, '0'),
                    color: AppColors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Helper Buttons ────────────────────────────────────────────────────────

  Widget amPmButton(String label, bool value) {
    final bool selected = isStart ? (isStartAM == value) : (isEndAM == value);
    return GestureDetector(
      onTap: () => setState(() {
        if (isStart) {
          isStartAM = value;
        } else {
          isEndAM = value;
        }
      }),
      child: CustomText(
        text: label,
        color: selected ? AppColors.black : AppColors.grey,
        fontSize: 15,
        fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
      ),
    );
  }

  Widget startEndButton(String label, bool value) {
    final bool selected = isStart == value;
    return GestureDetector(
      onTap: () => setState(() => isStart = value),
      child: CustomText(
        text: label,
        color: selected ? AppColors.black : AppColors.grey,
        fontSize: 18,
        fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
      ),
    );
  }
}