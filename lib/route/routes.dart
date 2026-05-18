import 'package:consultz/feature/Auth/pages/forget_password_screen.dart';
import 'package:consultz/feature/Auth/pages/forgot_email_verification_screen.dart';
import 'package:consultz/feature/Auth/pages/reset_password_screen.dart';
import 'package:consultz/feature/Auth/pages/stripe_webview_screen.dart';
import 'package:consultz/feature/Auth/pages/interested_sub_category_screen.dart';
import 'package:consultz/feature/bookings/pages/booking_reschedule_screen.dart';
import 'package:consultz/feature/bookings/pages/msg_screen.dart';
import 'package:consultz/feature/discover/pages/search_content_screen.dart';
import 'package:consultz/feature/home/pages/search_expert_screen.dart';
import 'package:consultz/feature/expert/pages/edit_expert_language_screen.dart';
import 'package:consultz/feature/expert/pages/edit_expert_sub_category_screen.dart';
import 'package:consultz/feature/profile/pages/connect_strype_screen.dart';
import 'package:consultz/feature/profile/pages/support_screen.dart';
import 'package:consultz/feature/profile/pages/update_job_role_screen.dart';
import 'package:consultz/feature/profile/pages/update_name_screen.dart';
import 'package:consultz/feature/shome_me_expert/pages/show_me_expert_category_screen.dart';
import 'package:consultz/feature/shome_me_expert/pages/show_me_expert_learning_style_screen.dart';
import 'package:consultz/feature/shome_me_expert/pages/show_me_expert_loading_screen.dart';
import 'package:consultz/feature/shome_me_expert/pages/show_me_expert_main_screen.dart';
import 'package:consultz/feature/shome_me_expert/pages/show_me_expert_sub_category_screen.dart';
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/feature/Auth/pages/expert_advising_style_screen.dart';
import 'package:consultz/feature/Auth/pages/expert_calendar_screen.dart';
import 'package:consultz/feature/Auth/pages/expert_schedule_screen.dart';
import 'package:consultz/feature/Auth/pages/expert_skills_screen.dart';
import 'package:consultz/feature/Auth/pages/expert_time_zone_screen.dart';
import 'package:consultz/feature/Auth/pages/fill_mobile_data_screen.dart';
import 'package:consultz/feature/Auth/pages/interested_screen.dart';
import 'package:consultz/feature/Auth/pages/key_expertise_screen.dart';
import 'package:consultz/feature/Auth/pages/learning_style_screen.dart';
import 'package:consultz/feature/Auth/pages/loading_screen.dart';
import 'package:consultz/feature/Auth/pages/login_screen.dart';
import 'package:consultz/feature/Auth/pages/otp_verification_screen.dart';
import 'package:consultz/feature/Auth/pages/password_screen.dart';
import 'package:consultz/feature/Auth/pages/price_range_screen.dart';
import 'package:consultz/feature/Auth/pages/profile_so_far_screen.dart';
import 'package:consultz/feature/Auth/pages/set_bank_screen.dart';
import 'package:consultz/feature/Auth/pages/set_rate_screen.dart';
import 'package:consultz/feature/Auth/pages/sign_up_screen.dart';
import 'package:consultz/feature/Auth/pages/social_profile_screen.dart';
import 'package:consultz/feature/Auth/pages/time_zone_screen.dart';
import 'package:consultz/feature/Auth/pages/update_bio_screen.dart';
import 'package:consultz/feature/Auth/pages/upload_profile_picture_screen.dart';
import 'package:consultz/feature/bookings/pages/booking_details_screen.dart';
import 'package:consultz/feature/bookings/pages/prep_questions_screen.dart';
import 'package:consultz/feature/bookings/pages/select_date_and_time_screen.dart';
import 'package:consultz/feature/bookings/pages/select_session_screen.dart';
import 'package:consultz/feature/bookings/pages/thank_you_screen.dart';
import 'package:consultz/feature/discover/pages/full_screen_content.dart';
import 'package:consultz/feature/expert/pages/calendar_screen.dart';
import 'package:consultz/feature/expert/pages/earning_screen.dart';
import 'package:consultz/feature/expert/pages/edit_education_screen.dart';
import 'package:consultz/feature/expert/pages/edit_expert_bio_screen.dart';
import 'package:consultz/feature/expert/pages/edit_expert_category_screen.dart';
import 'package:consultz/feature/expert/pages/edit_social_profile_screen.dart';
import 'package:consultz/feature/expert/pages/expert_dashboard_screen.dart';
import 'package:consultz/feature/expert/pages/expert_details_screen.dart';
import 'package:consultz/feature/expert/pages/followers_screen.dart';
import 'package:consultz/feature/expert/pages/specific_expert_screen.dart';
import 'package:consultz/feature/expert/pages/terms_conditon_screen.dart';
import 'package:consultz/feature/filter/pages/filter_availability_screen.dart';
import 'package:consultz/feature/filter/pages/filter_interests_screen.dart';
import 'package:consultz/feature/filter/pages/filter_learning_style_screen.dart';
import 'package:consultz/feature/filter/pages/filter_screen.dart';
import 'package:consultz/feature/main/pages/main_screen.dart';
import 'package:consultz/feature/notification/pages/notification_screen.dart';
import 'package:consultz/feature/onboard/pages/consultee_onboarding_1.dart';
import 'package:consultz/feature/onboard/pages/consultee_onboarding_2.dart';
import 'package:consultz/feature/onboard/pages/consultee_onboarding_3.dart';
import 'package:consultz/feature/Auth/pages/browse_first_screen.dart';
import 'package:consultz/feature/onboard/pages/expert_onboarding_3.dart';
import 'package:consultz/feature/post/pages/post_screen.dart';
import 'package:consultz/feature/profile/pages/blocked_user_screen.dart';
import 'package:consultz/feature/profile/pages/booking_history_details_screen.dart';
import 'package:consultz/feature/profile/pages/booking_history_screen.dart';
import 'package:consultz/feature/profile/pages/change_password_screen.dart';
import 'package:consultz/feature/profile/pages/delete_account_screen.dart';
import 'package:consultz/feature/profile/pages/following_screen.dart';
import 'package:consultz/feature/profile/pages/notification_setting_screen.dart';
import 'package:consultz/feature/profile/pages/edit_phone_number_verify_screen.dart';
import 'package:consultz/feature/profile/pages/edit_phone_number_screen.dart';
import 'package:consultz/feature/profile/pages/password_and_security_screen.dart';
import 'package:consultz/feature/profile/pages/saved_login_screen.dart';
import 'package:consultz/feature/comming/pages/comming_soon_screen.dart';
import 'package:consultz/feature/splash/pages/splash_screen.dart';
import 'package:consultz/feature/discover/pages/feed_detail_screen.dart';
import 'package:get/get.dart';

