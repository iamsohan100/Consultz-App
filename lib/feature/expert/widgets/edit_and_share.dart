import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:consultz/feature/expert/controller/expert_detail_controller.dart';
import 'package:consultz/feature/expert/controller/profile_share_controller.dart';
import 'package:consultz/feature/expert/widgets/change_expert_profile_modal_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:showcaseview/showcaseview.dart';

class EditAndShare extends StatelessWidget {
  const EditAndShare({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final profileController = Get.find<ProfileController>();

    container({required Widget child}) {
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

        child: child,
      );
    }

    return Row(
      children: [
        GestureDetector(
          onTap: () => changeExpertProfileModalSheet(context),
          child: container(
            child: Image.asset(
              AppImages.prq,
              width: scaleFactor * 14,
              color: AppColors.darkGrey,
            ),
          ),
        ),
        SizedBox(width: width * 0.025),
        Showcase(
          key: Get.find<ExpertDetailController>().shareButtonKey,
          description: 'Click here to share your expert profile',
          descTextStyle: const TextStyle(
            color: AppColors.black,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          child: GestureDetector(
            onTap: () {
              final expertId =
                  profileController.expertProfileModel.value.data?.sId;
              Get.find<ProfileShareController>().shareProfile(
                isMy: true,
                expertId: expertId,
              );
            },
            child: container(
              child: Transform.scale(
                scaleX: -1,
                child: Icon(
                  Icons.reply,
                  size: scaleFactor * 20,
                  color: AppColors.darkGrey,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
