// lib/feature/discover/widgets/full_screen_profile.dart

import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/image/display_network_image.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/core/utils/different_text_format/time_format.dart';
import 'package:consultz/feature/discover/model/content_model.dart';
import 'package:flutter/material.dart';

class FullScreenProfile extends StatelessWidget {
  const FullScreenProfile({super.key, required this.feedList});

  final FeedList feedList;

  @override
  Widget build(BuildContext context) {
    final double width = Screen.screenWidth(context);
    final double scaleFactor = width / Screen.designWidth;

    final author = feedList.author;
    final fullName = '${author?.firstName ?? ''} ${author?.lastName ?? ''}'
        .trim();
    final photoUrl = author?.photoUrl;

    return Row(
      children: [
        // Back button
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.white,
            size: scaleFactor * 22,
          ),
        ),

        // Avatar + name + book now
        Expanded(
          child: Row(
            children: [
              // Avatar — using DisplayNetworkImage with circle clip
              ClipOval(
                child: DisplayNetworkImage(
                  imageUrl: photoUrl ?? '',
                  imageWidth: scaleFactor * 40,
                  imageHeight: scaleFactor * 40,
                  imageFit: BoxFit.cover,
                  radius: 100,
                  iconSize: scaleFactor * 20,
                ),
              ),
              SizedBox(width: width * 0.02),

              // Name + book now
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: fullName.isNotEmpty ? fullName : 'Unknown',
                      color: AppColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    CustomText(
                      text: timeFormat(feedList.createdAt ?? ''),
                      color: AppColors.grey,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Coin + notification
        // Row(
        //   children: [
        //     AppBarCoin(),
        //     SizedBox(width: width * 0.02),
        //     NotificationBell(),
        //     SizedBox(width: width * 0.02),
        //   ],
        // ),
      ],
    );
  }
}
