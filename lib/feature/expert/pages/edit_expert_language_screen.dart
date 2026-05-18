import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/drop_down/custom_drop_down.dart';
import 'package:consultz/core/utils/message/top_message.dart';
import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/widgets/interest_value_container.dart';
import 'package:consultz/feature/expert/controller/edit_expert_language_controller.dart';
import 'package:consultz/feature/expert/model/all_languages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditExpertLanguageScreen extends StatefulWidget {
  const EditExpertLanguageScreen({super.key});

  @override
  State<EditExpertLanguageScreen> createState() =>
      _EditExpertLanguageScreenState();
}

class _EditExpertLanguageScreenState extends State<EditExpertLanguageScreen> {
  final profileController = Get.find<ProfileController>();
  final editExpertLanguageController = Get.find<EditExpertLanguageController>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final languages =
          profileController.expertProfileModel.value.data?.languages;
      if (languages != null) {
        editExpertLanguageController.selectedLanguageList.addAll(languages);
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
        title: 'Language',
        actions: [
          GestureDetector(
            onTap: done,
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
            padding: EdgeInsetsGeometry.all(scaleFactor * 18),
            child: Obx(() {
            

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(
                    text:
                        'Your language preference helps you communicate effectively with the right consultees.',
                    color: AppColors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(height: height * 0.02),

                  CustomDropDown(
                    title: 'Languages',
                    items: allLanguages,
                    value: editExpertLanguageController.selectedLanguage.value,
                    onChange: (value) {
                      editExpertLanguageController.selectedLanguage.value =
                          value!;
                      if (!editExpertLanguageController.selectedLanguageList
                              .contains(value) &&
                          value != 'Select your language') {
                        editExpertLanguageController.selectedLanguageList.add(
                          value,
                        );
                      }
                    },
                  ),
                  SizedBox(height: height * 0.03),
                  CustomText(
                    text: 'Your selected languages',
                    color: AppColors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(height: height * 0.02),

                  Wrap(
                    spacing: width * 0.02,
                    runSpacing: height * 0.02,
                    children: [
                      for (
                        int i = 0;
                        i <
                            editExpertLanguageController
                                .selectedLanguageList
                                .length;
                        i++
                      )
                        InterestValueContainer(
                          title: editExpertLanguageController
                              .selectedLanguageList[i],

                          onTap: null,
                          onRemove: () {
                            editExpertLanguageController.selectedLanguageList
                                .removeAt(i);
                          },
                        ),
                    ],
                  ),

                  SizedBox(height: height * 0.04),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Future<void> done() async {
    final response = await editExpertLanguageController.updateLanguage(context);
    if (response && mounted) {
      topMessage(title: 'Successful', msg: 'Language updated successfully');
      Navigator.pop(context);
    }
  }
}
