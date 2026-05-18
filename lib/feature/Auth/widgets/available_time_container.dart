import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/widgets/time_picker_modal_sheet.dart';
import 'package:consultz/feature/expert/controller/calendar_controller.dart';
import 'package:consultz/feature/expert/model/available_time_model.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AvailableTimeContainer extends StatefulWidget {
  const AvailableTimeContainer({super.key, required this.dayName});
  final String dayName;

  @override
  State<AvailableTimeContainer> createState() => _AvailableTimeContainerState();
}

class _AvailableTimeContainerState extends State<AvailableTimeContainer> {
  late final RxList<AvailableTimeModel> daySlots;
  late final RxBool isSelect;

  @override
  void initState() {
    super.initState();
    final calendarController = Get.find<CalendarController>();
    daySlots = calendarController.getDayList(widget.dayName);
    // আগে থেকে slots থাকলে switch on থাকবে
    isSelect = (daySlots.isNotEmpty).obs;

    // slots change হলে switch ও update হবে
    daySlots.listen((_) {
      if (daySlots.isEmpty) {
        isSelect.value = false;
      } else {
        isSelect.value = true; // loadFromProfile এ slots add হলে switch on হবে
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    // final calendarController = Get.find<CalendarController>();

    // ── Individual time row ───────────────────────────────────────────────
    Container timeRow(AvailableTimeModel time) {
      return Container(
        width: width,
        padding: EdgeInsets.all(scaleFactor * 8),
        decoration: const BoxDecoration(color: Color(0xFFF8F8F8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Remove slot
            GestureDetector(
              onTap: () {
                if (daySlots.contains(time)) {
                  daySlots.remove(time);
                }
              },
              child: Icon(
                Icons.remove_circle,
                size: scaleFactor * 18,
                color: AppColors.grey,
              ),
            ),

            CustomText(
              text: '${time.startTime} – ${time.endTime}',
              color: AppColors.black,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),

            // Add another slot for same day
            GestureDetector(
              onTap: () => timePickerModalSheet(context, widget.dayName),
              child: Icon(
                Icons.add_circle,
                size: scaleFactor * 18,
                color: AppColors.darkGrey,
              ),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        isSelect.value = !isSelect.value;
        if (isSelect.value && daySlots.isEmpty) {
          timePickerModalSheet(context, widget.dayName);
        } else if (!isSelect.value) {
          daySlots.clear();
        }
      },
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(scaleFactor * 14),
          border: Border.all(color: AppColors.midGrey),
        ),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header row ─────────────────────────────────────────────
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05,
                  vertical: height * 0.01,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CustomText(
                          text: widget.dayName,
                          color: AppColors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                        if (daySlots.isNotEmpty) ...[
                          SizedBox(width: scaleFactor * 8),
                          GestureDetector(
                            onTap: () {
                              Get.find<CalendarController>()
                                  .applyToAllDays(daySlots.toList());
                              bottomMessage(msg: 'Applied to all days');
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: scaleFactor * 8,
                                vertical: scaleFactor * 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor.withValues(alpha: 0.1),
                                borderRadius:
                                    BorderRadius.circular(scaleFactor * 4),
                              ),
                              child: CustomText(
                                text: 'Apply to all',
                                fontSize: 10,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(
                      height: height * 0.015,
                      width: width * 0.08,
                      child: Transform.scale(
                        scale: 0.7,
                        child: Switch(
                          padding: EdgeInsets.only(right: width * 0),
                          activeThumbColor: AppColors.white,
                          inactiveThumbColor: AppColors.white,
                          activeTrackColor: AppColors.primaryColor,
                          inactiveTrackColor: AppColors.grey,
                          value: isSelect.value,
                          onChanged: (v) {
                            isSelect.value = v;
                            if (isSelect.value && daySlots.isEmpty) {
                              timePickerModalSheet(context, widget.dayName);
                            } else if (!isSelect.value) {
                              daySlots.clear();
                            }
                          },
                          trackOutlineColor:
                              WidgetStateProperty.resolveWith<Color?>((
                                Set<WidgetState> states,
                              ) {
                                if (states.contains(WidgetState.selected)) {
                                  return AppColors.primaryColor;
                                }
                                return AppColors.grey;
                              }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Slots list ─────────────────────────────────────────────
              if (isSelect.value && daySlots.isNotEmpty)
                ListView.separated(
                  primary: false,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: daySlots.length,
                  itemBuilder: (_, index) => timeRow(daySlots[index]),
                  separatorBuilder: (_, _) => SizedBox(height: height * 0.008),
                ),

              if (isSelect.value) SizedBox(height: height * 0.01),
            ],
          );
        }),
      ),
    );
  }
}
