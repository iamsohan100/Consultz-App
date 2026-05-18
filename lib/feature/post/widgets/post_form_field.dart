import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/feature/post/controller/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PostFormField extends StatelessWidget {
  const PostFormField({super.key});

  @override
  Widget build(BuildContext context) {
    // double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final postController = Get.find<PostController>();
    return TextFormField(
      controller: postController.captionController,
      style: GoogleFonts.figtree(
        fontSize: scaleFactor * 14,
        fontWeight: FontWeight.w400,
        color: AppColors.black,
        letterSpacing: 0.4,
      ),
      minLines: 2,
      maxLines: 20,

      decoration: InputDecoration(
        filled: false,
        hintText: 'Share your knowledge...',
        hintStyle: GoogleFonts.figtree(
          fontSize: scaleFactor * 14,
          fontWeight: FontWeight.w400,
          color: AppColors.grey,
          letterSpacing: 0.4,
        ),

        border: OutlineInputBorder(borderSide: BorderSide.none),
      ),
    );
  }
}
