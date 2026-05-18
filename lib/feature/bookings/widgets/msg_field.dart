import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/form_field/custom_form_field.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/feature/bookings/controller/msg_controller.dart';
import 'package:consultz/feature/bookings/controller/socket_service_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageField extends StatelessWidget {
  const MessageField({
    super.key,
    required this.bookingId,
    required this.receiverId,
  });
  final String bookingId;
  final String receiverId;
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final socketController = Get.find<SocketServiceController>();
    final msgController = Get.find<MsgController>();
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: scaleFactor * 10,
        vertical: scaleFactor * 10,
      ),
      child: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Obx(
              () => GestureDetector(
                onTap: msgController.uploadInProgress.value
                    ? null
                    : () {
                        msgController.uploadMultipleFiles(
                          receiverId: receiverId,
                          bookingId: bookingId,
                        );
                      },
                child: Container(
                  height: scaleFactor * 45,
                  width: scaleFactor * 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: msgController.uploadInProgress.value
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.primaryColor,
                          ),
                        )
                      : Image.asset(AppImages.attach, scale: 3),
                ),
              ),
            ),

            Expanded(
              child: CustomFormField(
                controller: msgController.msgController,
                hintText: 'Type your message...',
                maxLine: 7,
                padding: height * 0.008,
              ),
            ),

            GestureDetector(
              onTap: () {
                socketController.sendMessageEmit(
                  receiverId: receiverId,
                  bookingId: bookingId,
                  text: msgController.msgController.text.trim(),
                  imageUrl: [],
                );
                msgController.msgController.clear();
              },
              child: Container(
                height: scaleFactor * 42,
                width: scaleFactor * 42,
                margin: .only(left: width * 0.02),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(scaleFactor * 14),
                ),
                alignment: Alignment.center,
                child: Image.asset(
                  AppImages.send,
                  width: scaleFactor * 18,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
