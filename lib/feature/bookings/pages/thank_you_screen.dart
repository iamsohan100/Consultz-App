import 'package:confetti/confetti.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_rich_text.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/widgets/mobile_verification_progress_container.dart';
import 'package:consultz/feature/bookings/widgets/confirm_date_time_button.dart';
import 'package:consultz/feature/bookings/widgets/discussion_container.dart';
import 'package:consultz/feature/bookings/controller/payment_controller.dart';
import 'package:consultz/feature/expert/controller/expert_profile_controller.dart';
import 'package:consultz/feature/bookings/model/expert_booking_by_date_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({super.key});
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    final paymentController = Get.find<PaymentController>();
    final expertProfileController = Get.find<ExpertProfileController>();

    final expertProfile = expertProfileController.expertProfileModel.value.data;
    final expertName =
        "${expertProfile?.firstName ?? ''} ${expertProfile?.lastName ?? ''}"
            .trim();

    final bookingData = paymentController.confirmedBooking.value;
    BookingItem? bookingItem;
    if (bookingData != null) {
      bookingItem = BookingItem.fromJson(bookingData);
      // Ensure the expert (consult) information is available for display
      if (bookingItem.consult != null && expertProfile != null) {
        bookingItem.consult!.firstName = expertProfile.firstName;
        bookingItem.consult!.lastName = expertProfile.lastName;
        bookingItem.consult!.photoUrl = expertProfile.photoUrl;
      }
    }

    final ConfettiController confettiController = ConfettiController(
      duration: Duration(seconds: 2),
    );

    confettiController.play();
    return PopScope(
      canPop: false,

      child: Scaffold(
        bottomNavigationBar: ConfirmDateTimeButton(
          onTap: () {
            Get.offAllNamed(RoutesConstant.mainScreen);
          },
          title: 'Go to Home',
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
                  SizedBox(height: height * 0.1),
                  MobileVerificationProgressContainer(
                    progress: 1,
                    image: AppImages.check,
                    imageSize: 34,
                    color: AppColors.black,
                  ),
                  SizedBox(),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      ConfettiWidget(
                        confettiController: confettiController,
                        blastDirectionality: BlastDirectionality.explosive,
                        blastDirection: 0,
                        emissionFrequency: 0.065,
                        numberOfParticles: 40,
                        maxBlastForce: 5,
                        minBlastForce: 2,
                        gravity: 0,
                        colors: [
                          Colors.red,
                          Colors.blue,
                          Colors.green,
                          Colors.orange,
                          Colors.purple,
                          Colors.yellow,
                        ],
                        shouldLoop: false,
                      ),
                      CustomText(
                        text: 'Thank you!',
                        color: AppColors.primaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),

                  CustomRichText(
                    text1: 'Your booking request has been sent to ',
                    color1: AppColors.black,
                    fontSize1: 14,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center,
                    text2: '$expertName, ',
                    color2: AppColors.primaryColor,
                    fontSize2: 14,
                    text3:
                        'we’ll notify you once the session has been confirmed.',
                  ),
                  SizedBox(height: height * 0.02),
                  DiscussionContainer(bookingItem: bookingItem, isMeView: true),

                  SizedBox(height: height * 0.05),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
