import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiUrls {
  static final socketUrl = dotenv.env['socketUrl'];
  static final baseUrl = dotenv.env['baseUrl'];
  static final register = "$baseUrl/users/register";
  static final sendOtpInPhoneViaToken =
      "$baseUrl/otp/send-otp-via-token-in-phone";
  static final sendOtpInPhoneViaDirect =
      "$baseUrl/otp/send-otp-via-direct-phone";
  static final sendOtpInEmail = "$baseUrl/otp/send-otp-in-email";
  static final forgetPassword = "$baseUrl/auth/forget-password";
  static final resetPassword = "$baseUrl/auth/reset-password";
  static final verifyOtp = "$baseUrl/otp/verify-with-phone";
  static final verifyOtpWithEmail = "$baseUrl/otp/verify-with-email";
  static final updateProfile = "$baseUrl/users/update-profile";
  static final login = "$baseUrl/auth/login";
  static final googleLogin = "$baseUrl/auth/google";
  static final appleLogin = "$baseUrl/auth/apple";
  static final getProfile = "$baseUrl/users/my-profile";
  static final changeNotify = "$baseUrl/users/change-notify";
  static final updateDeviceToken = "$baseUrl/users/update-device-token";
  static final getAllCategory = "$baseUrl/categories";
  static final changePassword = "$baseUrl/auth/change-password";
  static final addCard = "$baseUrl/cards";
  static String getCards({required String page, required int limit}) =>
      "$baseUrl/cards?page=$page&limit=$limit";
  static String deleteCard(String id) => "$baseUrl/cards/$id";
  static String deleteAccount = "$baseUrl/users/delete-profile";
  static String setDefaultCard(String id) => "$baseUrl/cards/default/$id";

  static String profileUnblock(String id) =>
      "$baseUrl/profile-block/unblock/$id";
  static String profileBlock(String id) => "$baseUrl/profile-block/block/$id";
  static String getExpertProfile(String id) => "$baseUrl/users/$id";

  static String getReviews({
    required String id,
    required String page,
    required int limit,
    String sort = 'latest',
  }) => "$baseUrl/reviews/expert/$id?page=$page&limit=$limit&sort=$sort";
  static String getBlockedUsers({required String page, required int limit}) =>
      "$baseUrl/profile-block?page=$page&limit=$limit";
  static String getInterestExpert({required String page, required int limit}) =>
      "$baseUrl/users/interest-experts?page=$page&limit=$limit";
  static String getPropertyExpert({required String page, required int limit}) =>
      "$baseUrl/users/property-experts?page=$page&limit=$limit";
  static String getTopExpert({required String page, required int limit}) =>
      "$baseUrl/users/top-experts?page=$page&limit=$limit";

  static String getExperts({
    required String page,
    required int limit,
    String? searchTerm,
  }) {
    final search = (searchTerm != null && searchTerm.isNotEmpty)
        ? '&searchTerm=$searchTerm'
        : '';
    return "$baseUrl/users/experts?page=$page&limit=$limit$search";
  }

  static String getFilteredExperts({
    required String page,
    required int limit,
    String? priceRange,
    String? interests,
    String? learningStyles,
    String? availability,
    String? rating,
    String? sessionDurations,
  }) {
    String url = "$baseUrl/users/experts?page=$page&limit=$limit";

    if (priceRange != null) url += "&priceRange=$priceRange";
    if (interests != null) url += "&interests=$interests";
    if (learningStyles != null) url += "&learningStyles=$learningStyles";
    if (availability != null) url += "&availability=$availability";
    if (rating != null) url += "&rating=$rating";
    if (sessionDurations != null) url += "&sessionDurations=$sessionDurations";

    return url;
  }

  static String getFollowingUsers({
    required String id,
    required String page,
    required int limit,
    String? searchTerm,
  }) {
    final search = (searchTerm != null && searchTerm.isNotEmpty)
        ? '&searchTerm=$searchTerm'
        : '';
    return "$baseUrl/connections/followings/$id?page=$page&limit=$limit$search";
  }

  static String getMyFollowingUsers({
    required String page,
    required int limit,
    String? searchTerm,
  }) {
    final search = (searchTerm != null && searchTerm.isNotEmpty)
        ? '&searchTerm=$searchTerm'
        : '';
    return "$baseUrl/connections/my-followings?page=$page&limit=$limit$search";
  }

  static String getFollowerUsers({
    required String page,
    required int limit,
    String? searchTerm,
    required String id,
  }) {
    final search = (searchTerm != null && searchTerm.isNotEmpty)
        ? '&searchTerm=$searchTerm'
        : '';
    return "$baseUrl/connections/followers/$id?page=$page&limit=$limit$search";
  }

  static String unfollowUser(String id) => "$baseUrl/connections/unfollow/$id";
  static String followUser(String id) => "$baseUrl/connections/follow/$id";
  static String termsCondition = "$baseUrl/contents";
  static String createPost = "$baseUrl/feeds";
  static String getMyContent({
    required String id,
    required String page,
    required int limit,
  }) => "$baseUrl/feeds/user/$id?page=$page&limit=$limit";
  static String getActiveContent({
    required String page,
    required int limit,
    String? searchTerm,
  }) {
    final search = (searchTerm != null && searchTerm.isNotEmpty)
        ? '&searchTerm=$searchTerm'
        : '';
    return "$baseUrl/feeds/active-feed?page=$page&limit=$limit$search";
  }

  static String getComments({
    required String id,
    required String page,
    required int limit,
  }) => "$baseUrl/comments/content/$id?page=$page&limit=$limit";

  static String postComment = "$baseUrl/comments";
  static String deleteComment(String id) => "$baseUrl/comments/$id";
  static String getFeed(String id) => "$baseUrl/feeds/$id";
  static String deleteFeed(String id) => "$baseUrl/feeds/$id";
  static String likeContent(String id) => "$baseUrl/content-meta/like/$id";
  static String unlikeContent(String id) => "$baseUrl/content-meta/unlike/$id";
  static String reportContent = "$baseUrl/reports";
  static String supportMessage = "$baseUrl/supports";
  static String createBooking = "$baseUrl/bookings";

  static String getBookings({
    required bool isConsultee,
    String? status,
    required String page,
    required int limit,
  }) {
    final rolePath = isConsultee ? "consult" : "expert";
    final statusQuery = (status != null && status.isNotEmpty)
        ? "&status=$status"
        : "";
    return "$baseUrl/bookings/$rolePath/my-bookings?page=$page&limit=$limit$statusQuery";
  }

  static String getBookingDetails(String id) => "$baseUrl/bookings/$id";
  static String confirmBooking(String id) => "$baseUrl/bookings/confirmed/$id";
  static String cancelBooking(String id) => "$baseUrl/bookings/canceled/$id";
  static String declineBooking(String id) => "$baseUrl/bookings/declined/$id";
  static String rescheduleBooking(String id) =>
      "$baseUrl/bookings/reschedule/$id";
  static String getWithdraws({
    required String year,
    required String page,
    required int limit,
  }) => "$baseUrl/withdraw/my-withdraws?year=$year&page=$page&limit=$limit";

  static String getBookingsByDate({
    required bool isConsultee,
    required String filterType,
    String? date,
  }) {
    final rolePath = isConsultee ? "consult" : "expert";
    final dateQuery = (date != null && date.isNotEmpty) ? "&date=$date" : "";
    return "$baseUrl/bookings/$rolePath/bookings_by_date?filterType=$filterType$dateQuery";
  }

  static String getBookingSlots({required int year, required int month}) =>
      "$baseUrl/booking-slots?year=$year&month=$month";

  static String getSlotsByExpert({
    required String expertId,
    required int year,
    required int month,
    required String date,
  }) =>
      "$baseUrl/booking-slots/expert/$expertId?year=$year&month=$month&date=$date";

  static String createPaymentIntent = "$baseUrl/payments/create-payment-intent";
  static String checkout = "$baseUrl/payments/checkout";
  static String confirmPayment = "$baseUrl/payments/confirm-payment";
  static String connectStripe = "$baseUrl/stripe/connect";
  static String checkStripe = "$baseUrl/stripe/check-connection";
  static String getNotifications({required String page, required int limit}) =>
      "$baseUrl/notifications?page=$page&limit=$limit";
  static String readAllNotifications = "$baseUrl/notifications";

  static String uploadMultiple = "$baseUrl/uploads/multiple";
  static String getMessages({
    required String bookingId,
    required String page,
    required int limit,
  }) => "$baseUrl/messages/my-messages/$bookingId?page=$page&limit=$limit";

  static String roomUrl = '$baseUrl/calls';
  static String callTokenUrl = '$baseUrl/calling/token';

  static String showMeExpertInterest({
    required String page,
    required int limit,
    required List<String> interest,
  }) =>
      "$baseUrl/users/public/interest-experts?page=$page&limit=$limit&interests=${interest.join(',')}";
  static String showMeExpertProperty({
    required String page,
    required int limit,
  }) => "$baseUrl/users/public/property-experts?page=$page&limit=$limit";
  static String showMeExpertTop({required String page, required int limit}) =>
      "$baseUrl/users/public/top-experts?page=$page&limit=$limit";
}
