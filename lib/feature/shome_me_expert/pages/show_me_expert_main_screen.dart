import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/feature/main/widgets/login_restriction_dialog.dart';
import 'package:consultz/feature/shome_me_expert/controller/show_me_expert_interest_controller.dart';
import 'package:consultz/feature/shome_me_expert/controller/show_me_expert_property_controller.dart';
import 'package:consultz/feature/shome_me_expert/controller/show_me_expert_top_controller.dart';
import 'package:consultz/feature/shome_me_expert/pages/show_me_expert_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowMeExpertMainScreen extends StatefulWidget {
  const ShowMeExpertMainScreen({super.key});

  @override
  State<ShowMeExpertMainScreen> createState() => _ShowMeExpertMainScreenState();
}

class _ShowMeExpertMainScreenState extends State<ShowMeExpertMainScreen> {
  final interestExpertController = Get.find<ShowMeExpertInterestController>();
  final propertyExpertController = Get.find<ShowMeExpertPropertyController>();
  final topExpertController = Get.find<ShowMeExpertTopController>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _apiCalling();
    });
  }

  void _apiCalling() {
    interestExpertController.getInterestExpert();

    propertyExpertController.getPropertyExpert();

    topExpertController.getTopExpert();
  }

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    return Stack(
      children: [
        Scaffold(
          body: ShowMeExpertHomeScreen(),

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: 0,
            selectedItemColor: AppColors.primaryColor,
            unselectedItemColor: AppColors.darkGrey,
            showUnselectedLabels: true,
            onTap: (index) {
              loginRestrictionDialog(context: context);
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
          ),
        ),
        Positioned.fill(
          bottom:
              kBottomNavigationBarHeight +
              MediaQuery.of(context).padding.bottom,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              loginRestrictionDialog(context: context);
            },
            child: const SizedBox.expand(),
          ),
        ),
      ],
    );
  }
}
