import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/feature/bookings/model/session_data.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SessionDurationContainer extends StatelessWidget {
  const SessionDurationContainer({
    super.key,
    required this.sessionModel,
    required this.onToggle,
  });
  final SessionModel sessionModel;
  final VoidCallback onToggle;
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    return Obx(() {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onToggle,
        child: Container(
          width: width,

          padding: EdgeInsets.symmetric(
            horizontal: scaleFactor * 14,
            vertical: scaleFactor * 10,
          ),
          margin: EdgeInsets.symmetric(horizontal: width * 0.005),
          decoration: BoxDecoration(
            color: sessionModel.isSelected.value
                ? AppColors.warmGrey
                : AppColors.white,
            borderRadius: BorderRadius.circular(scaleFactor * 14),
            border: Border.all(color: AppColors.midGrey),
          ),
          child: Row(
            children: [
              Column(
                spacing: height * 0.003,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: sessionModel.title,
                    color: AppColors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  CustomText(
                    text: '${sessionModel.duration} Minutes',
                    color: AppColors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              Spacer(),
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
                    value: sessionModel.isSelected.value,

                    onChanged: (_) => onToggle(),

                    trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((
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
      );
    });
  }
}
