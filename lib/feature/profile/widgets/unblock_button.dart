import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/image/display_network_image.dart';
import 'package:consultz/feature/profile/model/blocked_user_model.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/profile/widgets/unblock_dialog.dart';
import 'package:flutter/material.dart';

class UnblockButton extends StatelessWidget {
  const UnblockButton({super.key, required this.blockedUserData});
  final BlockedUserData? blockedUserData;
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final expertise = blockedUserData?.expertise != null
        ? blockedUserData!.expertise!.join(', ')
        : '';
    return ListTile(
      leading: Container(
        clipBehavior: Clip.antiAlias,
        width: scaleFactor * 51,
        height: scaleFactor * 51,
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: blockedUserData?.photoUrl != null
            ? DisplayNetworkImage(
                imageUrl: blockedUserData?.photoUrl,
                imageFit: .cover,
                imageSize: scaleFactor * 51,
              )
            : Image.asset(AppImages.profileImage, fit: BoxFit.cover),
      ),
      title: CustomText(
        text: "${blockedUserData?.firstName} ${blockedUserData?.lastName}",
        color: AppColors.black,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      subtitle: CustomText(
        text: expertise,
        color: AppColors.grey,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      trailing: PrimaryButton(
        onPressed: () {
          unblockDialog(
            context: context,
            title: "${blockedUserData?.firstName} ${blockedUserData?.lastName}",
            userId: blockedUserData?.sId ?? '',
          );
        },
        title: 'Unblock',
        buttonWidth: width * 0.25,
        buttonHeight: height * 0.045,
        radius: 12,
      ),
    );
  }
}
