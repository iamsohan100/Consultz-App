import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/message/top_message.dart';
import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:consultz/feature/Auth/controller/set_key_expertise_controller.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/widgets/interest_value_container.dart';
import 'package:consultz/feature/expert/controller/edit_expert_sub_category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditExpertSubCategoryScreen extends StatefulWidget {
  const EditExpertSubCategoryScreen({super.key});

  @override
  State<EditExpertSubCategoryScreen> createState() =>
      _EditExpertSubCategoryScreenState();
}

class _EditExpertSubCategoryScreenState
    extends State<EditExpertSubCategoryScreen> {
  final isSelect = false.obs;
  final setKeyExpertiseController = Get.find<SetKeyExpertiseController>();
  final profileController = Get.find<ProfileController>();
  final editExpertSubCategoryController =
      Get.find<EditExpertSubCategoryController>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      editExpertSubCategoryController.getItemsForSelectedCategories();
      final skills = profileController.expertProfileModel.value.data?.skills;
      if (skills != null) {
        editExpertSubCategoryController.selectedSubCategoryList.addAll(skills);
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
        title: 'Sub Category',
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
                        'Your sub-category highlights your specialized focus, making it easier for the right consultees to find you.',
                    color: AppColors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(height: height * 0.02),

                  Align(
                    alignment: Alignment.center,
                    child: Wrap(
                      spacing: width * 0.02,
                      runSpacing: height * 0.02,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.center,
                      children: [
                        for (final skill
                            in editExpertSubCategoryController.allSubCategories)
                          InterestValueContainer(
                            onTap: () {
                              if (editExpertSubCategoryController
                                  .selectedSubCategoryList
                                  .contains(skill)) {
                                editExpertSubCategoryController
                                    .selectedSubCategoryList
                                    .remove(skill);
                              } else {
                                editExpertSubCategoryController
                                    .selectedSubCategoryList
                                    .add(skill);
                              }
                            },
                            title: skill,
                            isSelected: editExpertSubCategoryController
                                .selectedSubCategoryList
                                .contains(skill),
                          ),
                      ],
                    ),
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
    final response = await editExpertSubCategoryController.updateSubCategory(
      context,
    );
    if (response && mounted) {
      topMessage(title: 'Successful', msg: 'Sub-category updated successfully');
      Navigator.pop(context);
    }
  }
}
