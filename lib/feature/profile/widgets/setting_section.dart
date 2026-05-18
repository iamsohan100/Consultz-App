import 'package:consultz/feature/expert/controller/terms_condition_controller.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/controller/browse_first_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingSection extends StatelessWidget {
  const SettingSection({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final browseFirstController = Get.find<BrowseFirstController>();
    final termsConditionController = Get.find<TermsConditionController>();
    GestureDetector sectionContent({
      required String title,
      required VoidCallback onTap,
    }) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: title,
                  color: AppColors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),

                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.darkGrey,
                  size: scaleFactor * 15,
                ),
              ],
            ),
            Divider(color: AppColors.midGrey),
          ],
        ),
      );
    }

    return Container(
      width: width,

      margin: browseFirstController.isConsultee.value
          ? EdgeInsets.only(top: height * 0.02)
          : null,
      padding: EdgeInsets.all(scaleFactor * 18),
      color: Color(0xFFF8F8F8),
      child: Column(
        spacing: height * 0.012,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionContent(
            onTap: () {
              Get.toNamed(RoutesConstant.passwordAndSecurityScreen);
            },
            title: 'Password and security ',
          ),
          sectionContent(
            onTap: () {
              Get.toNamed(RoutesConstant.notificationSettingScreen);
            },
            title: 'Notifications',
          ),
          if (browseFirstController.isConsultee.value)
            sectionContent(
              onTap: () {
                Get.toNamed(RoutesConstant.paymentDetailsScreen);
              },
              title: 'Payment settings',
            )
          else
            sectionContent(
              onTap: () async {
                final response = await termsConditionController
                    .getTermsCondition(context);
                if (response) {
                  Get.toNamed(RoutesConstant.termsConditonScreen);
                }
              },
              title: 'Terms and conditions',
            ),
          sectionContent(
            onTap: () {
              Get.toNamed(RoutesConstant.supportScreen);
            },
            title: 'Support',
          ),
          sectionContent(
            onTap: () {
              Get.toNamed(RoutesConstant.deleteAccountScreen);
            },
            title: 'Delete account',
          ),
          SizedBox(height: height * 0.06),
          Center(
            child: CustomText(
              text: 'Consultz ・ ️Version 1.0 ',
              color: AppColors.grey,
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
