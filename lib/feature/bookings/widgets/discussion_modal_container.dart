import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/bookings/widgets/booking_cancel_dialog.dart';
import 'package:consultz/feature/bookings/widgets/preq_ans_container.dart';
import 'package:consultz/feature/Auth/controller/browse_first_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiscussionModalContainer extends StatelessWidget {
  const DiscussionModalContainer({
    super.key,
    required this.bookingId,
    required this.expertId,
    required this.firstName,
    required this.lastName,
    required this.formatedDate,
    required this.timeRange,
    
     this.isDetailScreen,
  });
  final String? bookingId;
  final String? expertId;
  final String firstName;
  final String lastName;
  final String formatedDate;
  final String timeRange;
  final bool? isDetailScreen;

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    RxBool isPreq = false.obs;
    final browseFirstController = Get.find<BrowseFirstController>();

    GestureDetector sectionContent({
      required String title,
      required VoidCallback onTap,
      required String? image,
      RxBool? isSelected,
    }) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Row(
          children: [
            if (image != null) ...[
              Image.asset(image, width: scaleFactor * 24),
              SizedBox(width: width * 0.04),
            ],

            CustomText(
              text: title,
              color: AppColors.black,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            Spacer(),
            Icon(
              isSelected?.value == true
                  ? Icons.keyboard_arrow_up
                  : Icons.arrow_forward_ios_rounded,
              color: AppColors.darkGrey,
              size: scaleFactor * 15,
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      child: SingleChildScrollView(
        child: Obx(() {
          String participantName = '$firstName $lastName';
          return Column(
            spacing: height * 0.014,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (browseFirstController.isConsultee.value)
                sectionContent(
                  onTap: () {
                    isPreq.value = !isPreq.value;
                  },
                  title: 'Preparation questions ',
                  image: null,
                  isSelected: isPreq.value.obs,
                ),
              SizedBox(),
              if (isPreq.value) PreqAnsContainer(),

              sectionContent(
                onTap: () {
                  Navigator.pop(context);
                  Get.toNamed(
                    RoutesConstant.bookingRescheduleScreen,
                    arguments: {
                      'bookingId': bookingId,
                      'expertId': expertId,
                      'firstName': firstName,
                      'lastName': lastName,
                      'isDetailScreen': isDetailScreen,
                    },
                  );
                },
                title: 'Reschedule',
                image: AppImages.bookCall,
              ),

              sectionContent(
                onTap: () {
                  Navigator.pop(context);
                  bookingCancelDialog(
                    context: context,
                    bookingId: bookingId ?? '',
                    name: participantName.trim(),
                    date: formatedDate,
                    time: timeRange,
                  );
                },
                title: 'Cancel',
                image: AppImages.report,
              ),
              SizedBox(height: height * 0.05),
            ],
          );
        }),
      ),
    );
  }
}
