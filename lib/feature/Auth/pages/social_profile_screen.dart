import 'package:consultz/feature/Auth/controller/social_profile_controller.dart';
import 'package:consultz/feature/Auth/model/social_profile_data.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/drop_down/custom_drop_down.dart';
import 'package:consultz/core/utils/form_field/custom_form_field.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/widgets/filling_steps.dart';
import 'package:consultz/feature/Auth/widgets/mobile_verification_progress_container.dart';
import 'package:consultz/feature/profile/widgets/add_social_channel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SocialProfileScreen extends StatelessWidget {
  const SocialProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final socialProfileController = Get.find<SocialProfileController>();
    return Scaffold(
      appBar: customAppBar(title: '', context: context),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.only(
              top: scaleFactor * 8,
              left: scaleFactor * 20,
              right: scaleFactor * 20,
              bottom: scaleFactor * 20,
            ),
            child: Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: height * 0.016,
                children: [
                  FillingSteps(currentScreen: 2),
                  SizedBox(),
                  MobileVerificationProgressContainer(
                    progress: 0.6,
                    image: AppImages.socialProfile,
                    imageSize: 30,
                  ),
                  SizedBox(),
                  CustomText(
                    text: "Provide social\nprofile",
                    color: AppColors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.center,
                  ),
                  CustomText(
                    text:
                        'We collect your social information to help us better understand your expertise and maximize your exposure to our user base.',
                    color: AppColors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center,
                    lineHeight: 1.6,
                  ),
                  SizedBox(height: height * 0.01),
                  // Displaying all social channels added
                  ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: socialProfileController.socialChannels.length,
                    itemBuilder: (context, index) {
                      final socialChannel =
                          socialProfileController.socialChannels[index];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // DropDown for social channel type
                          CustomDropDown(
                            title: 'Social channel',
                            items: socialChannelList,
                            value: socialChannel.type,
                            onChange: (value) {
                              socialProfileController.updateChannelType(
                                index,
                                value!,
                              );
                            },
                          ),
                          SizedBox(height: height * 0.016),
                          // TextField for LinkedIn Profile URL
                          CustomFormField(
                            hintText: '${socialChannel.type} Profile',
                            controller: socialProfileController
                                .getProfileUrlController(
                                  index,
                                ), // Using TextEditingController
                            onChange: (value) {
                              socialProfileController.updateProfileUrl(
                                index,
                                value,
                              );
                            },
                          ),
                          SizedBox(height: height * 0.02),
                        ],
                      );
                    },
                  ),
                  SizedBox(),
                  GestureDetector(
                    behavior: .opaque,
                    onTap: () {
                      socialProfileController.addSocialChannel();
                    },
                    child: Row(
                      spacing: width * 0.04,
                      children: [
                        AddSocialChannel(),
                        CustomText(
                          text: 'Add more social channel',
                          color: AppColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(),
                  PrimaryButton(
                    onPressed: () {
                      Get.toNamed(RoutesConstant.setRateScreen);
                    },
                    title: 'Skip for now',
                    backgroundColor: AppColors.white,
                    borderColor: AppColors.primaryColor,
                    textColor: AppColors.primaryColor,
                  ),

                  PrimaryButton(
                    onPressed: () => connect(context),
                    title: 'Connect & grow',
                  ),
                  SizedBox(height: height * 0.1),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

Future<void> connect(BuildContext context) async {
  final socialProfileController = Get.find<SocialProfileController>();
  final response = await socialProfileController.updateSocialProfile(context);
  if (response) {
    Get.toNamed(RoutesConstant.setRateScreen);
  }
}
