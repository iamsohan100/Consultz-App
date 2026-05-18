import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PreqAnsContainer extends StatelessWidget {
  const PreqAnsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final height = Screen.screenHeight(context);
    final width = Screen.screenWidth(context);
    final scaleFactor = width / Screen.designWidth;
    Obx qAns({required String q, required String a}) {
      RxBool isPreq = false.obs;

      return Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: height * 0.014,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                isPreq.value = !isPreq.value;
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: q,
                    color: AppColors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  Icon(
                    isPreq.value == true
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: AppColors.darkGrey,
                    size: scaleFactor * 18,
                  ),
                ],
              ),
            ),
            if (isPreq.value)
              Container(
                width: width,
                padding: EdgeInsets.all(scaleFactor * 16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(scaleFactor * 8),
                  border: Border.all(color: AppColors.midGrey),
                ),
                child: CustomText(
                  text: a,
                  color: AppColors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            SizedBox(),
          ],
        );
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        qAns(
          q: 'What is the main question you’d like answered?',
          a: 'The best strategies for investing in rental, properties in my local area especially concerning market trends and property management. ',
        ),
        qAns(
          q: 'What challenges or roadblocks are you facing?',
          a: 'The best strategies for investing in rental, properties in my local area especially',
        ),
        qAns(
          q: 'Can you share some background or context?',
          a: 'properties in my local area especially concerning market trends and property management. ',
        ),
      ],
    );
  }
}
