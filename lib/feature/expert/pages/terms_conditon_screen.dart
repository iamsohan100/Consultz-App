import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/feature/expert/controller/terms_condition_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class TermsConditonScreen extends StatelessWidget {
  const TermsConditonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final termsConditionController = Get.find<TermsConditionController>();
    return Scaffold(
      appBar: customAppBar(context: context, title: 'Terms and conditions'),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.all(scaleFactor * 14),
            child: Obx(() {
              final data =
                  termsConditionController.termsConditionModel.value.data;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Html(data: data?.termsAndConditions ?? '')],
              );
            }),
          ),
        ),
      ),
    );
  }
}
