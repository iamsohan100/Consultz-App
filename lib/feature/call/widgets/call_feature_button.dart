import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:flutter/material.dart';

class CallFeatureButton extends StatelessWidget {
  const CallFeatureButton({super.key, required this.onTap});
final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    endCallContainer() {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          clipBehavior: Clip.antiAlias,
          height: scaleFactor * 48,
          width: scaleFactor * 48,
          padding: EdgeInsets.all(scaleFactor * 10),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Image.asset(
            AppImages.endCall,
            color: AppColors.white,
            width: scaleFactor * 30,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    featureContainer({required String image}) {
      return Container(
        clipBehavior: Clip.antiAlias,
        height: scaleFactor * 48,
        width: scaleFactor * 48,
        padding: EdgeInsets.all(scaleFactor * 10),
        decoration: BoxDecoration(
          color: Color(0xFFDADADA).withValues(alpha: 0.5),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Image.asset(
          image,
          color: AppColors.white,
          width: scaleFactor * 20,
          fit: BoxFit.cover,
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(
        top: scaleFactor * 15,
        left: scaleFactor * 20,
        right: scaleFactor * 20,
        bottom: scaleFactor * 40,
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          featureContainer(image: AppImages.message),
          featureContainer(image: AppImages.video),
          featureContainer(image: AppImages.moute),
          endCallContainer(),
        ],
      ),
    );
  }
}
