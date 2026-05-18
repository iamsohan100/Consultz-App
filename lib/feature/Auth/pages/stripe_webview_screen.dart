import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/message/top_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:consultz/route/route_constant.dart';

class StripeWebviewScreen extends StatefulWidget {
  final String url;
  final String? from;
  const StripeWebviewScreen({super.key, required this.url, this.from});

  @override
  State<StripeWebviewScreen> createState() => _StripeWebviewScreenState();
}

class _StripeWebviewScreenState extends State<StripeWebviewScreen> {
  late final WebViewController _controller;

  void _handleNavigation(String url) {
    if (url.contains('success=true') && url.contains('statusCode=200')) {
      if (widget.from == 'profile') {
        Navigator.pop(context);
        topMessage(
          title: 'Success',
          msg: 'Stripe account connected successfully',
        );
      } else {
        Get.offNamed(RoutesConstant.uploadProfilePictureScreen);
      }
    } else if (url.contains('success=false')) {
      Get.back();
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent(
        "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36",
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            String url = request.url;
            _handleNavigation(url);
            if (url.contains('success=true') || url.contains('success=false')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            if (change.url != null) {
              _handleNavigation(change.url!);
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'Connect Stripe', context: context),
      body: SafeArea(child: WebViewWidget(controller: _controller)),
    );
  }
}
