import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/image/display_network_image.dart';
import 'package:consultz/core/utils/image/pick_image.dart';
import 'package:consultz/core/utils/message/top_message.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:consultz/feature/profile/controller/update_consultee_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ChangeProfileOption extends StatelessWidget {
  const ChangeProfileOption({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final profileController = Get.find<ProfileController>();

    selectOption({
      required VoidCallback onTap,
      required String image,
      required String title,
    }) {
      return GestureDetector(
        onTap: onTap,
        child: Row(
          spacing: width * 0.032,
          children: [
            Image.asset(image, width: scaleFactor * 18),
            CustomText(
              text: title,
              color: AppColors.darkGrey,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
      );
    }

    return PopScope(
      canPop: false,
      child: Container(
        width: width,
        margin: EdgeInsets.only(bottom: height * 0.04),
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        decoration: BoxDecoration(
          color: Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(scaleFactor * 8),
        ),
        child: Obx(() {
          final data = profileController.expertProfileModel.value.data;

          return Column(
            spacing: height * 0.017,
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  clipBehavior: Clip.antiAlias,
                  width: scaleFactor * 45,
                  height: scaleFactor * 45,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: DisplayNetworkImage(
                    imageUrl: data?.photoUrl,
                    imageFit: .cover,
                    radius: 8,
                    imageSize: scaleFactor * 45,
                  ),
                ),
                title: CustomText(
                  text: "${data?.firstName} ${data?.lastName}",
                  color: AppColors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                subtitle: CustomText(
                  text: 'Default image',
                  color: AppColors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Container(
                width: width,
                height: height * 0.001,
                color: AppColors.midGrey,
              ),
              selectOption(
                onTap: () async {
                  await _pickAndUpdateImage(context, ImageSource.gallery);
                },
                image: AppImages.gallery,
                title: 'Choose from library',
              ),
              selectOption(
                onTap: () async {
                  await _pickAndUpdateImage(context, ImageSource.camera);
                },
                image: AppImages.camera,
                title: 'Take a photo',
              ),
              SizedBox(height: height * 0.004),
            ],
          );
        }),
      ),
    );
  }
}

Future<void> _pickAndUpdateImage(
  BuildContext context,
  ImageSource source,
) async {
  final updateConsulteeProfile = Get.find<UpdateConsulteeProfileController>();

  final image = await PickImageService().pickProfileImge(source: source);

  if (image == null) {
    return;
  }

  updateConsulteeProfile.profileImge.value = image;

  final response = await updateConsulteeProfile.updateImage(context);
  if (response) {
    Navigator.pop(context);
    topMessage(title: 'Updated', msg: 'Profile image updated successfully');
  }
}
