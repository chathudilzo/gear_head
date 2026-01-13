import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gear_head/core/theme/app_colors.dart';

class GaugePainter extends CustomPainter {
  final double value;
  final double max;
  final String label;

  GaugePainter({required this.value, required this.max, required this.label});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final bgPaint = Paint()
      ..color = AppColors.gaugeBackground
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16
      ..strokeCap = StrokeCap.round;

    const startAngle = 135 * (pi / 180);
    const sweepAngle = 270 * (pi / 180);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle,
        sweepAngle, false, bgPaint);

    final activePaint = Paint()
      ..color = AppColors.primaryAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16
      ..strokeCap = StrokeCap.round;

    final progressPercentage = (value / max).clamp(0.0, 1.0);
    final currentSweep = sweepAngle * progressPercentage;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle,
        currentSweep, false, activePaint);

    final needlePaint = Paint()
      ..color = AppColors.danger
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final needleAngle = startAngle + currentSweep;

    final needleEnd = Offset(center.dx + (radius - 10) * cos(needleAngle),
        center.dy + (radius - 10) * sin(needleAngle));

    canvas.drawLine(center, needleEnd, needlePaint);

    canvas.drawCircle(center, 6, Paint()..color = AppColors.textPrimary);
  }

  @override
  bool shouldRepaint(covariant GaugePainter oldDelegate) {
    return oldDelegate.value != value;
  }
}
