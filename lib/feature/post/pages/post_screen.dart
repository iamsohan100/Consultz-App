import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/image/pick_image.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/feature/post/widgets/display_post_media.dart';
import 'package:consultz/feature/post/widgets/post_app_bar.dart';
import 'package:consultz/feature/post/widgets/post_form_field.dart';
import 'package:consultz/feature/main/controller/main_controller.dart';
import 'package:consultz/feature/post/controller/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key, this.isExpert});
  final bool? isExpert;

  @override
  Widget build(BuildContext context) {
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final postController = Get.find<PostController>();

    return PopScope(
      canPop: isExpert == true,
      onPopInvokedWithResult: (_, _) {
        if (isExpert != true) {
          Get.find<MainController>().changeIndex(index: 0);
        }
      },
      child: Scaffold(
        appBar: postAppBar(context, isExpert),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.warmGrey,
          onPressed: () async {
            final List<XFile> files = await PickImageService().pickMixedMedia();
            if (files.isNotEmpty) {
              postController.addMixedMedia(files);
            }
          },
          child: Icon(
            Icons.add_photo_alternate_rounded,
            color: AppColors.primaryColor,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                left: scaleFactor * 4,
                right: scaleFactor * 4,
                bottom: scaleFactor * 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [PostFormField(), DisplayPostMedia()],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
