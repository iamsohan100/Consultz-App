import 'package:consultz/feature/expert/controller/terms_condition_controller.dart';
import 'package:consultz/feature/shome_me_expert/controller/show_me_expert_category_controller.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/feature/Auth/model/browse_first_page_model.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/widgets/browse_container.dart';
import 'package:consultz/feature/Auth/widgets/have_account.dart';
import 'package:consultz/core/utils/helpers/notification_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrowseFirstScreen extends StatefulWidget {
  const BrowseFirstScreen({super.key});

  @override
  State<BrowseFirstScreen> createState() => _BrowseFirstScreenState();
}

class _BrowseFirstScreenState extends State<BrowseFirstScreen>
    with WidgetsBindingObserver {
  final termsConditionController = Get.find<TermsConditionController>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      termsConditionController.getTermsCondition(context, isLoading: false);
      _checkNotificationPermission();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkNotificationPermission();
    }
  }

  void _checkNotificationPermission() async {
    bool isGranted = await NotificationHelper.checkPermission();
    if (!isGranted) {
      if (!Get.isDialogOpen!) {
        _showPermissionDialog();
      }
    } else {
      if (Get.isDialogOpen!) {
        Get.back();
      }
    }
  }

  void _showPermissionDialog() {
    Get.dialog(
      PopScope(
        canPop: false,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: CustomText(
            text: 'Notification Required',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
            color: AppColors.black,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.notifications_active,
                size: 60,
                color: AppColors.primaryColor,
              ),
              SizedBox(height: 20),
              CustomText(
                text:
                    'Notifications are essential for receiving important calls and updates. Please allow notification access to continue.',
                fontSize: 14,
                textAlign: TextAlign.center,
                color: AppColors.black.withValues(alpha: 0.7),
                fontWeight: .w400,
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: PrimaryButton(
                onPressed: () async {
                  bool granted =
                      await NotificationHelper.requestNotificationPermission();
                  if (granted) {
                    Get.back();
                  } else {
                    // If still not granted, they might have clicked 'Deny' or closed settings
                    // The user said "repeatedly ask", so we keep it open or show again
                    // requestNotificationPermission already calls openAppSettings if permanently denied.
                  }
                },
                title: 'Allow Notifications',
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SafeArea(
        bottom: true,
        top: false,
        left: false,
        right: false,
        child: Padding(
          padding: EdgeInsets.all(scaleFactor * 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PrimaryButton(
                onPressed: () {
                  showMeExpert(context);
                },
                title: 'Not yet, show me the experts',
                backgroundColor: AppColors.white,
                borderColor: AppColors.primaryColor,
                textColor: AppColors.primaryColor,
              ),
              SizedBox(height: height * 0.012),
              PrimaryButton(
                onPressed: () {
                  Get.toNamed(RoutesConstant.consulteeOnboarding1);
                },
                title: 'Join now',
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(scaleFactor * 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                SizedBox(height: height * 0.01),
                CustomText(
                  text: 'How do you want to join?',
                  color: AppColors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(height: height * 0.04),
                ListView.separated(
                  primary: false,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: BrowseFirstPageModel.browseData.length,
                  itemBuilder: (_, index) {
                    return BrowseContainer(
                      browseModel: BrowseFirstPageModel.browseData[index],
                    );
                  },
                  separatorBuilder: (_, _) {
                    return SizedBox(height: height * 0.03);
                  },
                ),
                SizedBox(height: height * 0.025),
                HaveAccount(),
                SizedBox(height: height * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> showMeExpert(BuildContext context) async {
  final showMeExpertCategoryController =
      Get.find<ShowMeExpertCategoryController>();

  final response = await showMeExpertCategoryController.getAllCategory(context);
  if (response) {
    Get.toNamed(RoutesConstant.showMeExpertCategoryScreen);
  }
}
