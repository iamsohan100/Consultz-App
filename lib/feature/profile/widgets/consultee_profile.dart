import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/image/display_network_image.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:consultz/feature/profile/widgets/change_profile_modal_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConsulteeProfile extends StatelessWidget {
  const ConsulteeProfile({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final profileController = Get.find<ProfileController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height * 0.02),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            changeProfileModalSheet(context);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() {
                final data = profileController.expertProfileModel.value.data;
                return Container(
                  clipBehavior: Clip.antiAlias,
                  width: scaleFactor * 65,
                  height: scaleFactor * 65,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: DisplayNetworkImage(
                    imageUrl: data?.photoUrl,
                    imageFit: .cover,
                    imageSize:  scaleFactor * 65,
                  ),
                );
              }),
              SizedBox(width: width * 0.02),
              _nameAndTitle(height, width, scaleFactor),
              SizedBox(width: width * 0.06),
              _editProfile(width, height, scaleFactor),
            ],
          ),
        ),

        SizedBox(height: height * 0.005),
      ],
    );
  }
}

Expanded _nameAndTitle(double height, double width, double scaleFactor) {
  final profileController = Get.find<ProfileController>();
  return Expanded(
    child: Obx(() {
      final data = profileController.expertProfileModel.value.data;
      return Column(
        spacing: height * 0.004,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,

            spacing: width * 0.01,
            children: [
              Flexible(
                child: CustomText(
                  text: "${data?.firstName} ${data?.lastName}",
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  lineHeight: 1.4,
                ),
              ),
              Container(
                height: scaleFactor * 6,
                width: scaleFactor * 6,
                decoration: BoxDecoration(
                  color: AppColors.green,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          CustomText(
            text: 'Consultee',
            color: AppColors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            lineHeight: 1.2,
          ),
        ],
      );
    }),
  );
}

Container _editProfile(double width, double height, double scaleFactor) {
  return Container(
    width: width * 0.1,
    height: height * 0.044,
    padding: EdgeInsets.all(scaleFactor * 4),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(scaleFactor * 10),
      boxShadow: [
        BoxShadow(
          color: AppColors.primaryColor.withValues(alpha: 0.08),
          blurRadius: 10,
          spreadRadius: 0.5,
          offset: Offset(0, 2),
        ),
      ],
    ),
    alignment: Alignment.center,

    child: Image.asset(AppImages.prq, width: scaleFactor * 17),
  );
}
