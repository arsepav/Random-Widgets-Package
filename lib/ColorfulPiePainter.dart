import 'package:flutter/material.dart';
import "dart:math";

class ColorfulPie extends StatelessWidget {
  final double size;
  final List<Color> colors;

  const ColorfulPie({super.key, required this.size, required this.colors});

  @override
  Widget build(BuildContext context) {
    double start = 0;
    List<CustomPaint> paints = [];
    for (var color2 in colors) {
      paints.add(
        CustomPaint(
          size: Size(size, size),
          painter: PieSlicePainter(
            color: color2,
            startAngle: start,
            sweepAngle: pi * 2 / colors.length,
          ),
        ),
      );
      start = start + pi * 2 / colors.length;
    }
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: paints,
      ),
    );
  }
}

class PieSlicePainter extends CustomPainter {
  final Color color;
  final double startAngle;
  final double sweepAngle;

  PieSlicePainter({
    required this.color,
    required this.startAngle,
    required this.sweepAngle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint = Paint()..color = color;
    canvas.drawArc(rect, startAngle, sweepAngle, true, paint);
  }

  @override
  bool shouldRepaint(PieSlicePainter oldDelegate) {
    return color != oldDelegate.color ||
        startAngle != oldDelegate.startAngle ||
        sweepAngle != oldDelegate.sweepAngle;
  }
}
