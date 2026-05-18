// ignore_for_file: file_names
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordAndSecurityScreen extends StatelessWidget {
  const PasswordAndSecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
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
          ],
        ),
      );
    }

    return Scaffold(
      appBar: customAppBar(
   
        context: context,
        title: 'Password and security',
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.all(scaleFactor * 16),
            child: Column(
              spacing: height * 0.024,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sectionContent(
                  onTap: () {
                    Get.toNamed(RoutesConstant.changePasswordScreen);
                  },
                  title: 'Change password',
                ),
                sectionContent(
                  onTap: () {
                    Get.toNamed(RoutesConstant.savedLoginScreen);
                  },
                  title: 'Saved login',
                ),
                sectionContent(
                  onTap: ()async {

                    Get.toNamed(RoutesConstant.blockedUserScreen);
                  },
                  title: 'Blocked users',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
