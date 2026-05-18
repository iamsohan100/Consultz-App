// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:developer';
import 'package:app_links/app_links.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/feature/Auth/controller/sign_up_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:consultz/core/utils/share_preference/auth_preference.dart';
import 'package:consultz/route/route_constant.dart';

class DeepLinkService extends GetxService with WidgetsBindingObserver {
  static DeepLinkService get to => Get.find();

  final _appLinks = AppLinks();
  Uri? _pendingUri;
  StreamSubscription<Uri>? _linkSubscription;
  bool _isReady = false;
  Uri? _lastProcessedUri;

  Future<DeepLinkService> init() async {
    // Register WidgetsBindingObserver as a FALLBACK for iOS
    WidgetsBinding.instance.addObserver(this);

    _linkSubscription = _appLinks.uriLinkStream.listen(
      (uri) {
        log("🔗 [app_links STREAM] URI received: $uri");
        handleUri(uri);
      },
      onError: (error) {
        log("🔗 [app_links STREAM] ERROR: $error");
      },
    );

    final initialUri = await _appLinks.getInitialLink();
    if (initialUri != null) {
      log("🔗 [app_links INITIAL] URI detected: $initialUri");
      _pendingUri = initialUri;
    } else {
      log("🔗 [app_links INITIAL] No initial link found (null)");
    }
    return this;
  }

  // ── iOS Fallback: Flutter engine level URL capture ──
  // This is called by the Flutter engine directly when iOS delivers a
  // Universal Link, independent of any plugin. If app_links fails to
  // capture the URL, this will catch it.
  @override
  Future<bool> didPushRoute(String route) async {
    log("🔗 [FALLBACK didPushRoute] called with: $route");
    final uri = Uri.tryParse(route);
    if (uri != null && uri.host.isNotEmpty) {
      log("🔗 [FALLBACK] Valid URI detected, forwarding to handleUri");
      handleUri(uri);
      return true;
    }
    return super.didPushRoute(route);
  }

  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) async {
    final location = routeInformation.uri.toString();
    log("🔗 [FALLBACK didPushRouteInformation] called with: $location");
    final uri = Uri.tryParse(location);
    if (uri != null && uri.host.isNotEmpty) {
      log("🔗 [FALLBACK] Valid URI detected, forwarding to handleUri");
      handleUri(uri);
      return true;
    }
    return super.didPushRouteInformation(routeInformation);
  }

  void handlePendingLink() async {
    log("🔗 [handlePendingLink] Marking service as READY. _pendingUri=$_pendingUri");
    _isReady = true;
    if (_pendingUri != null) {
      log("🔗 [handlePendingLink] Processing pending URI after delay...");
      await Future.delayed(const Duration(milliseconds: 500));
      handleUri(_pendingUri!);
      _pendingUri = null;
    } else {
      log("🔗 [handlePendingLink] No pending URI to process");
    }
  }

  void handleUri(Uri uri) async {
    log("🔗 [handleUri] Called with: $uri | _isReady=$_isReady");

    if (!_isReady) {
      log("🔗 [handleUri] Service not ready, saving as pending");
      _pendingUri = uri;
      return;
    }

    if (_lastProcessedUri == uri) {
      log("🔗 [handleUri] Duplicate URI detected, skipping");
      return;
    }
    _lastProcessedUri = uri;

    log("🔗 [handleUri] Processing URI: $uri");
    log("🔗 [handleUri] Path segments: ${uri.pathSegments}");

    // Wait for navigator to be available
    int retryCount = 0;
    while (Get.context == null && retryCount < 10) {
      log("🔗 [handleUri] Get.context is null, waiting... (retry $retryCount)");
      await Future.delayed(const Duration(milliseconds: 500));
      retryCount++;
    }

    if (Get.context == null) {
      log("🔗 [handleUri] FAILED: Get.context still null after retries");
      return;
    }

    // Check if user is logged in
    final bool isLoggedIn = AuthPreference.logInToken != null;
    log("🔗 [handleUri] isLoggedIn=$isLoggedIn");

    if (uri.pathSegments.contains('expert')) {
      if (!isLoggedIn) {
        log("🔗 [handleUri] User not logged in, ignoring expert link");
        return;
      }

      // Handle trailing slash: filter out empty segments
      String expertId = uri.pathSegments
          .where((s) => s.isNotEmpty)
          .last;
      log("🔗 [handleUri] Expert ID extracted: $expertId");

      // Check if this is the current expert's own profile
      final myId = AuthPreference.logInInfo?.data?.user?.sId;
      if (myId != null && myId == expertId) {
        log("🔗 [handleUri] Self profile link, skipping navigation");
        return;
      }

      log("🔗 [handleUri] ✅ Navigating to ExpertDetailsScreen with ID: $expertId");
      Get.toNamed(RoutesConstant.expertDetailsScreen, arguments: expertId);
    } else if (uri.pathSegments.contains('feeds') ||
        uri.pathSegments.contains('post')) {
      if (!isLoggedIn) {
        log("🔗 [handleUri] User not logged in, ignoring feed link");
        return;
      }

      String feedId = uri.pathSegments
          .where((s) => s.isNotEmpty)
          .last;
      log("🔗 [handleUri] ✅ Navigating to FeedDetailScreen with ID: $feedId");
      Get.toNamed(RoutesConstant.feedDetailScreen, arguments: feedId);
    } else if (uri.pathSegments.contains('invite')) {
      String? code = uri.queryParameters['code'];
      if (code != null && code.isNotEmpty) {
        log("🔗 [handleUri] Invite code detected: $code");
        // Always save the code even if not logged in
        AuthPreference().saveReferralCode(code);

        if (isLoggedIn) {
          bottomMessage(msg: "You were invited with code: $code");
        } else {
          log("🔗 [handleUri] Saved referral code for guest user");
          // If sign up controller is already active, update it immediately
          if (Get.isRegistered<SignUpController>()) {
            Get.find<SignUpController>().referralController.text = code;
          }
        }
      }
    } else {
      log("🔗 [handleUri] No matching route for path: ${uri.path}");
    }

    // Clear last processed after some time to allow same link later if needed
    Future.delayed(const Duration(seconds: 2), () {
      if (_lastProcessedUri == uri) _lastProcessedUri = null;
    });
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    _linkSubscription?.cancel();
    super.onClose();
  }
}
