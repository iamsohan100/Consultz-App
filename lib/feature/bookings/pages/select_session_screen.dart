import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/feature/bookings/controller/booking_controller.dart';
import 'package:consultz/feature/bookings/widgets/session_shimmer.dart';
import 'package:consultz/feature/expert/controller/expert_profile_controller.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/feature/bookings/model/session_data.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/widgets/mobile_verification_progress_container.dart';
import 'package:consultz/feature/bookings/widgets/booking_steps.dart';
import 'package:consultz/feature/bookings/widgets/confirm_date_time_button.dart';
import 'package:consultz/feature/bookings/widgets/session_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectSessionScreen extends StatefulWidget {
  const SelectSessionScreen({super.key});

  @override
  State<SelectSessionScreen> createState() => _SelectSessionScreenState();
}

class _SelectSessionScreenState extends State<SelectSessionScreen> {
  RxInt selectedIndex = (-1).obs;
  final String expertId = (Get.arguments ?? '').toString();
  final expertProfileController = Get.find<ExpertProfileController>();
  final bookingController = Get.find<BookingController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (expertId.isNotEmpty) {
        expertProfileController.getExpertProfile(id: expertId);
      } else {
        bottomMessage(msg: 'Expert ID not found');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    return Scaffold(
      appBar: customAppBar(title: '', context: context),
      bottomNavigationBar: ConfirmDateTimeButton(
        onTap: () {
          _onConfirmButtonTap();
        },
      ),
      body: SafeArea(
        child: Obx(() {
          final expertProfile =
              expertProfileController.expertProfileModel.value.data;
          final sessionList = expertProfile?.sessionDurations ?? [];
          final expertName =
              "${expertProfile?.firstName ?? ''} ${expertProfile?.lastName ?? ''}"
                  .trim();

          return SingleChildScrollView(
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
                  BookingSteps(currentScreen: 1),
                  SizedBox(),
                  MobileVerificationProgressContainer(
                    progress: 0.2,
                    image: AppImages.timeZone,
                    imageSize: 30,
                    color: AppColors.black,
                  ),
                  SizedBox(),
                  CustomText(
                    text: 'Select a session',
                    color: AppColors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.center,
                  ),
                  CustomText(
                    text:
                        'Select the session you’d like to book\nwith $expertName',
                    color: AppColors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center,
                    lineHeight: 1.6,
                  ),
                  SizedBox(height: height * 0.02),
                  if (expertProfileController.inProgress.value)
                    const SessionShimmer(length: 4)
                  else
                    ListView.separated(
                      primary: false,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: sessionList.length,
                      itemBuilder: (_, index) {
                        final session = sessionList[index];
                        return Obx(() {
                          return GestureDetector(
                            onTap: () {
                              selectedIndex.value = index;
                            },
                            child: SessionContainer(
                              sessionModel: SessionModel(
                                title: session.type ?? '',
                                duration: session.duration ?? 0,
                                amount: '€${session.price ?? ''}',
                              ),
                              isSelected: (selectedIndex.value == index).obs,
                            ),
                          );
                        });
                      },
                      separatorBuilder: (_, _) {
                        return SizedBox(height: height * 0.012);
                      },
                    ),
                  SizedBox(height: height * 0.1),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Future<void> _onConfirmButtonTap() async {
    if (selectedIndex.value != -1) {
      final expertProfile =
          expertProfileController.expertProfileModel.value.data;
      final session = expertProfile?.sessionDurations?[selectedIndex.value];

      if (session != null) {
        String type = (session.type ?? '').toLowerCase().replaceAll(' ', '_');

        bookingController.setSessionDetails(
          type: type,
          duration: session.duration ?? 0,
          priceAmount: (session.price is int)
              ? session.price
              : (double.tryParse(session.price.toString())?.toInt() ?? 0),
          expertId: expertId,
        );
        Get.toNamed(RoutesConstant.selectDateAndTimeScreen);
      }
    } else {
      bottomMessage(msg: 'Please select a session');
    }
  }
}
