import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/message/top_message.dart';
import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:consultz/feature/Auth/controller/set_key_expertise_controller.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/widgets/interest_value_container.dart';
import 'package:consultz/feature/expert/controller/edit_expert_category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditExpertCategoryScreen extends StatefulWidget {
  const EditExpertCategoryScreen({super.key});

  @override
  State<EditExpertCategoryScreen> createState() =>
      _EditExpertCategoryScreenState();
}

class _EditExpertCategoryScreenState extends State<EditExpertCategoryScreen> {
  final isSelect = false.obs;
  final setKeyExpertiseController = Get.find<SetKeyExpertiseController>();
  final profileController = Get.find<ProfileController>();
  final editExpertCategoryController = Get.put(EditExpertCategoryController());
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final category =
          profileController.expertProfileModel.value.data?.expertise;
      if (category != null) {
        editExpertCategoryController.selectedCategoryList.addAll(category);
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
        title: 'Category',
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
              final categories = setKeyExpertiseController.allCategoryList;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(
                    text:
                        'Your category represents your primary focus and helps you connect with the right consultees.',
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
                        for (final category in categories)
                          InterestValueContainer(
                            onTap: () {
                              if (editExpertCategoryController
                                  .selectedCategoryList
                                  .contains(category.title)) {
                                editExpertCategoryController
                                    .selectedCategoryList
                                    .remove(category.title);
                              } else {
                                editExpertCategoryController
                                    .selectedCategoryList
                                    .add(category.title!);
                              }
                            },
                            title: category.title ?? '',
                            isSelected: editExpertCategoryController
                                .selectedCategoryList
                                .contains(category.title),
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
    final response = await editExpertCategoryController.updateCategory(context);
    if (response && mounted) {
      topMessage(title: 'Successful', msg: 'Category updated successfully');
      Navigator.pop(context);
    }
  }
}
