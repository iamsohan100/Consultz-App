import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarCoin extends StatelessWidget {
  const AppBarCoin({super.key});

  @override
  Widget build(BuildContext context) {
    final height = Screen.screenHeight(context);
    final width = Screen.screenWidth(context);
    final scalefactor = width / Screen.designWidth;
    final profileController = Get.find<ProfileController>();
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: height * 0.005,
        horizontal: width * 0.014,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFFFE8E8),
        borderRadius: BorderRadius.circular(scalefactor * 33),
        border: Border.all(color: Color(0xFFFFBCBC).withValues(alpha: 0.68)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Image.asset(AppImages.icon, width: scalefactor * 17),
          SizedBox(width: width * 0.01),
          Obx(() {
            final coin =
                profileController.expertProfileModel.value.data?.points;
            return CustomText(
              text: "${coin ?? '0'}",
              color: AppColors.primaryColor,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            );
          }),
        ],
      ),
    );
  }
}
