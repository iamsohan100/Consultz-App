import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:consultz/feature/bookings/controller/booking_controller.dart';
import 'package:consultz/feature/bookings/controller/payment_controller.dart';
import 'package:consultz/feature/expert/controller/expert_profile_controller.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/form_field/custom_form_field.dart';
import 'package:consultz/core/utils/text/custom_rich_text.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/widgets/mobile_verification_progress_container.dart';
import 'package:consultz/feature/bookings/widgets/booking_steps.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrepQuestionsScreen extends StatefulWidget {
  const PrepQuestionsScreen({super.key});

  @override
  State<PrepQuestionsScreen> createState() => _PrepQuestionsScreenState();
}

class _PrepQuestionsScreenState extends State<PrepQuestionsScreen> {
  final bookingController = Get.find<BookingController>();
  final expertProfileController = Get.find<ExpertProfileController>();
  final paymentController = Get.find<PaymentController>();
  static const int _maxChars = 300;

  int _mainCharsLeft = _maxChars;
  int _challengeCharsLeft = _maxChars;
  int _backgroundCharsLeft = _maxChars;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    bookingController.mainQuestionController.addListener(_onMainTextChanged);
    bookingController.challengeQuestionController.addListener(
      _onChallengeTextChanged,
    );
    bookingController.backgroundQuestionController.addListener(
      _onBackgroundTextChanged,
    );

    // Initial counts
    _updateCounts();
  }

  void _updateCounts() {
    setState(() {
      _mainCharsLeft =
          _maxChars - bookingController.mainQuestionController.text.length;
      _challengeCharsLeft =
          _maxChars - bookingController.challengeQuestionController.text.length;
      _backgroundCharsLeft =
          _maxChars -
          bookingController.backgroundQuestionController.text.length;
    });
  }

  void _onMainTextChanged() => _handleTextChange(
    bookingController.mainQuestionController,
    (val) => _mainCharsLeft = val,
  );
  void _onChallengeTextChanged() => _handleTextChange(
    bookingController.challengeQuestionController,
    (val) => _challengeCharsLeft = val,
  );
  void _onBackgroundTextChanged() => _handleTextChange(
    bookingController.backgroundQuestionController,
    (val) => _backgroundCharsLeft = val,
  );

  void _handleTextChange(
    TextEditingController controller,
    Function(int) updateVal,
  ) {
    final text = controller.text;
    if (text.length > _maxChars) {
      final trimmed = text.substring(0, _maxChars);
      controller.value = TextEditingValue(
        text: trimmed,
        selection: TextSelection.collapsed(offset: trimmed.length),
      );
      setState(() => updateVal(0));
    } else {
      setState(() => updateVal(_maxChars - text.length));
    }
  }

  @override
  void dispose() {
    bookingController.mainQuestionController.removeListener(_onMainTextChanged);
    bookingController.challengeQuestionController.removeListener(
      _onChallengeTextChanged,
    );
    bookingController.backgroundQuestionController.removeListener(
      _onBackgroundTextChanged,
    );
    super.dispose();
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

    return Scaffold(
      appBar: customAppBar(title: '', context: context),
      // bottomNavigationBar: ConfirmDateTimeButton(onTap: _confirm),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.only(
              top: scaleFactor * 8,
              left: scaleFactor * 20,
              right: scaleFactor * 20,
              bottom: scaleFactor * 20,
            ),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: height * 0.016,
                children: [
                  BookingSteps(currentScreen: 3),
                  SizedBox(),
                  MobileVerificationProgressContainer(
                    progress: 0.8,
                    image: AppImages.prq,
                    imageSize: 32,
                    color: AppColors.black,
                  ),
                  SizedBox(),
                  CustomText(
                    text: 'Prep questions',
                    color: AppColors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.center,
                  ),
                  CustomRichText(
                    text1: 'To make the most of your discussion session with',
                    color1: AppColors.black,
                    fontSize1: 14,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center,
                    text2: ' $expertName, ',
                    color2: AppColors.primaryColor,
                    fontSize2: 14,
                    text3: 'please answer the three questions below',
                  ),
                  SizedBox(height: height * 0.01),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: height * 0.016,
                    children: [
                      CustomRichText(
                        text1: '1. ',
                        color1: AppColors.primaryColor,
                        fontSize1: 14,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.center,
                        text2: 'What is the main question you’d like answered?',
                        color2: AppColors.black,
                        fontSize2: 14,
                        // fontWeight2: FontWeight.w400,
                      ),
                      CustomFormField(
                        controller: bookingController.mainQuestionController,
                        minLine: 4,
                        maxLine: 4,
                        padding: scaleFactor * 10,
                        horPadding: scaleFactor * 10,
                        hintText: 'Please respond to question one here.',
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: CustomText(
                          text: '$_mainCharsLeft left',
                          color: _mainCharsLeft == 0
                              ? AppColors.red
                              : AppColors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(),
                      CustomRichText(
                        text1: '2. ',
                        color1: AppColors.primaryColor,
                        fontSize1: 14,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.center,
                        text2: 'What challenges or roadblocks are you facing?',
                        color2: AppColors.black,
                        fontSize2: 14,
                        // fontWeight2: FontWeight.w400,
                      ),
                      CustomFormField(
                        controller:
                            bookingController.challengeQuestionController,
                        minLine: 4,
                        maxLine: 4,
                        padding: scaleFactor * 10,
                        horPadding: scaleFactor * 10,
                        hintText: 'Please respond to question two here.',
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: CustomText(
                          text: '$_challengeCharsLeft left',
                          color: _challengeCharsLeft == 0
                              ? AppColors.red
                              : AppColors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(),
                      CustomRichText(
                        text1: '3. ',
                        color1: AppColors.primaryColor,
                        fontSize1: 14,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.center,
                        text2: 'Can you share some background or context?',
                        color2: AppColors.black,
                        fontSize2: 14,
                        // fontWeight2: FontWeight.w400,
                      ),
                      CustomFormField(
                        controller:
                            bookingController.backgroundQuestionController,
                        minLine: 4,
                        maxLine: 4,
                        padding: scaleFactor * 10,
                        horPadding: scaleFactor * 10,
                        hintText: 'Please respond to question three here.',
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: CustomText(
                          text: '$_backgroundCharsLeft left',
                          color: _backgroundCharsLeft == 0
                              ? AppColors.red
                              : AppColors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      CustomText(
                        text:
                            'Once the session has been confirmed–you’ll be able to edit these answers up to 24 hours before the scheduled session.',
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.02),
                  PrimaryButton(title: 'Confirm', onPressed: _confirm),
                  SizedBox(height: height * 0.05),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _confirm() async {
    if (formKey.currentState!.validate()) {
      final response = await bookingController.createBooking(context);
      if (response) {
        final profileController = Get.find<ProfileController>();
        final accountId = profileController.expertProfileModel.value.data?.sId;
        final bookingId = bookingController.createdBookingData.value?.sId;

        if (accountId != null && bookingId != null) {
          final checkoutSuccess = await paymentController.checkout(
            context: context,
            account: accountId,
            booking: bookingId,
          );
          if (checkoutSuccess) {
            final paymentSuccess = await paymentController.makePayment(
              amount: (bookingController.price.value * 100).toString(),
              currency: 'USD',
            );

            if (paymentSuccess) {
              final confirmSuccess = await paymentController.confirmPayment(
                context: context,
                paymentIntentId: paymentController.paymentIntentId.value,
                booking: bookingId,
                user: accountId,
              );
              if (confirmSuccess) {
                Get.offAllNamed(RoutesConstant.thankYouScreen);
              }
            }
          }
        }
      }
    }
  }
}
