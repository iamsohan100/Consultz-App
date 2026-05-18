import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConsulteeBookinPoint extends StatelessWidget {
  const ConsulteeBookinPoint({super.key});

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
                color: AppColors.lilac.withValues(alpha: 0.18),
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
      final data = profileController.expertProfileModel.value.data;

      return Row(
        spacing: width * 0.04,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => Get.toNamed(RoutesConstant.bookingHistoryScreen),

              child: valueContainer(
                title: '10',
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
              ),
            ),
          ),
          Expanded(
            child: valueContainer(
              title: "${data?.points ?? 0}",
              subtitle: 'Consultz points',
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: width * 0.02,
                children: [
                  CustomText(
                    text: 'Available',
                    color: AppColors.darkGrey,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                  CustomText(
                    text: 'Points',
                    color: AppColors.darkGrey,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                  Image.asset(AppImages.arrowCurve, width: scaleFactor * 10.5),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
