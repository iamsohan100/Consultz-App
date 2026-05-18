import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/image/display_network_image.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/core/utils/widgets/full_screen_image_viewer.dart';
import 'package:consultz/feature/bookings/model/chat_message_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({super.key, required this.message, required this.isMe});
  final ChatMessageData message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (!isMe) ...[
          Container(
            clipBehavior: Clip.antiAlias,
            width: scaleFactor * 32,
            height: scaleFactor * 32,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: (message.sender?.photoUrl != null)
                ? DisplayNetworkImage(
                    imageUrl: message.sender!.photoUrl!,
                    imageFit: BoxFit.cover,
                    imageSize: scaleFactor*32,
                  )
                : Image.asset(AppImages.profileImage, fit: BoxFit.cover),
          ),
          SizedBox(width: width * 0.018),
        ],
        Column(
          crossAxisAlignment: isMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            if (message.text != null && message.text!.isNotEmpty)
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: scaleFactor * 12,
                  horizontal: scaleFactor * 16,
                ),
                constraints: BoxConstraints(maxWidth: width * 0.65),
                decoration: BoxDecoration(
                  color: isMe ? AppColors.primaryColor : AppColors.midGrey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(scaleFactor * 20),
                    topRight: Radius.circular(scaleFactor * 20),
                    bottomLeft: isMe
                        ? Radius.circular(scaleFactor * 20)
                        : Radius.zero,
                    bottomRight: isMe
                        ? Radius.zero
                        : Radius.circular(scaleFactor * 20),
                  ),
                ),
                child: CustomText(
                  text: message.text!,
                  color: isMe ? AppColors.white : AppColors.darkGrey,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            if (message.imageUrl != null && message.imageUrl!.isNotEmpty)
              ...message.imageUrl!.map(
                (url) => Padding(
                  padding: EdgeInsets.only(top: height * 0.01),
                  child: GestureDetector(
                    onTap: () => Get.to(
                      () => FullScreenImageViewer(imageUrl: url),
                      transition: Transition.fade,
                    ),
                    child: Container(
                      width: width * 0.6,
                      height: width * 0.4,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(scaleFactor * 12),
                      ),
                      child: DisplayNetworkImage(
                        imageUrl: url,
                        imageFit: BoxFit.cover,
                        imageSize: width*0.6,
                      ),
                    ),
                  ),
                ),
              ),

            Padding(
              padding: EdgeInsets.only(top: height * 0.005),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (message.createdAt != null)
                    CustomText(
                      text: () {
                        final msgTime = DateTime.parse(message.createdAt!).toLocal();
                        final now = DateTime.now();
                        final diff = now.difference(msgTime);
                        if (diff.inHours < 24) {
                          return DateFormat('hh:mm a').format(msgTime);
                        } else {
                          return DateFormat('MMM d, hh:mm a').format(msgTime);
                        }
                      }(),
                      color: AppColors.grey,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  if (isMe) ...[
                    SizedBox(width: width * 0.01),
                    Icon(
                      message.seen == true ? Icons.done_all : Icons.done,
                      size: scaleFactor * 14,
                      color: message.seen == true
                          ? AppColors.primaryColor
                          : AppColors.grey,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
