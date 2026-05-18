import 'dart:ui';

import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpertEarningBookingAnalytics extends StatelessWidget {
  const ExpertEarningBookingAnalytics({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final profileController = Get.find<ProfileController>();

    Container valueContainer({
      required String title,
      required String subtitle,
      required Widget child,
      required Color containerIdentityColor,
    }) {
      return Container(
        width: width,
        height: height * 0.12,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(scaleFactor * 8),
          border: Border.all(color: AppColors.midGrey, width: 0.8),
        ),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 50,
              decoration: BoxDecoration(
                color: containerIdentityColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(scaleFactor * 10),
                  bottomLeft: Radius.circular(scaleFactor * 10),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(scaleFactor * 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: title,
                    color: AppColors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  CustomText(
                    text: subtitle,
                    color: AppColors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  child,
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Obx(() {
      final expertProfile = profileController.expertProfileModel.value.data;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: height * 0.018,
        children: [
          Row(
            spacing: width * 0.035,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(RoutesConstant.earningScreen);
                  },
                  child: valueContainer(
                    title: "£${expertProfile?.totalWithdraw ?? 0}",
                    subtitle: 'Total earnings',
                    child: CustomText(
                      text: "£${expertProfile?.pendingWithdraw ?? 0} Proceed",
                      color: AppColors.green,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                    containerIdentityColor: AppColors.green.withValues(
                      alpha: 0.18,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => Get.toNamed(RoutesConstant.bookingHistoryScreen),

                  child: valueContainer(
                    title: "${expertProfile?.totalBookings ?? 0}",
                    subtitle: 'Total bookings',
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: width * 0.02,
                      children: [
                        CustomText(
                          text: 'Call history',
                          color: AppColors.darkGrey,
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                        Image.asset(AppImages.arrow, width: scaleFactor * 9),
                      ],
                    ),
                    containerIdentityColor: AppColors.lilac.withValues(
                      alpha: 0.18,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            spacing: width * 0.035,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(scaleFactor * 8),
                  child: Stack(
                    children: [
                      valueContainer(
                        title: '',
                        subtitle: 'L3 pro analytics',
                        child: CustomText(
                          text: 'After Unlock',
                          color: AppColors.grey,
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                        containerIdentityColor: AppColors.warmYellow.withValues(
                          alpha: 0.18,
                        ),
                      ),

                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                        child: Container(
                          color: AppColors.black.withValues(
                            alpha: 0.08,
                          ), // tint
                        ),
                      ),
                      Container(
                        width: width,
                        height: height * 0.12,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(scaleFactor * 8),
                          border: Border.all(
                            color: AppColors.midGrey,
                            width: 0.8,
                          ),
                        ),
                      ),
                      Positioned(
                        top: scaleFactor * 14,
                        left: scaleFactor * 14,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          spacing: height * 0.01,
                          children: [
                            Image.asset(
                              AppImages.lock,
                              width: scaleFactor * 15,
                            ),
                            CustomText(
                              text: 'L3 pro analytics',
                              color: AppColors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                            CustomText(
                              text: 'Unlocks at level 3',
                              color: AppColors.primaryColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: valueContainer(
                  title: '${expertProfile?.profileViewCount ?? 0}',
                  subtitle: 'Profile views',
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: width * 0.02,
                    children: [
                      Image.asset(
                        AppImages.arrowCurve,
                        width: scaleFactor * 10.5,
                      ),
                      CustomText(
                        text: 'Last 7d',
                        color: AppColors.grey,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  containerIdentityColor: AppColors.mutePink.withValues(
                    alpha: 0.18,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