class Routes {
  static List<GetPage> routes = [
    GetPage(
      name: '/',
      page: () => const SplashScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.splashScreen,
      page: () => const SplashScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.browseFirstScreen,
      page: () => const BrowseFirstScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.consulteeOnboarding1,
      page: () => const ConsulteeOnboarding1(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.consulteeOnboarding2,
      page: () => const ConsulteeOnboarding2(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.consulteeOnboarding3,
      page: () => const ConsulteeOnboarding3(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.loginScreen,
      page: () => const LoginScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.signUpScreen,
      page: () => const SignUpScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.passwordScreen,
      page: () => const PasswordScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.fillMobileDataScreen,
      page: () => const FillMobileDataScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.otpVerificationScreen,
      page: () => const OtpVerificationScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.timeZoneScreen,
      page: () => const TimeZoneScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.priceRangeScreen,
      page: () => const PriceRangeScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.uploadProfilePictureScreen,
      page: () => const UploadProfilePictureScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.profileSoFarScreen,
      page: () => const ProfileSoFarScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.interestedScreen,
      page: () => const InterestedScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.learningStyleScreen,
      page: () => const LearningStyleScreen(),
      transition: Transition.fadeIn,
    ),
    // GetPage(
    //   name: RoutesConstant.availabilityScreen,
    //   page: () => const AvailabilityScreen(),
    //   transition: Transition.fadeIn,
    // ),
    GetPage(
      name: RoutesConstant.loadingScreen,
      page: () => const LoadingScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.mainScreen,
      page: () => const MainScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.filterScreen,
      page: () => const FilterScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.filterAvailabilityScreen,
      page: () => const FilterAvailabilityScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.filterLearningStyleScreen,
      page: () => const FilterLearningStyleScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.filterInterestsScreen,
      page: () => const FilterInterestsScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.specificExpertScreen,
      page: () => const SpecificExpertScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.expertDetailsScreen,
      page: () => const ExpertDetailsScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.editPhoneNumberScreen,
      page: () => const EditPhoneNumberScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.editPhoneNumberVerifyScreen,
      page: () => const EditPhoneNumberVerifyScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.notificationSettingScreen,
      page: () => const NotificationSettingScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.passwordAndSecurityScreen,
      page: () => const PasswordAndSecurityScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.changePasswordScreen,
      page: () => const ChangePasswordScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.savedLoginScreen,
      page: () => const SavedLoginScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.blockedUserScreen,
      page: () => const BlockedUserScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.deleteAccountScreen,
      page: () => const DeleteAccountScreen(),
      transition: Transition.fadeIn,
    ),
    // GetPage(
    //   name: RoutesConstant.paymentDetailsScreen,
    //   page: () => const PaymentDetailsScreen(),
    //   transition: Transition.fadeIn,
    // ),
    // GetPage(
    //   name: RoutesConstant.addPaymentMethodScreen,
    //   page: () => const AddPaymentMethodScreen(),
    //   transition: Transition.fadeIn,
    // ),
    GetPage(
      name: RoutesConstant.followingScreen,
      page: () => const FollowingScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.bookingHistoryScreen,
      page: () => const BookingHistoryScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.bookingHistoryDetailsScreen,
      page: () => const BookingHistoryDetailsScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.notificationScreen,
      page: () => const NotificationScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.fullScreenContent,
      page: () => const FullScreenContent(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.selectSessionScreen,
      page: () => const SelectSessionScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.selectDateAndTimeScreen,
      page: () => const SelectDateAndTimeScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.prepQuestionsScreen,
      page: () => const PrepQuestionsScreen(),
      transition: Transition.fadeIn,
    ),
    // GetPage(
    //   name: RoutesConstant.bookingPaymentMethodScreen,
    //   page: () => BookingPaymentMethodScreen(),
    //   transition: Transition.fadeIn,
    // ),
    GetPage(
      name: RoutesConstant.thankYouScreen,
      page: () => const ThankYouScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.expertOnboarding3,
      page: () => const ExpertOnboarding3(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.socialProfileScreen,
      page: () => const SocialProfileScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.setRateScreen,
      page: () => const SetRateScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.setBankScreen,
      page: () => const SetBankScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.keyExpertiseScreen,
      page: () => const KeyExpertiseScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.updateBioScreen,
      page: () => const UpdateBioScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.expertSkillsScreen,
      page: () => const ExpertSkillsScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.expertAdvisingStyleScreen,
      page: () => const ExpertAdvisingStyleScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.expertTimeZoneScreen,
      page: () => const ExpertTimeZoneScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.expertScheduleScreen,
      page: () => const ExpertScheduleScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.expertCalendarScreen,
      page: () => const ExpertCalendarScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.followersScreen,
      page: () => const FollowersScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.expertDashboardScreen,
      page: () => const ExpertDashboardScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.calendarScreen,
      page: () => const CalendarScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.editExpertCategoryScreen,
      page: () => const EditExpertCategoryScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.editExpertBioScreen,
      page: () => const EditExpertBioScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.editEducationScreen,
      page: () => const EditEducationScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.editSocialProfileScreen,
      page: () => const EditSocialProfileScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.termsConditonScreen,
      page: () => const TermsConditonScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.postScreen,
      page: () => const PostScreen(isExpert: true),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.earningScreen,
      page: () => const EarningScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.bookingDetailsScreen,
      page: () => const BookingDetailsScreen(),
      transition: Transition.fadeIn,
    ),
    // GetPage(
    //   name: RoutesConstant.callWaitingScreen,
    //   page: () => const CallWaitingScreen(),
    //   transition: Transition.fadeIn,
    // ),
    // GetPage(
    //   name: RoutesConstant.receiveCallScreen,
    //   page: () => const ReceiveCallScreen(),
    //   transition: Transition.fadeIn,
    // ),
    // GetPage(
    //   name: RoutesConstant.callCompletedScreen,
    //   page: () => const CallCompletedScreen(),
    //   transition: Transition.fadeIn,
    // ),
    GetPage(
      name: RoutesConstant.commingSoonScreen,
      page: () => const CommingSoonScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.updateNameScreen,
      page: () => const UpdateNameScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.editExpertSubCategoryScreen,
      page: () => const EditExpertSubCategoryScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.editExpertLanguageScreen,
      page: () => const EditExpertLanguageScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.searchContentScreen,
      page: () => const SearchContentScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.searchExpertScreen,
      page: () => const SearchExpertScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.supportScreen,
      page: () => const SupportScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.msgScreen,
      page: () => const MsgScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.interestedSubCategoryScreen,
      page: () => const InterestedSubCategoryScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.updateJobRoleScreen,
      page: () => const UpdateJobRoleScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.stripeWebviewScreen,
      page: () {
        if (Get.arguments is Map) {
          return StripeWebviewScreen(
            url: Get.arguments['url'],
            from: Get.arguments['from'],
          );
        }
        return StripeWebviewScreen(url: Get.arguments);
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.forgetPasswordScreen,
      page: () => ForgetPasswordScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.forgotEmailVerificationScreen,
      page: () => ForgotEmailVerificationScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.resetPasswordScreen,
      page: () => ResetPasswordScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.bookingRescheduleScreen,
      page: () => BookingRescheduleScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.showMeExpertCategoryScreen,
      page: () => const ShowMeExpertCategoryScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.showMeExpertSubCategoryScreen,
      page: () => const ShowMeExpertSubCategoryScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.showMeExpertLearningStyleScreen,
      page: () => const ShowMeExpertLearningStyleScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.showMeExpertLoadingScreen,
      page: () => const ShowMeExpertLoadingScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.showMeExpertMainScreen,
      page: () => const ShowMeExpertMainScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.feedDetailScreen,
      page: () => const FeedDetailScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesConstant.connectStripeScreen,
      page: () => const ConnectStripeScreen(),
      transition: Transition.fadeIn,
    ),
  ];
}
