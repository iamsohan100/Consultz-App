import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/image/pick_image.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/controller/browse_first_controller.dart';
import 'package:consultz/feature/Auth/controller/price_range_controller.dart';
import 'package:consultz/feature/Auth/controller/set_hourly_rate_controller.dart';
import 'package:consultz/feature/Auth/controller/upload_profile_picture_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ChoseImageOptionContainer extends StatelessWidget {
  const ChoseImageOptionContainer({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final browseFirstController = Get.find<BrowseFirstController>();
    final uploadProfilePictureController =
        Get.find<UploadProfilePictureController>();

    final priceRangeScreenController = Get.find<PriceRangeController>();
    final setHourlyRateController = Get.find<SetHourlyRateController>();
    final profileData = browseFirstController.isConsultee.value
        ? priceRangeScreenController.expertSetProfileModel.value.data
        : setHourlyRateController.expertSetProfileModel.value.data;
    selectOption({
      required VoidCallback onTap,
      required String image,
      required String title,
    }) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
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

    return Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      decoration: BoxDecoration(
        color: Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(scaleFactor * 8),
      ),
      child: Column(
        spacing: height * 0.017,
        children: [
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: Obx(() {
              return CircleAvatar(
                radius: scaleFactor * 20,
                backgroundImage:
                    uploadProfilePictureController.profileImge.value != null
                    ? FileImage(
                        uploadProfilePictureController.profileImge.value!,
                      )
                    : AssetImage(AppImages.profileImage),
              );
            }),
            title: CustomText(
              text: "${profileData?.firstName} ${profileData?.lastName}",
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
              uploadProfilePictureController.profileImge.value =
                  await PickImageService().pickProfileImge(
                    source: ImageSource.gallery,
                  );
            },
            image: AppImages.gallery,
            title: 'Choose from library',
          ),
          selectOption(
            onTap: () async {
              uploadProfilePictureController.profileImge.value =
                  await PickImageService().pickProfileImge(
                    source: ImageSource.camera,
                  );
            },
            image: AppImages.camera,
            title: 'Take a photo',
          ),
          SizedBox(height: height * 0.004),
        ],
      ),
    );
  }
}
