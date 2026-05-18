import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/profile/widgets/log_out_dialog.dart';
import 'package:consultz/feature/profile/controller/consultee_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Tools extends StatelessWidget {
  const Tools({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final consulteeProfileController = Get.find<ConsulteeProfileController>();
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
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height * 0.02),
        CustomText(
          text: 'Tools',
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
                consulteeProfileController.isProfile.value =
                    !consulteeProfileController.isProfile.value;
                consulteeProfileController.isSetting.value = false;
                consulteeProfileController.isFollowing.value = false;
                consulteeProfileController.isLogOut.value = false;
              },
              isSelected: consulteeProfileController.isProfile,
              title: 'Edit Profile',
              icon: AppImages.profile,
              iconSize: 16,
            ),
            toolContainer(
              onTap: () {
                consulteeProfileController.isProfile.value = false;
                consulteeProfileController.isSetting.value =
                    !consulteeProfileController.isSetting.value;
                consulteeProfileController.isFollowing.value = false;
                consulteeProfileController.isLogOut.value = false;
              },
              isSelected: consulteeProfileController.isSetting,
              title: 'Account\nSettings',
              icon: AppImages.setting,
              iconSize: 18,
            ),
            toolContainer(
              onTap: () {
                consulteeProfileController.isProfile.value = false;
                consulteeProfileController.isSetting.value = false;
                consulteeProfileController.isFollowing.value =
                    !consulteeProfileController.isFollowing.value;
                consulteeProfileController.isLogOut.value = false;
                Get.toNamed(RoutesConstant.followingScreen);
              },
              isSelected: consulteeProfileController.isFollowing,
              title: 'Following',
              icon: AppImages.icon,
              iconSize: 25,
            ),
            toolContainer(
              onTap: () {
                consulteeProfileController.isProfile.value = false;
                consulteeProfileController.isSetting.value = false;
                consulteeProfileController.isFollowing.value = false;
                consulteeProfileController.isLogOut.value =
                    !consulteeProfileController.isLogOut.value;
                logOutDialog(context: context);
              },
              isSelected: consulteeProfileController.isLogOut,
              title: 'Logout',
              icon: AppImages.logOut,
              iconSize: 19.84,
            ),
          ],
        ),
      ],
    );
  }
}
