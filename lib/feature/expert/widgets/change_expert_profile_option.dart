import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/different_text_format/time_format.dart';
import 'package:consultz/core/utils/image/pick_image.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/form_field/custom_form_field.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:consultz/feature/expert/controller/update_expert_image_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ChangeExpertProfileOption extends StatefulWidget {
  const ChangeExpertProfileOption({super.key});

  @override
  State<ChangeExpertProfileOption> createState() =>
      _ChangeExpertProfileOptionState();
}

class _ChangeExpertProfileOptionState extends State<ChangeExpertProfileOption> {
  final updateExpertImageController = Get.find<UpdateExpertImageController>();
  final profileController = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    final profileData = profileController.expertProfileModel.value.data;
    updateExpertImageController.headlineController.text =
        profileData?.headline ?? "";
  }

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final profileData = profileController.expertProfileModel.value.data;
    final createdAt = profileData?.createdAt;

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

    return Padding(
      padding: EdgeInsets.only(
        top: height * 0.002,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () => continu(context),
              child: CustomText(
                text: 'Done',
                color: AppColors.primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: height * 0.004),
          Expanded(
            child: Padding(
              padding: .zero,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: width,
                      margin: EdgeInsets.only(
                        bottom: height * 0.02,
                        top: height * 0.02,
                      ),
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
                                    updateExpertImageController
                                            .profileImge
                                            .value !=
                                        null
                                    ? FileImage(
                                        updateExpertImageController
                                            .profileImge
                                            .value!,
                                      )
                                    : AssetImage(AppImages.profileImage),
                              );
                            }),
                            title: CustomText(
                              text: 'Edit profile',
                              color: AppColors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            subtitle: CustomText(
                              text:
                                  'Last updated ${timeFormat(createdAt ?? '')}',
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
                              updateExpertImageController.profileImge.value =
                                  await PickImageService().pickProfileImge(
                                    source: ImageSource.gallery,
                                  );
                            },
                            image: AppImages.gallery,
                            title: 'Choose from library',
                          ),
                          selectOption(
                            onTap: () async {
                              updateExpertImageController.profileImge.value =
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
                    ),
                    Container(
                      width: width,
                      margin: EdgeInsets.only(bottom: height * 0.02),

                      decoration: BoxDecoration(
                        color: Color(0xFFF8F8F8),
                        borderRadius: BorderRadius.circular(scaleFactor * 8),
                      ),
                      child: Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 16 / 6,

                            child: Container(
                              clipBehavior: Clip.antiAlias,

                              width: width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(scaleFactor * 8),
                                  topRight: Radius.circular(scaleFactor * 8),
                                ),
                              ),
                              child: Obx(() {
                                return updateExpertImageController
                                            .coverImage
                                            .value !=
                                        null
                                    ? Image.file(
                                        updateExpertImageController
                                            .coverImage
                                            .value!,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        AppImages.profileImage,
                                        fit: BoxFit.cover,
                                      );
                              }),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.04,
                            ),
                            child: Column(
                              children: [
                                ListTile(
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,

                                  title: CustomText(
                                    text: 'Edit cover',
                                    color: AppColors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  subtitle: CustomText(
                                    text:
                                        'Last updated ${timeFormat(createdAt ?? '')}',
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
                                SizedBox(height: height * 0.017),
                                selectOption(
                                  onTap: () async {
                                    updateExpertImageController
                                        .coverImage
                                        .value = await PickImageService()
                                        .pickProfileImge(
                                          source: ImageSource.gallery,
                                          cropeStyle: CropStyle.rectangle,
                                          initAspectRatio:
                                              CropAspectRatioPreset.ratio16x9,
                                        );
                                  },
                                  image: AppImages.gallery,
                                  title: 'Choose from library',
                                ),
                                SizedBox(height: height * 0.017),

                                selectOption(
                                  onTap: () async {
                                    updateExpertImageController
                                        .coverImage
                                        .value = await PickImageService()
                                        .pickProfileImge(
                                          source: ImageSource.camera,
                                          cropeStyle: CropStyle.rectangle,
                                          initAspectRatio:
                                              CropAspectRatioPreset.ratio16x9,
                                        );
                                  },
                                  image: AppImages.camera,
                                  title: 'Take a photo',
                                ),
                                SizedBox(height: height * 0.017),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: width,
                      margin: EdgeInsets.only(bottom: height * 0.04),
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.04,
                        vertical: height * 0.015,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFF8F8F8),
                        borderRadius: BorderRadius.circular(scaleFactor * 8),
                      ),
                      child: Column(
                        spacing: height * 0.001,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: 'Edit headline',
                            color: AppColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),

                          SizedBox(height: height * 0.01),
                          CustomFormField(
                            controller:
                                updateExpertImageController.headlineController,
                            hintText: 'Enter headline...',
                            backgroundColor: Colors.transparent,
                            minLine: 4,
                            maxLine: 5,
                            padding: scaleFactor * 10,
                            horPadding: scaleFactor * 10,
                          ),
                          SizedBox(height: height * 0.004),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> continu(BuildContext context) async {
  final updateExpertImageController = Get.find<UpdateExpertImageController>();

  final response = await updateExpertImageController.updateImage(context);
  if (response && context.mounted) {
    Navigator.pop(context);
  }
}
