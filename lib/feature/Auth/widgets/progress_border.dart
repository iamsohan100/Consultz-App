import 'dart:math' as math;

import 'package:flutter/material.dart';

class ProgressBorder extends CustomPainter {
  final double progress; // 0.0 -> 1.0
  ProgressBorder({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2 - 3;

    // 1️⃣ Draw the background (empty) arc
    final backgroundPaint = Paint()
      ..color =
          const Color(0xFFDCDCDC) // Empty portion color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0,
      2 * math.pi,
      false,
      backgroundPaint,
    );

    // 2️⃣ Draw the progress arc on top
    final progressPaint = Paint()
      ..color =
          const Color(0xFF333431) // Completed portion color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi / 2, // Start from bottom
      2 * math.pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant ProgressBorder oldDelegate) =>
      oldDelegate.progress != progress;
}
