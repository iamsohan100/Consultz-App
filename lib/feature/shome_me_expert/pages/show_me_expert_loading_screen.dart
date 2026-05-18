import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';
import 'package:consultz/route/route_constant.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowMeExpertLoadingScreen extends StatefulWidget {
  const ShowMeExpertLoadingScreen({super.key});

  @override
  State<ShowMeExpertLoadingScreen> createState() =>
      _ShowMeExpertLoadingScreenState();
}

class _ShowMeExpertLoadingScreenState extends State<ShowMeExpertLoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final math.Random _random = math.Random();

  final List<Color> colors = [
    const Color(0xFFFFC55C).withValues(alpha: 0.25),
    const Color(0xFFF9AEBA).withValues(alpha: 0.25),
    const Color(0xFFCDAFD8).withValues(alpha: 0.25),
    const Color(0xFFD83578).withValues(alpha: 0.15),
  ];

  late List<int> currentIndices;
  late List<_CircleData> circles;

  final int circleCount = 25;
  // message state
  String _message = 'Finding experts to inspire you';
  bool _showDots = true;
  int _dotCount = 0;
  Timer? _dotsTimer;
  Timer? swapMessageTimer;
  double? textLineHeight;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutSine,
    );

    // Create randomly positioned circles
    circles = List.generate(circleCount, (i) {
      return _CircleData(
        size: 100 + _random.nextDouble() * 120,
        dxFactor: (i + 0.5) / circleCount,
        baseY: _random.nextDouble(),
        verticalSpeed: 0.3 + _random.nextDouble() * 0.6,
        horizontalAmplitude: 10 + _random.nextDouble() * 30,
        horizontalSpeed: 0.2 + _random.nextDouble() * 0.6,
      );
    });

    currentIndices = List.generate(circleCount, (i) => i % colors.length);

    Future.delayed(const Duration(seconds: 3), _swapColors);
    // start dots animation (0..3) every 500ms
    _dotsTimer = Timer.periodic(const Duration(milliseconds: 500), (t) {
      if (!mounted) return;
      setState(() {
        _dotCount = (_dotCount + 1) % 4; // cycles 0,1,2,3
      });
    });

    // after 5 seconds swap message and stop dots animation
    swapMessageTimer = Timer(const Duration(seconds: 5), () {
      if (!mounted) return;
      _dotsTimer?.cancel();
      setState(() {
        _showDots = false;
        _message = 'Found some!! Are you ready to see your matches?';
        textLineHeight = 1.2;
      });
    });
    _routeMainScreen();
  }

  void _routeMainScreen() {
    Timer(Duration(seconds: 8), () {
      // if (AuthViewModel.accessToken != null) {
      //   Get.offAllNamed(RoutesConstant.mainScreen, arguments: true);
      // } else {
      Get.offAllNamed(RoutesConstant.showMeExpertMainScreen);
      // }
    });
  }

  void _swapColors() {
    setState(() {
      final last = currentIndices.removeLast();
      currentIndices.insert(0, last);
    });
    Future.delayed(const Duration(seconds: 3), _swapColors);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    final maxHeight = height * 0.65;
    // build the visible text (with animated dots if enabled)
    final visibleText = _showDots
        ? _message + (List.filled(_dotCount, '.').join())
        : _message;
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final t = _animation.value;

          return Stack(
            children: [
              // Background gradient (always colored bottom)
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Color(0xFFFDEFF9), Color(0xFFFFFFFF)],
                    stops: [0.0, 1.0],
                  ),
                ),
              ),

              // Animated circles
              for (int i = 0; i < circles.length; i++)
                _buildCircle(
                  circles[i],
                  colors[currentIndices[i]],
                  t,
                  width,
                  maxHeight,
                ),

              // Blur layer (soft and natural)
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: Container(color: Colors.white.withValues(alpha: 0.25)),
              ),

              Positioned(
                bottom: height * 0.04,
                left: width * 0.05,
                right: width * 0.05,
                child: Padding(
                  padding: EdgeInsets.all(scaleFactor * 20),
                  child: Column(
                    spacing: height * 0.015,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(scaleFactor * 14),
                        width: width,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(scaleFactor * 25),
                            topRight: Radius.circular(scaleFactor * 25),
                            bottomRight: Radius.circular(scaleFactor * 25),
                            bottomLeft: Radius.circular(scaleFactor * 8),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 10,
                              spreadRadius: 0.2,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (child, anim) =>
                              FadeTransition(opacity: anim, child: child),
                          child: CustomText(
                            key: ValueKey(visibleText),
                            text: visibleText,
                            color: AppColors.primaryColor,
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            lineHeight: textLineHeight,
                          ),
                        ),
                      ),
                      Image.asset(
                        AppImages.iconGradient,
                        width: scaleFactor * 62,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCircle(
    _CircleData circle,
    Color color,
    double t,
    double width,
    double maxHeight,
  ) {
    // Smooth up-down motion using sine wave
    final dy =
        (math.sin(
              (t * 2 * math.pi * circle.verticalSpeed) +
                  circle.baseY * 2 * math.pi,
            ) +
            1) /
        2 *
        maxHeight;

    // Smooth left-right movement
    final dx =
        circle.dxFactor * width +
        math.sin(t * 2 * math.pi * circle.horizontalSpeed) *
            circle.horizontalAmplitude;

    // Gentle pulse effect
    final pulsate = circle.size + math.sin(t * 2 * math.pi * 0.5) * 10;

    return Positioned(
      left: dx,
      bottom: dy,
      child: Container(
        width: pulsate,
        height: pulsate,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}

class _CircleData {
  final double size;
  final double dxFactor;
  final double baseY;
  final double verticalSpeed;
  final double horizontalAmplitude;
  final double horizontalSpeed;

  _CircleData({
    required this.size,
    required this.dxFactor,
    required this.baseY,
    required this.verticalSpeed,
    required this.horizontalAmplitude,
    required this.horizontalSpeed,
  });
}
