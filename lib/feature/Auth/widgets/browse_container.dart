import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/feature/Auth/model/browse_first_page_model.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/controller/browse_first_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrowseContainer extends StatelessWidget {
  const BrowseContainer({super.key, required this.browseModel});
  final BrowseModel browseModel;

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final browseViewModel = Get.find<BrowseFirstController>();

    return GestureDetector(
      onTap: () {
        if (browseModel.status == 'consultee') {
          browseViewModel.isConsultee.value = true;
        } else {
          browseViewModel.isConsultee.value = false;
        }
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        height: height * 0.24,
        width: width,
        decoration: BoxDecoration(
          color: AppColors.warmGrey,
          borderRadius: BorderRadius.circular(scaleFactor * 16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(scaleFactor * 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Obx(() {
                      return Container(
                        width: scaleFactor * 20,
                        height: scaleFactor * 20,
                        // padding: EdgeInsets.all(scaleFactor * 2.7),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: scaleFactor * 2,
                            color: AppColors.darkGrey,
                          ),
                        ),
                        alignment: Alignment.center,
                        child:
                            (browseViewModel.isConsultee.value &&
                                    browseModel.status == 'consultee') ||
                                !browseViewModel.isConsultee.value &&
                                    browseModel.status == 'expert'
                            ? Container(
                                width: scaleFactor * 10,
                                height: scaleFactor * 10,
                                decoration: BoxDecoration(
                                  color: AppColors.darkGrey,
                                  shape: BoxShape.circle,
                                ),
                              )
                            : null,
                      );
                    }),
                    SizedBox(height: height * 0.01),

                    CustomText(
                      text: browseModel.title,
                      color: AppColors.darkGrey,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                    ),
                    SizedBox(height: height * 0.015),
                    for (int i = 0; i < browseModel.features.length; i++)
                      CustomText(
                        text: browseModel.features[i],
                        color: AppColors.darkGrey,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.4,
                      ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  browseModel.image,
                  width: scaleFactor * 240,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
