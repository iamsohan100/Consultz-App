import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class GradientFadingCircle extends StatefulWidget {
  const GradientFadingCircle({super.key});

  @override
  State<GradientFadingCircle> createState() => _GradientFadingCircleState();
}

class _GradientFadingCircleState extends State<GradientFadingCircle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final height = Screen.screenHeight(context);
    final width = Screen.screenWidth(context);
    final scaleFactor = width / Screen.designWidth;
    return RotationTransition(
      turns: _controller,
      child: CustomPaint(
        size: Size(scaleFactor * 32, scaleFactor * 32),
        painter: _GradientCirclePainter(),
      ),
    );
  }
}

class _GradientCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final Paint paint = Paint()
      ..shader = SweepGradient(
        startAngle: 0,
        endAngle: math.pi * 2,
        colors: [AppColors.grey, AppColors.grey.withValues(alpha: 0.05)],
        stops: const [0.0, 1.0],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final double radius = size.width / 2;
    canvas.drawArc(
      Rect.fromCircle(center: Offset(radius, radius), radius: radius - 2),
      0,
      math.pi * 2,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
