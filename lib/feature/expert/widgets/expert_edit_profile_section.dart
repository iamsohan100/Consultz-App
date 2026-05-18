import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:consultz/feature/Auth/controller/set_key_expertise_controller.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpertEditProfileSection extends StatelessWidget {
  const ExpertEditProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final profileController = Get.find<ProfileController>();
    GestureDetector sectionContent({
      required String title,
      required String value,
      bool? isGray,
      required VoidCallback onTap,
    }) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: CustomText(
                text: title,
                color: AppColors.black,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(width: width * 0.05),
            Expanded(
              flex: 11,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomText(
                          text: value,
                          color: isGray == true
                              ? AppColors.grey
                              : AppColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: width * 0.02),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors.darkGrey,
                        size: scaleFactor * 15,
                      ),
                    ],
                  ),
                  Divider(color: AppColors.midGrey, height: 20),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      width: width,
      padding: EdgeInsets.all(scaleFactor * 18),
      color: Color(0xFFF8F8F8),
      child: Obx(() {
        final data = profileController.expertProfileModel.value.data;
        final expertise = data?.expertise != null
            ? data!.expertise!.join(', ')
            : '';
        final skills = data?.skills != null ? data!.skills!.join(', ') : '';
        final languages = data?.languages != null
            ? data!.languages!.join(', ')
            : '';
        return Column(
          spacing: height * 0.01,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionContent(
              onTap: () {
                Get.toNamed(RoutesConstant.updateNameScreen);
              },
              title: 'Name',
              value: "${data?.firstName} ${data?.lastName}",
            ),
            sectionContent(
              onTap: () => category(context),
              title: 'Category',
              value: expertise,
            ),
            sectionContent(
              onTap: () => category(context, subCategory: true),
              title: 'Sub category',
              value: skills,
            ),

            sectionContent(
              onTap: () {
                Get.toNamed(RoutesConstant.editExpertBioScreen);
              },
              title: 'Bio',
              value: data?.bio ?? "",
            ),
            sectionContent(
              onTap: () {
                Get.toNamed(RoutesConstant.editEducationScreen);
              },
              title: 'Education',
              value:
                  data?.education?.degree == null ||
                      data?.education?.degree == ''
                  ? 'Add education'
                  : data?.education?.degree ?? '',
              isGray:
                  data?.education?.degree == null ||
                  data?.education?.degree == '',
            ),
            sectionContent(
              onTap: () {
                Get.toNamed(RoutesConstant.editExpertLanguageScreen);
              },
              title: 'Language',
              value: languages == '' ? 'Add languages' : languages,
              isGray: languages == '',
            ),
            sectionContent(
              onTap: () {
                Get.toNamed(RoutesConstant.editSocialProfileScreen);
              },
              title: 'Social',
              value:
                  (data?.socialProfiles == null ||
                      data?.socialProfiles?.isEmpty == true)
                  ? 'Add links'
                  : data?.socialProfiles?.first.url ?? 'Add links',
              isGray:
                  (data?.socialProfiles == null ||
                  data?.socialProfiles?.isEmpty == true),
            ),
            SizedBox(height: height * 0.06),
            Center(
              child: CustomText(
                text: 'Consultz ・ ️Version 1.0',
                color: AppColors.grey,
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        );
      }),
    );
  }
}

Future<void> category(BuildContext context, {bool? subCategory}) async {
  final setKeyExpertiseController = Get.find<SetKeyExpertiseController>();

  final response = await setKeyExpertiseController.getAllCategory(context);
  if (response) {
    if (subCategory == true) {
      Get.toNamed(RoutesConstant.editExpertSubCategoryScreen);
    } else {
      Get.toNamed(RoutesConstant.editExpertCategoryScreen);
    }
  }
}
