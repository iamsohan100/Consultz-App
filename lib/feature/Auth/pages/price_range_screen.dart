import 'package:consultz/feature/Auth/controller/price_range_controller.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/widgets/app_bar_coin.dart';
import 'package:consultz/feature/Auth/widgets/filling_steps.dart';
import 'package:consultz/feature/Auth/widgets/mobile_verification_progress_container.dart';
import 'package:consultz/feature/Auth/widgets/price_range_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PriceRangeScreen extends StatefulWidget {
  const PriceRangeScreen({super.key});

  @override
  State<PriceRangeScreen> createState() => _PriceRangeScreenState();
}

class _PriceRangeScreenState extends State<PriceRangeScreen> {
  RangeValues _currentRangeValues = RangeValues(10, 150);
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    return Scaffold(
      appBar: customAppBar(
        title: '',
        context: context,
        actions: [
          AppBarCoin(),
          SizedBox(width: width * 0.04),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SafeArea(
        bottom: true,
        top: false,
        left: false,
        right: false,
        child: Padding(
          padding: EdgeInsets.all(scaleFactor * 20),
          child: PrimaryButton(
            onPressed: () => continu(
              context,
              '${_currentRangeValues.start.toInt()}-${_currentRangeValues.end.toInt()}',
            ),
            title: 'Set price range',
          ),
        ),
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
                FillingSteps(currentScreen: 3),
                SizedBox(),
                MobileVerificationProgressContainer(
                  progress: 1,
                  image: AppImages.priceRange,
                  imageSize: 31,
                ),
                SizedBox(),
                CustomText(
                  text: "Set your price range",
                  color: AppColors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.center,
                ),
                CustomText(
                  text:
                      "Adjust the scale to set the top price you would pay for an hour long consultation call. ",
                  color: AppColors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.center,
                  lineHeight: 1.6,
                ),
                CustomText(
                  text:
                      'This will help us show you the right experts. The amount can be changed in your settings and the search filter options. ',
                  color: AppColors.darkGrey,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.center,
                  lineHeight: 1.6,
                ),
                PriceRangeSlider(
                  values: _currentRangeValues,
                  onChanged: (RangeValues values) {
                    setState(() {
                      _currentRangeValues = values;
                    });
                  },
                ),

                SizedBox(height: height * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> continu(BuildContext context, String priceRange) async {
  final priceRangeController = Get.find<PriceRangeController>();

  final response = await priceRangeController.setPriceRange(
    context,
    priceRange,
  );
  if (response) {
    Get.toNamed(RoutesConstant.uploadProfilePictureScreen);
  }
}
