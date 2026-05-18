import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/message/top_message.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/drop_down/custom_drop_down.dart';
import 'package:consultz/core/utils/form_field/custom_form_field.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:consultz/feature/Auth/model/social_profile_data.dart';
import 'package:consultz/feature/expert/controller/update_social_profile_controller.dart';
import 'package:consultz/feature/expert/widgets/remove_social_channel.dart';
import 'package:consultz/feature/profile/widgets/add_social_channel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/expert_profile_model.dart';

class EditSocialProfileScreen extends StatefulWidget {
  const EditSocialProfileScreen({super.key});

  @override
  State<EditSocialProfileScreen> createState() =>
      _EditSocialProfileScreenState();
}

class _EditSocialProfileScreenState extends State<EditSocialProfileScreen> {
  final updateSocialProfileController =
      Get.find<UpdateSocialProfileController>();
  final profileController = Get.find<ProfileController>();
  @override
  void initState() {
    super.initState();
// In initState of EditSocialProfileScreen
WidgetsBinding.instance.addPostFrameCallback((_) {
  if (profileController.expertProfileModel.value.data?.socialProfiles != null) {
    final validTypes = socialChannelList.map((e) => e).toSet();
    final profiles = profileController.expertProfileModel.value.data!.socialProfiles!
        .map((p) => SocialProfiles(
              type: validTypes.contains(p.type) ? p.type : socialChannelList.first,
              url: p.url,
            ))
        .toList();
    updateSocialProfileController.socialChannels.addAll(profiles);
  }
});
  }

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Social',
        actions: [
          GestureDetector(
            onTap: () => done(context),
            child: CustomText(
              text: 'Done',
              color: AppColors.primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: width * 0.05),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.all(scaleFactor * 16),
            child: Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: height * 0.02,
                children: [
                  CustomText(
                    text:
                        'Link your social media profiles to showcase your professional presence and connect with consultees beyond Consultz. Building a well-rounded profile boosts credibility and opens new opportunities.',
                    color: AppColors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(),

                  ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount:
                        updateSocialProfileController.socialChannels.length,
                    itemBuilder: (context, index) {
                      final socialChannel =
                          updateSocialProfileController.socialChannels[index];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // DropDown for social channel type
                          Row(
                            crossAxisAlignment: .center,
                            children: [
                              Expanded(
                                child: CustomDropDown(
                                  title: 'Social channel',
                                  items: socialChannelList,
                                  value: socialChannel.type!,
                                  onChange: (value) {
                                    updateSocialProfileController
                                        .updateChannelType(index, value!);
                                  },
                                ),
                              ),
                              SizedBox(width: width * 0.04),
                              RemoveSocialChannel(index: index),
                            ],
                          ),
                          SizedBox(height: height * 0.016),
                          // TextField for LinkedIn Profile URL
                          CustomFormField(
                            hintText: '${socialChannel.type} Profile',
                            controller: updateSocialProfileController
                                .getProfileUrlController(
                                  index,
                                ), // Using TextEditingController
                            onChange: (value) {
                              updateSocialProfileController.updateProfileUrl(
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
                  GestureDetector(
                    behavior: .opaque,
                    onTap: () {
                      updateSocialProfileController.addSocialChannel();
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
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

Future<void> done(BuildContext context) async {
  final updateSocialProfileController =
      Get.find<UpdateSocialProfileController>();
  final response = await updateSocialProfileController.updateSocialProfile(
    context,
  );
  if (response && context.mounted) {
    topMessage(title: 'Successful', msg: 'Social profile updated successfully');
    Navigator.pop(context);
  }
}
