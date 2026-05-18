import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class MobileVerificationProgressContainer extends StatelessWidget {
  final double progress; // স্ক্রিন অনুযায়ী progress (0.0 → 1.0)
  final String image;
  final int imageSize;
  final Color? color;
  const MobileVerificationProgressContainer({
    super.key,
    required this.progress,
    required this.image,
    required this.imageSize,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    return CustomPaint(
      painter: GradientBorderPainter(progress: progress),
      child: Container(
        height: scaleFactor * 80,
        width: scaleFactor * 80,
        alignment: Alignment.center,
        child: Container(
          height: scaleFactor * 76,
          width: scaleFactor * 76,
          decoration: BoxDecoration(
            color: AppColors.warmGrey,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Image.asset(
            image,
            width: scaleFactor * imageSize,
            color: color,
          ),
        ),
      ),
    );
  }
}

class GradientBorderPainter extends CustomPainter {
  final double progress;
  GradientBorderPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    // 🟢 Bottom-center থেকে শুরু হচ্ছে
    final sweepGradient = SweepGradient(
      startAngle: math.pi / 2,
      endAngle: (math.pi / 2) + (2 * math.pi * progress),
      colors: const [Color(0xFF962E84), Color(0xFFD83578)],
      stops: const [0.0, 1.0],
    );

    final paint = Paint()
      ..shader = sweepGradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;

    final center = size.center(Offset.zero);
    final radius = size.width / 2 - 3;

    // 🟢 Border draw হচ্ছে নিচ থেকে
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi / 2, // নিচ থেকে শুরু
      2 * math.pi * progress,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant GradientBorderPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
