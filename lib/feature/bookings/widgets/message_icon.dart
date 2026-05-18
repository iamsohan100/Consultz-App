import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageIcon extends StatelessWidget {
  const MessageIcon({
    super.key,
    required this.personName,
    required this.bookingId,
    required this.receiverId,
  });
  final String personName;
  final String bookingId;
  final String receiverId;

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          RoutesConstant.msgScreen,
          arguments: {
            'personName': personName,
            'bookingId': bookingId,
            'receiverId': receiverId
          },
        );
      },
      child: Container(
        width: width * 0.1,
        height: height * 0.044,

        padding: EdgeInsets.all(scaleFactor * 4),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(scaleFactor * 10),
          boxShadow: [
            BoxShadow(
              color: AppColors.darkGrey.withValues(alpha: 0.08),
              blurRadius: 10,
              spreadRadius: 0.5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        alignment: Alignment.center,

        child: Icon(
          Icons.message_outlined,
          color: AppColors.darkGrey,
          size: scaleFactor * 20,
        ),
      ),
    );
  }
}
