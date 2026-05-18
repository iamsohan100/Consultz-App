import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/feature/bookings/controller/booking_controller.dart';
import 'package:consultz/feature/expert/controller/expert_profile_controller.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/widgets/mobile_verification_progress_container.dart';
import 'package:consultz/feature/bookings/widgets/available_date.dart';
import 'package:consultz/feature/bookings/widgets/booking_steps.dart';
import 'package:consultz/feature/bookings/widgets/confirm_date_time_button.dart';
import 'package:consultz/feature/bookings/widgets/select_date_in_calender.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectDateAndTimeScreen extends StatefulWidget {
  const SelectDateAndTimeScreen({super.key});

  @override
  State<SelectDateAndTimeScreen> createState() =>
      _SelectDateAndTimeScreenState();
}

class _SelectDateAndTimeScreenState extends State<SelectDateAndTimeScreen> {
  final bookingController = Get.find<BookingController>();
  final expertProfileController = Get.find<ExpertProfileController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bookingController.fetchBookingSlots(
        author: expertProfileController.expertProfileModel.value.data!.sId!,
      );
      bookingController.getSlotsByExpertAndDate(
        expertId: expertProfileController.expertProfileModel.value.data!.sId!,
        date: DateTime.now(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    final expertProfile = expertProfileController.expertProfileModel.value.data;
    final expertName =
        "${expertProfile?.firstName ?? ''} ${expertProfile?.lastName ?? ''}"
            .trim();
    final sessionType = bookingController.sessionType.value.replaceAll(
      '_',
      ' ',
    );

    return Scaffold(
      appBar: customAppBar(title: '', context: context),
      bottomNavigationBar: ConfirmDateTimeButton(
        onTap: () {
          if (bookingController.slotId.value.isNotEmpty) {
            Get.toNamed(RoutesConstant.prepQuestionsScreen);
          } else {
            bottomMessage(msg: 'Please select a time slot');
          }
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.only(
              top: scaleFactor * 8,
              left: scaleFactor * 20,
              right: scaleFactor * 20,
              bottom: scaleFactor * 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: height * 0.016,
              children: [
                BookingSteps(currentScreen: 2),
                SizedBox(),
                MobileVerificationProgressContainer(
                  progress: 0.45,
                  image: AppImages.bookCall,
                  imageSize: 35,
                  color: AppColors.black,
                ),
                SizedBox(),
                CustomText(
                  text: 'Select a date and time',
                  color: AppColors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.center,
                ),
                CustomText(
                  text:
                      'Select a date and start time you’d like to book your $sessionType session with $expertName',
                  color: AppColors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.center,
                  lineHeight: 1.6,
                ),
                SelectDateInCalender(expertId: expertProfile!.sId!),
                AvailableDate(),
                SizedBox(height: height * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
