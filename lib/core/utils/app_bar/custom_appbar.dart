import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/main/controller/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar customAppBar({
  String? title,
  bool? isLeading,
  bool? isBottomBar,
  List<Widget>? actions,
  double? fontSize,
  required BuildContext context,
  Color? color,
  Widget? bottomWidget,
  double? bottomWidgetHeight,
  bool? isLine,
  VoidCallback? onTap,
}) {
  double width = Screen.screenWidth(context);
  double scaleFactor = width / Screen.designWidth;
  return AppBar(
    leading: isLeading == false
        ? null
        : IconButton(
            onPressed:
                onTap ??
                () {
                  isBottomBar == true
                      ? Get.find<MainController>().changeIndex(index: 0)
                      : Navigator.pop(context);
                },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: AppColors.black,
              size: scaleFactor * 20,
            ),
          ),
    automaticallyImplyLeading: false,
    shadowColor: Colors.grey.shade100,
    elevation: 0,
    title: CustomText(
      text: title ?? '',
      fontSize: scaleFactor * (fontSize ?? 16),
      fontWeight: FontWeight.w700,
      color: AppColors.black,
    ),
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: color ?? AppColors.white,
    actions: actions,
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(
        scaleFactor * ((bottomWidgetHeight ?? 0) + (isLine == true ? 1 : 0)),
      ),
      child: Column(
        children: [
          ?bottomWidget,
          if (isLine == true)
            Container(
              height: 1,
              color: AppColors.midGrey, // হালকা bottom shadow look
            ),
        ],
      ),
    ),
  );
}
