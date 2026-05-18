import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileSection extends StatelessWidget {
  const EditProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final profileController = Get.find<ProfileController>();

    GestureDetector sectionContent({
      required VoidCallback onTap,
      required String title,
      required String value,
      bool? isGray,
    }) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: CustomText(
                text: title,
                color: AppColors.black,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(width: width * 0.1),
            Expanded(
              flex: 9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomText(
                          text: value,
                          color: isGray == true
                              ? AppColors.grey
                              : AppColors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          textOverflow: TextOverflow.ellipsis,
                        ),
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
            ),
          ],
        ),
      );
    }

    return Container(
      width: width,
      margin: EdgeInsets.only(top: height * 0.02),
      padding: EdgeInsets.all(scaleFactor * 18),
      color: Color(0xFFF8F8F8),
      child: Obx(() {
        final data = profileController.expertProfileModel.value.data;

        return Column(
          spacing: height * 0.01,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionContent(
              onTap: () {
                Get.toNamed(RoutesConstant.updateNameScreen);
              },
              title: 'Name',
              value: "${data?.firstName} ${data?.lastName}",
            ),
            sectionContent(
              onTap: () {
                Get.toNamed(RoutesConstant.updateJobRoleScreen);
              },
              title: 'Job role',
              value: data?.headline == null || data?.headline == ''
                  ? "Add job role"
                  : data?.headline ?? "",
              isGray: data?.headline == null || data?.headline == '',
            ),

            sectionContent(
              onTap: () {
                Get.toNamed(RoutesConstant.editPhoneNumberScreen);
              },
              title: 'Phone',
              value: "${data?.phoneNumber}",
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
        );
      }),
    );
  }
}
