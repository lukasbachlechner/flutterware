import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutterware/src/constants/app_colors.dart';

class LoadingIndicator extends HookWidget {
  const LoadingIndicator({
    super.key,
    this.indicatorColor = AppColors.primaryColor,
    this.strokeWidth = 2.0,
  });

  final Color indicatorColor;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(seconds: 1),
    );
    controller.repeat();

    return SizedBox.square(
      dimension: 36,
      child: CustomPaint(
        willChange: true,
        painter: IndicatorPainter(
          color: indicatorColor,
          strokeWidth: strokeWidth,
          animation: controller,
        ),
      ),
    );
  }
}

class IndicatorPainter extends CustomPainter {
  IndicatorPainter({
    required this.color,
    required this.animation,
    required this.strokeWidth,
  }) : super(repaint: animation);

  final Color color;
  final Animation animation;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final startAngleDegrees = animation.value * 360;
    final startAngleRadian = startAngleDegrees * pi / 180;
    const sweepAngle = pi / 2;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final circlePaint = Paint()
      ..strokeWidth = strokeWidth
      ..color = color.withOpacity(0.5)
      ..style = PaintingStyle.stroke;

    final arcPaint = Paint()
      ..strokeWidth = strokeWidth
      ..color = color
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius, circlePaint);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngleRadian,
      sweepAngle,
      false,
      arcPaint,
    );
  }

  @override
  bool shouldRepaint(IndicatorPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.animation != animation ||
      oldDelegate.strokeWidth != strokeWidth;
}
