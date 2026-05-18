import 'dart:async';
import 'package:consultz/core/services/deep_link_service.dart';

import 'package:consultz/core/utils/loading.dart/gradient_fading_circle.dart';
import 'package:consultz/core/utils/share_preference/auth_preference.dart';
import 'package:consultz/feature/Auth/controller/browse_first_controller.dart';
import 'package:consultz/feature/main/controller/main_controller.dart';
import 'package:consultz/feature/splash/controller/connection_checker_controller.dart';
import 'package:consultz/feature/splash/pages/no_internet_screen.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/share_preference/call_preference.dart';
import 'package:consultz/feature/call/controller/call_service_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final connection = Get.find<ConnectionCheckerController>();
  final browseFirstController = Get.find<BrowseFirstController>();
  bool _isNavigated = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _initializeSharePreference();
      
      // If already has internet, proceed
      if (connection.hasInternet.value && mounted) {
        _routeNextPage();
      }

      // Also listen for changes
      ever(connection.hasInternet, (bool hasInternet) {
        if (hasInternet && mounted) {
          _routeNextPage();
        }
      });
    });
  }

  Future<void> _initializeSharePreference() async {
    browseFirstController.isConsultee.value =
        AuthPreference.logInInfo?.data?.user?.role == 'expert' ? false : true;
  }

  void _routeNextPage() {
    if (_isNavigated) return;
    
    Timer(Duration(milliseconds: 1500), () async {
      if (_isNavigated) return;
      _isNavigated = true;

      // Check if there is a pending call from CallKit/Terminated state
      final pendingCall = await CallPreference.getPendingCall();
      if (pendingCall != null) {
        if (Get.isRegistered<CallServiceController>()) {
          Get.find<CallServiceController>().handlePendingCallNavigation(pendingCall);
          return;
        }
      }

      if (AuthPreference.logInToken != null) {
        final role = AuthPreference.logInInfo?.data?.user?.role;

        // expert এর জন্য প্রোফাইল সেটআপ চেক করা হবে
        if (role == 'expert') {
          final isProfileSetup =
              AuthPreference.logInInfo?.data?.user?.isProfileSetup;
          if (isProfileSetup == null || isProfileSetup == false) {
            Get.offAllNamed(RoutesConstant.socialProfileScreen);
            return;
          }
        }

        // consult এর জন্য প্রোফাইল সেটআপ চেক করা হবে
        if (role == 'consult') {
          final isProfileSetup =
              AuthPreference.logInInfo?.data?.user?.isProfileSetup;
          if (isProfileSetup == null || isProfileSetup == false) {
            Get.offAllNamed(RoutesConstant.timeZoneScreen);
            return;
          }
        }

        Get.offAllNamed(RoutesConstant.mainScreen);
        if (!browseFirstController.isConsultee.value) {
          Get.find<MainController>().changeIndex(index: 4);
        }
      } else {
        Get.offAllNamed(RoutesConstant.browseFirstScreen);
      }
      DeepLinkService.to.handlePendingLink();
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = Screen.screenHeight(context);
    final width = Screen.screenWidth(context);
    final scaleFactor = width / Screen.designWidth;
    return Obx(() {
      if (!connection.hasInternet.value) {
        return NoInternetScreen();
      }
      return Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.36),
              Center(
                child: Image.asset(AppImages.logo, width: scaleFactor * 167),
              ),
              Spacer(),
              GradientFadingCircle(),
              SizedBox(height: height * 0.03),
            ],
          ),
        ),
      );
    });
  }
}
