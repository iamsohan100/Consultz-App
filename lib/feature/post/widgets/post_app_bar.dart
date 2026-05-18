import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/feature/main/controller/main_controller.dart';
import 'package:consultz/feature/post/controller/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar postAppBar(BuildContext context, bool? isExpert) {
  double height = Screen.screenHeight(context);
  double width = Screen.screenWidth(context);
  double scaleFactor = width / Screen.designWidth;
  final postController = Get.find<PostController>();
  return customAppBar(
    context: context,
    isLeading: false,
    actions: [
      IconButton(
        onPressed: () {
          if (isExpert == true) {
            Navigator.pop(context);
          } else {
            Get.find<MainController>().changeIndex(index: 0);
          }
        },
        icon: Icon(
          Icons.close,
          color: AppColors.darkGrey,
          size: scaleFactor * 20,
        ),
      ),
      Spacer(),
      PrimaryButton(
        onPressed: () {
          postController.createPost();
          Get.find<MainController>().changeIndex(index: 3);
        },
        title: 'Post',
        buttonHeight: height * 0.04,
        buttonWidth: width * 0.2,
        fontSize: 12,
        radius: 10,
      ),
      SizedBox(width: width * 0.04),
    ],
  );
}
