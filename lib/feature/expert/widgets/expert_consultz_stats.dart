import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:consultz/feature/expert/controller/expert_profile_controller.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpertConsultzStats extends StatelessWidget {
  const ExpertConsultzStats({super.key, this.isProfile});
  final bool? isProfile;
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final profileController = Get.find<ProfileController>();
    final expertProfileController = Get.find<ExpertProfileController>();

    Widget stats({
      required Color color,
      required Color borderColor,
      required String image,
      required double imageSize,
      required String value,
      required String title,
    }) {
      return Row(
        spacing: width * 0.02,
        children: [
          Container(
            width: scaleFactor * 34,
            height: scaleFactor * 34,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(scaleFactor * 6.5),
              border: Border.all(color: borderColor),
            ),
            alignment: Alignment.center,
            child: Image.asset(image, width: imageSize),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: value,
                color: AppColors.black,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              CustomText(
                text: title,
                color: AppColors.darkGrey,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        ],
      );
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (isProfile == true) {
          Get.toNamed(RoutesConstant.expertDashboardScreen);
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: height * 0.025),
        padding: EdgeInsets.all(scaleFactor * 14),
        width: width,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(scaleFactor * 8),
          border: Border.all(color: AppColors.midGrey),
        ),
        child: Obx(() {
          final profileData = profileController.expertProfileModel.value.data;
          final expertProfileData =
              expertProfileController.expertProfileModel.value.data;
          final activeData = isProfile == true
              ? profileData
              : expertProfileData;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: height * 0.015,
            children: [
              if (isProfile == true)
                Row(
                  children: [
                    CustomText(
                      text: 'Consultz stats',
                      color: AppColors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    Spacer(),
                    CustomText(
                      text: 'Dashboard',
                      color: AppColors.darkGrey,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(width: width * 0.015),
                    Image.asset(AppImages.arrow, width: scaleFactor * 9),
                  ],
                )
              else
                CustomText(
                  text: 'Dashboard',
                  color: AppColors.darkGrey,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  stats(
                    color: Color(0xFFFFE8E8),
                    borderColor: Color(0xFFFFCACA),
                    image: AppImages.icon,
                    imageSize: scaleFactor * 20,
                    value: '${activeData?.points ?? 0}', // ✅
                    title: 'Consultz Points',
                  ),
                  stats(
                    color: Color(0xFFFFF8E8),
                    borderColor: Color(0xFFFFF3CA),
                    image: AppImages.star,
                    imageSize: scaleFactor * 16,
                    value: '${activeData?.avgRating ?? 0}', // ✅
                    title: 'Av. star rating',
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  stats(
                    color: Color(0xFFF8E8FF),
                    borderColor: Color(0xFFE7CAFF),
                    image: AppImages.calender,
                    imageSize: scaleFactor * 20,
                    value: '${activeData?.avgAttendance ?? 0}%', // ✅
                    title: 'Av. attendance',
                  ),
                  stats(
                    color: Color(0xFFE8FFEA),
                    borderColor: Color(0xFFCAFFCE),
                    image: AppImages.watch,
                    imageSize: scaleFactor * 16,
                    value: '${activeData?.advisingTimeInHours ?? 0} hrs', // ✅
                    title: 'Advising time',
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
