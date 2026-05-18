// ignore_for_file: deprecated_member_use

import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/share_preference/auth_preference.dart';
import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:consultz/feature/Auth/controller/set_key_expertise_controller.dart';
import 'package:consultz/feature/discover/controller/discover_controller.dart';
import 'package:consultz/feature/home/controller/interest_expert_controller.dart';
import 'package:consultz/feature/home/controller/property_expert_controller.dart';
import 'package:consultz/feature/home/controller/top_expert_controller.dart';
import 'package:consultz/feature/main/model/main_page_data.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/feature/Auth/controller/browse_first_controller.dart';
import 'package:consultz/feature/main/controller/main_controller.dart';
import 'package:consultz/feature/main/widgets/referral_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showcaseview/showcaseview.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final mainController = Get.find<MainController>();
  final browseFirstController = Get.find<BrowseFirstController>();
  final profileController = Get.find<ProfileController>();
  final args = Get.arguments as bool?;
  final discoverController = Get.find<DiscoverController>();
  final interestExpertController = Get.find<InterestExpertController>();
  final propertyExpertController = Get.find<PropertyExpertController>();
  final topExpertController = Get.find<TopExpertController>();
  final setKeyExpertiseController = Get.find<SetKeyExpertiseController>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _apiCalling();
      if (AuthPreference.isReferralDialogShown == false) {
        referralDialog(context: context);
      }
    });
  }

  void _apiCalling() {
    profileController.getMyProfile();
    setKeyExpertiseController.getAllCategory(context, isLoading: false);
    if (interestExpertController.expertList.isEmpty) {
      interestExpertController.getInterestExpert();
    }
    if (propertyExpertController.expertList.isEmpty) {
      propertyExpertController.getPropertyExpert();
    }
    if (topExpertController.expertList.isEmpty) {
      topExpertController.getTopExpert();
    }
    if (discoverController.contentList.isEmpty) {
      discoverController.initialLoad();
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    return ShowCaseWidget(
      builder: (context) => Scaffold(
        body: Obx(() {
          if (browseFirstController.isConsultee.value) {
            return MainPageData.consulteePages[mainController.curentIndex.value];
          } else {
            return MainPageData.expertPages[mainController.curentIndex.value];
          }
        }),
        bottomNavigationBar: Obx(() {
          return BottomNavigationBar(
            currentIndex: mainController.curentIndex.value,
            selectedItemColor: AppColors.primaryColor,
            unselectedItemColor: AppColors.darkGrey,
            showUnselectedLabels: true,
            onTap: (index) {
              mainController.changeIndex(index: index);
            },
            selectedLabelStyle: GoogleFonts.figtree(
              fontSize: scaleFactor * 12,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor,
              letterSpacing: 0.4,
            ),
            unselectedLabelStyle: GoogleFonts.figtree(
              fontSize: scaleFactor * 12,
              fontWeight: FontWeight.w500,
              color: AppColors.darkGrey,
              letterSpacing: 0.4,
            ),
            elevation: 8,
            items: [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.symmetric(vertical: height * 0.005),
                  child: ImageIcon(
                    AssetImage(AppImages.home),
                    size: scaleFactor * 19,
                  ),
                ),
                label: "Home",
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.symmetric(vertical: height * 0.005),
                  child: ImageIcon(
                    AssetImage(AppImages.bookings),
                    size: scaleFactor * 17,
                  ),
                ),
                label: 'Bookings',
                backgroundColor: Colors.white,
              ),
              if (!browseFirstController.isConsultee.value)
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.005),
                    child: ImageIcon(
                      AssetImage(AppImages.post),
                      size: scaleFactor * 18,
                    ),
                  ),
                  label: 'Post',
                  backgroundColor: Colors.white,
                ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.symmetric(vertical: height * 0.005),
                  child: ImageIcon(
                    AssetImage(AppImages.discover),
                    size: scaleFactor * 19,
                  ),
                ),
                label: "Discover",
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.symmetric(vertical: height * 0.005),
                  child: ImageIcon(
                    AssetImage(AppImages.profile),
                    size: scaleFactor * 19,
                  ),
                ),
                label: "Profile",
                backgroundColor: Colors.white,
              ),
            ],
          );
        }),
      ),
    );
  }
}
