import 'package:consultz/feature/Auth/controller/set_bank_controller.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/expert/controller/expert_dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpertTools extends StatelessWidget {
  const ExpertTools({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final expertDashboard = Get.find<ExpertDashboardViewModel>();
    final bankController = Get.find<SetBankController>();

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
            textAlign: TextAlign.center,
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
              onTap: () async {
                expertDashboard.isPayment.value =
                    !expertDashboard.isPayment.value;
                expertDashboard.isAddContent.value = false;
                expertDashboard.isPromote.value = false;
                expertDashboard.isCall.value = false;
                final response = await bankController.checkStripe(context);
                if (response) {
                  Get.toNamed(RoutesConstant.connectStripeScreen);
                }
              },
              isSelected: expertDashboard.isPayment,
              title: 'Payment\nsettings',
              icon: AppImages.payment,
              iconSize: 22,
            ),
            toolContainer(
              onTap: () {
                expertDashboard.isPayment.value = false;
                expertDashboard.isAddContent.value =
                    !expertDashboard.isAddContent.value;
                expertDashboard.isPromote.value = false;
                expertDashboard.isCall.value = false;
                Get.toNamed(RoutesConstant.postScreen);
              },
              isSelected: expertDashboard.isAddContent,
              title: 'Add content',
              icon: AppImages.add,
              iconSize: 18,
            ),
            toolContainer(
              onTap: () {
                expertDashboard.isPayment.value = false;
                expertDashboard.isAddContent.value = false;
                expertDashboard.isPromote.value =
                    !expertDashboard.isPromote.value;
                expertDashboard.isCall.value = false;
                Get.toNamed(RoutesConstant.commingSoonScreen);
              },
              isSelected: expertDashboard.isPromote,
              title: 'Promote',
              icon: AppImages.promote,
              iconSize: 20,
            ),
            toolContainer(
              onTap: () {
                expertDashboard.isPayment.value = false;
                expertDashboard.isAddContent.value = false;
                expertDashboard.isPromote.value = false;
                expertDashboard.isCall.value = !expertDashboard.isCall.value;
                Get.toNamed(RoutesConstant.commingSoonScreen);
              },
              isSelected: expertDashboard.isCall,
              title: 'Edit pre-call\nquestions',
              icon: AppImages.call,
              iconSize: 20,
            ),
          ],
        ),
      ],
    );
  }
}
