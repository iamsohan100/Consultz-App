import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/text/custom_text.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavedLoginScreen extends StatelessWidget {
  const SavedLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    RxBool isSelect = true.obs;

    return Scaffold(
      appBar: customAppBar(
  
        context: context,
        title: 'Saved login information',
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.all(scaleFactor * 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(() {
                  return Row(
                    spacing: width * 0.15,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: height * 0.002,
                          children: [
                            CustomText(
                              text: 'Saved login information',
                              color: AppColors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            CustomText(
                              text:
                                  'We’ll save login info, so you don’t need to enter it on your iCloud© devices. ',
                              color: AppColors.darkGrey,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              lineHeight: 1.6,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        width: width * 0.08,
                        child: Transform.scale(
                          scale: 0.6,
                          child: Switch(
                            padding: EdgeInsets.only(right: width * 0),
                            activeThumbColor: AppColors.white,
                            inactiveThumbColor: AppColors.white,
                            activeTrackColor: AppColors.primaryColor,
                            inactiveTrackColor: AppColors.grey,
                            value: isSelect.value,
                            onChanged: (v) {
                              isSelect.value = !isSelect.value;
                            },

                            trackOutlineColor:
                                WidgetStateProperty.resolveWith<Color?>((
                                  Set<WidgetState> states,
                                ) {
                                  if (states.contains(WidgetState.selected)) {
                                    return AppColors.primaryColor;
                                  }
                                  return AppColors.grey;
                                }),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
