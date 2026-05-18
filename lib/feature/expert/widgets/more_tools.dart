import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/profile/widgets/log_out_dialog.dart';
import 'package:consultz/feature/expert/controller/expert_dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoreTools extends StatelessWidget {
  const MoreTools({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final expertDashboard = Get.find<ExpertDashboardViewModel>();
    Column toolContainer({
      required String title,
      required String icon,
      required double iconSize,
      required VoidCallback onTap,
      required RxBool isSelected,
    }) {
      return Column(
        spacing: height * 0.01,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Obx(() {
              return Container(
                width: scaleFactor * 56,
                height: scaleFactor * 56,
                decoration: BoxDecoration(
                  color: isSelected.value
                      ? AppColors.warmGrey
                      : Color(0xFFF8F8F8),
                  borderRadius: BorderRadius.circular(scaleFactor * 8),
                  border: Border.all(
                    color: isSelected.value
                        ? AppColors.primaryColor
                        : Colors.transparent,
                  ),
                ),
                alignment: Alignment.center,
                child: Image.asset(
                  icon,
                  color: isSelected.value
                      ? AppColors.primaryColor
                      : AppColors.darkGrey,
                  width: scaleFactor * iconSize,
                ),
              );
            }),
          ),
          CustomText(
            text: title,
            color: AppColors.darkGrey,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height * 0.02),
        CustomText(
          text: 'More Tools',
          color: AppColors.black,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: height * 0.012),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            toolContainer(
              onTap: () {
                expertDashboard.isCalender.value =
                    !expertDashboard.isCalender.value;
                expertDashboard.isEditProfile.value = false;
                expertDashboard.isAccountSetting.value = false;
                expertDashboard.isLogOut.value = false;
                Get.toNamed(RoutesConstant.calendarScreen);
              },
              isSelected: expertDashboard.isCalender,
              title: 'Calendar',
              icon: AppImages.bookings,
              iconSize: 19,
            ),
            toolContainer(
              onTap: () {
                expertDashboard.isCalender.value = false;
                expertDashboard.isEditProfile.value =
                    !expertDashboard.isEditProfile.value;
                expertDashboard.isAccountSetting.value = false;
                expertDashboard.isLogOut.value = false;
              },
              isSelected: expertDashboard.isEditProfile,
              title: 'Edit Profile',
              icon: AppImages.profile,
              iconSize: 16,
            ),
            toolContainer(
              onTap: () {
                expertDashboard.isCalender.value = false;
                expertDashboard.isEditProfile.value = false;
                expertDashboard.isAccountSetting.value =
                    !expertDashboard.isAccountSetting.value;
                expertDashboard.isLogOut.value = false;
              },
              isSelected: expertDashboard.isAccountSetting,
              title: 'Account\nSettings',
              icon: AppImages.setting,
              iconSize: 18,
            ),

            toolContainer(
              onTap: () {
                expertDashboard.isCalender.value = false;
                expertDashboard.isEditProfile.value = false;
                expertDashboard.isAccountSetting.value = false;
                expertDashboard.isLogOut.value =
                    !expertDashboard.isLogOut.value;
                logOutDialog(context: context);
              },
              isSelected: expertDashboard.isLogOut,
              title: 'Logout',
              icon: AppImages.logOut,
              iconSize: 19,
            ),
          ],
        ),
      ],
    );
  }
}
