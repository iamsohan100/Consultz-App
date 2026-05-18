import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/widgets/notification_bell.dart';
import 'package:consultz/feature/Auth/widgets/app_bar_coin.dart';
import 'package:flutter/material.dart';

class CommingSoonScreen extends StatelessWidget {
  const CommingSoonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    return Scaffold(
      appBar: customAppBar(
        context: context,
        isLeading: true,
        title: '',
        fontSize: 24,
        actions: [
          AppBarCoin(),
          SizedBox(width: width * 0.02),
          NotificationBell(),
          SizedBox(width: width * 0.02),
        ],
      ),

      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: height * 0.1,
              right: width * 0.1,
              child: Container(
                height: scaleFactor * 150,
                width: scaleFactor * 150,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.warmYellow.withValues(alpha: 0.6),
                      blurRadius: 130,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: height * 0.2,
              left: width * 0.1,
              child: Container(
                height: scaleFactor * 130,
                width: scaleFactor * 130,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryColor.withValues(alpha: 0.5),
                      blurRadius: 130,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: height * 0.25,
              left: width * 0.1,
              child: Container(
                height: scaleFactor * 130,
                width: scaleFactor * 130,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.lilac.withValues(alpha: 0.8),
                      blurRadius: 130,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: height * 0.15,
              right: width * 0.1,
              child: Container(
                height: scaleFactor * 130,
                width: scaleFactor * 130,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.mutePink.withValues(alpha: 0.8),
                      blurRadius: 130,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: .zero,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Image.asset(AppImages.commingSoon, width: width),
                        ],
                      ),
                    ),
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
