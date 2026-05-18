import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/feature/bookings/model/message_data.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_rich_text.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/core/utils/image/display_network_image.dart';
import 'package:flutter/material.dart';

class MessageContainer extends StatelessWidget {
  const MessageContainer({
    super.key,
    required this.messageModel,
    required this.index,
    this.photoUrl,
  });
  final MessageModel messageModel;
  final int index;
  final String? photoUrl;
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomRichText(
          text1: '${index + 1}. ',
          text2: messageModel.qus,
          color1: AppColors.primaryColor,
          color2: AppColors.black,
          fontSize1: 12,
          fontSize2: 12,
          fontWeight: FontWeight.w700,
          fontWeight2: FontWeight.w500,
        ),
        Row(
          spacing: width * 0.02,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              height: scaleFactor * 24,
              width: scaleFactor * 24,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: photoUrl != null
                  ? DisplayNetworkImage(
                      imageUrl: photoUrl!,
                      imageFit: BoxFit.cover,
                      imageSize: scaleFactor*24,
                    )
                  : Image.asset(AppImages.profileImage, fit: BoxFit.cover),
            ),
            Expanded(
              child: Container(
                width: width,
                margin: EdgeInsets.only(top: height * 0.02),
                padding: EdgeInsets.all(scaleFactor * 16),
                decoration: BoxDecoration(
                  color: AppColors.warmGrey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(scaleFactor * 25),
                    topRight: Radius.circular(scaleFactor * 25),
                    bottomRight: Radius.circular(scaleFactor * 25),
                    bottomLeft: Radius.circular(scaleFactor * 8),
                  ),
                ),
                child: CustomText(
                  text: messageModel.ans,
                  color: AppColors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: height * 0.02),
      ],
    );
  }
}
