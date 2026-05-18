import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_rich_text.dart';
import 'package:consultz/feature/Auth/controller/sign_up_controller.dart';
import 'package:consultz/feature/Auth/widgets/term_condition_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsAndCondition extends StatelessWidget {
  const TermsAndCondition({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpController = Get.find<SignUpController>();
    final width = Screen.screenWidth(context);
    final scalefactor = width / Screen.designWidth;
    return GestureDetector(
      onTap: () {
        termConditionPopUp(context: context);
      },
      child: Row(
        children: [
          Obx(() {
            return Container(
              width: scalefactor * 18,
              height: scalefactor * 18,
              decoration: BoxDecoration(
                color: signUpController.termsAndConditionCheckBox.value
                    ? AppColors.primaryColor
                    : Colors.white,
                borderRadius: BorderRadius.circular(scalefactor * 3),
                border: Border.all(color: AppColors.primaryColor, width: 2),
              ),

              child: signUpController.termsAndConditionCheckBox.value
                  ? Icon(
                      Icons.check,
                      color: Colors.white,
                      size: scalefactor * 14,
                    )
                  : null,
            );
          }),
          SizedBox(width: width * 0.03),
          Expanded(
            child: CustomRichText(
              text1:
                  'By ticking, you are confirming that you have read, understood and agree to Consultz ',
              text2: ' T&Cs.',
              color1: AppColors.black,
              color2: AppColors.black,
              fontSize1: 12,
              fontSize2: 12,
              fontWeight: FontWeight.w400,
              fontWeight2: FontWeight.w500,
              textDecoration: TextDecoration.underline,
              textDecorationColor: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
