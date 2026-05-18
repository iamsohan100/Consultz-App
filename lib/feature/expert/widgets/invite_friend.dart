
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/expert/widgets/invite_friend_bottom_sheet.dart';
import 'package:flutter/material.dart';

class InviteFriend extends StatelessWidget {
  const InviteFriend({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    return GestureDetector(
      onTap: () {
        inviteFriendBottomSheet(context);
      },
      child: Container(
        width: width,

        margin: EdgeInsets.only(top: height * 0.02),
        padding: EdgeInsets.all(scaleFactor * 12),
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(scaleFactor * 8),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(AppImages.icon, width: scaleFactor * 19),
            SizedBox(width: width * 0.02),
            CustomText(
              text: 'Invite friends',
              color: AppColors.primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              lineHeight: 1,
            ),
            Spacer(),

            Icon(
              Icons.share,
              color: AppColors.primaryColor,
              size: scaleFactor * 18,
            ),
          ],
        ),
      ),
    );
  }
}