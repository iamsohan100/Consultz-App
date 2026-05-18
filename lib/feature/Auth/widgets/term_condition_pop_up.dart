import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/loading.dart/circle_loading.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/controller/sign_up_controller.dart';
import 'package:consultz/feature/expert/controller/terms_condition_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

void termConditionPopUp({required BuildContext context}) {
  final signUpController = Get.find<SignUpController>();
  final termsConditionController = Get.find<TermsConditionController>();
  final height = Screen.screenHeight(context);
  final width = Screen.screenWidth(context);
  final scalefactor = width / Screen.designWidth;

  final ScrollController scrollController = ScrollController();
  final RxBool showActiveCheckboxColor = false.obs;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      // Determine if scrolling is needed — if not, show active checkbox immediately
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients &&
            scrollController.position.maxScrollExtent == 0) {
          showActiveCheckboxColor.value = true;
        }
      });

      scrollController.addListener(() {
        if (scrollController.offset >=
                scrollController.position.maxScrollExtent &&
            !scrollController.position.outOfRange) {
          showActiveCheckboxColor.value = true;
        }
      });

      return AlertDialog(
        actionsAlignment: MainAxisAlignment.end,
        scrollable: false,
        backgroundColor: Colors.white,
        actionsPadding: EdgeInsets.symmetric(
          vertical: height * 0.01,
          horizontal: width * 0.04,
        ),
        insetPadding: EdgeInsets.only(
          top: height * 0.05,
          bottom: height * 0.1,
          left: width * 0.05,
          right: width * 0.05,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        title: CustomText(
          text: 'Terms and condition & privacy policy.',
          color: AppColors.primaryColor,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: height * 0.4,
              child: RawScrollbar(
                controller: scrollController,
                radius: Radius.circular(3),
                thumbVisibility: true,
                minThumbLength: height * 0.15,
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: EdgeInsets.only(right: width * 0.015),
                    child: Obx(() {
                      final data = termsConditionController
                          .termsConditionModel
                          .value
                          .data;
                      if (termsConditionController.inProgress.value) {
                        return CircleLoading(top: 0.17);
                      }
                      if (data?.termsAndConditions != null) {
                        return Html(data: data?.termsAndConditions ?? '');
                      } else {
                        return CustomText(
                          text:
                              '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. By accessing, browsing, or using this application, website, or service, you acknowledge that you have read, understood, and agreed to be bound by these Terms & Conditions. If you do not agree with any part of these terms, you must discontinue use of the service immediately. Lorem ipsum dolor sit amet, consectetur adipiscing elit. By accessing, browsing, or using this application, website, or service, you acknowledge that you have read, understood, and agreed to be bound by these Terms & Conditions. If you do not agree with any part of these terms, you must discontinue use of the service immediately. Lorem ipsum dolor sit amet, consectetur adipiscing elit. By accessing, browsing, or using this application, website, or service, you acknowledge that you have read, understood, and agreed to be bound by these Terms & Conditions. If you do not agree with any part of these terms, you must discontinue use of the service immediately.''',
                          color: AppColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          lineHeight: 1.6,
                        );
                      }
                    }),
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.03),
            Obx(() {
              final isChecked =
                  signUpController.termsAndConditionCheckBox.value;
              final isActive = showActiveCheckboxColor.value;

              final boxColor = isChecked
                  ? (isActive
                        ? AppColors.primaryColor
                        : AppColors.primaryColor.withValues(alpha: 0.5))
                  : Colors.white;

              final borderColor = isActive
                  ? AppColors.primaryColor
                  : AppColors.primaryColor.withValues(alpha: 0.5);

              final textColor = isActive
                  ? AppColors.primaryColor
                  : AppColors.primaryColor.withValues(alpha: 0.5);

              return GestureDetector(
                onTap: isActive
                    ? () {
                        signUpController.termsAndConditionCheckBox.value =
                            !isChecked;
                      }
                    : null,
                child: Row(
                  children: [
                    Container(
                      width: scalefactor * 18,
                      height: scalefactor * 18,
                      decoration: BoxDecoration(
                        color: boxColor,
                        borderRadius: BorderRadius.circular(scalefactor * 3),
                        border: Border.all(color: borderColor, width: 2),
                      ),

                      child: signUpController.termsAndConditionCheckBox.value
                          ? Icon(
                              Icons.check,
                              color: Colors.white,
                              size: scalefactor * 14,
                            )
                          : null,
                    ),
                    SizedBox(width: width * 0.04),
                    Expanded(
                      child: CustomText(
                        text: 'Accept terms and conditions & privacy policy',
                        color: textColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
        actions: [
          Obx(() {
            final isChecked = signUpController.termsAndConditionCheckBox.value;
            return TextButton(
              onPressed: isChecked
                  ? () {
                      Navigator.of(context).pop();
                    }
                  : null,
              child: CustomText(
                text: 'I agree',
                color: isChecked
                    ? AppColors.primaryColor
                    : AppColors.primaryColor.withValues(alpha: 0.5),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            );
          }),
        ],
      );
    },
  );
}
