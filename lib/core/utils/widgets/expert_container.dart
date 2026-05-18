import 'package:consultz/core/utils/different_text_format/follow_format.dart';
import 'package:consultz/core/utils/image/display_network_image.dart';
import 'package:consultz/feature/expert/controller/follow_unfollow_controller.dart';
import 'package:consultz/feature/home/model/expert_model.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:showcaseview/showcaseview.dart';

class ExpertContainer extends StatelessWidget {
  const ExpertContainer({
    super.key,
    this.index,
    required this.expertData,
    this.isSpecific,
    this.showcaseKey,
  });
  final int? index;
  final ExpertData expertData;
  final bool? isSpecific;
  final GlobalKey? showcaseKey;

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final followUnfollowController = Get.find<FollowUnfollowController>();

    return GestureDetector(
      onTap: () {
        Get.toNamed(
          RoutesConstant.expertDetailsScreen,
          arguments: expertData.sId,
        );
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        width: isSpecific == true ? width : width * 0.7,

        margin: isSpecific == true
            ? null
            : EdgeInsets.only(
                left: index == 0 ? scaleFactor * 14 : 0,
                right: scaleFactor * 14,
                bottom: scaleFactor * 8,
              ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(scaleFactor * 8),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.08),
              blurRadius: 8,
              spreadRadius: 0.1,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: expertData.photoUrl != null
                  ? DisplayNetworkImage(
                      imageUrl: expertData.photoUrl,
                      imageFit: .cover,
                      imageSize: width,
                    )
                  : Image.asset(AppImages.expertBanner, fit: BoxFit.cover),
            ),

            Padding(
              padding: EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 10,
                        child: Row(
                          children: [
                            Flexible(
                              child: CustomText(
                                text:
                                    "${expertData.firstName ?? ''} ${expertData.lastName ?? ''}",
                                color: AppColors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                textOverflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: width * 0.01),
                            Container(
                              height: scaleFactor * 6,
                              width: scaleFactor * 6,
                              decoration: BoxDecoration(
                                color: AppColors.green,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.star_rounded,
                        size: scaleFactor * 16,
                        color: AppColors.warmYellow,
                      ),
                      SizedBox(width: width * 0.01),

                      CustomText(
                        text: "${expertData.avgRating ?? 0}",
                        color: AppColors.darkGrey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(width: width * 0.01),

                      CustomText(
                        text: "(${expertData.ratingCount ?? 0})",
                        color: AppColors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  if (expertData.headline != null &&
                      expertData.headline!.isNotEmpty) ...[
                    SizedBox(height: height * 0.002),
                    // subtitle
                    CustomText(
                      text: "${expertData.headline}",
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      maxLine: 1,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ],

                  SizedBox(height: height * 0.02),
                  // book & follower
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        spacing: height * 0.002,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            spacing: width * 0.015,
                            children: [
                              Image.asset(
                                AppImages.profile,
                                color: AppColors.grey,
                                width: scaleFactor * 10,
                              ),
                              CustomText(
                                text:
                                    "${followFormat(expertData.followers ?? 0)} Followers",
                                color: AppColors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                          CustomText(
                            text: "${expertData.totalBookings ?? 0} Sessions",
                            color: AppColors.darkGrey,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      if (isSpecific == true) Spacer(),
                      if (isSpecific == true)
                        PrimaryButton(
                          onPressed: () async {
                            if (expertData.isFollowing == true) {
                              await followUnfollowController.unfolloweUser(
                                context,
                                userId: expertData.sId!,
                              );
                            } else {
                              await followUnfollowController.followeBackUser(
                                context,
                                userId: expertData.sId!,
                              );
                            }
                          },
                          title: expertData.isFollowing == true
                              ? 'Following'
                              : 'Follow',
                          fontSize: 10,
                          textColor: expertData.isFollowing == true
                              ? AppColors.darkGrey
                              : AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                          backgroundColor: expertData.isFollowing == true
                              ? Color(0xFFF8F8F8)
                              : Colors.transparent,
                          borderColor: expertData.isFollowing == true
                              ? null
                              : AppColors.primaryColor,
                          buttonWidth: width * 0.18,
                          buttonHeight: height * 0.05,
                          radius: 8,
                        ),
                      if (isSpecific == true) SizedBox(width: width * 0.025),
                      showcaseKey != null
                          ? Showcase(
                              key: showcaseKey!,
                              description: 'Click here to book a session',
                              child: PrimaryButton(
                                onPressed: () {
                                  Get.toNamed(
                                    RoutesConstant.selectSessionScreen,
                                    arguments: expertData.sId,
                                  );
                                },
                                title: 'Book now',
                                buttonWidth: width * 0.25,
                                buttonHeight: height * 0.05,
                                radius: 8,
                              ),
                            )
                          : PrimaryButton(
                              onPressed: () {
                                Get.toNamed(
                                  RoutesConstant.selectSessionScreen,
                                  arguments: expertData.sId,
                                );
                              },
                              title: 'Book now',
                              buttonWidth: width * 0.25,
                              buttonHeight: height * 0.05,
                              radius: 8,
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
