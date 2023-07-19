import 'package:diceandcoin/ColorfulPiePainter.dart';
import 'package:diceandcoin/main.dart';
import 'package:flutter/material.dart';

import 'RotatingWidget.dart';

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);

    final strokePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class TriangleWidget extends StatelessWidget {
  double size;

  TriangleWidget({required this.size});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size / 4, size / 4),
      painter: TrianglePainter(),
      child: Container(
        width: size / 4,
        height: size / 4,
      ),
    );
  }
}

class RandomColorWheel extends StatelessWidget {
  List<Color> colors;
  double size;

  late RotationAnimationWidget widget;

  RandomColorWheel({required this.colors, this.size = 25});

  Color getColor(){
    //print(((widget.getPosition() + pi/2) % (pi * 2)) / 2 / pi * colors.length);
    return colors[colors.length - 1 - (((widget.getPosition() - pi/2) % (pi * 2)) / 2 / pi * colors.length).floor()];
  }

  @override
  Widget build(BuildContext context) {
    widget = RotationAnimationWidget(
    size: size,
    child: ColorfullPie(
    colors: colors,
    size: size,
    ),
    );
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Column(
          children: [
            widget,
            SizedBox(
              height: 0.1 * size,
            ),
          ],
        ),
        Column(
          children: [
            SizedBox(
              height: 0.85 * size,
            ),
            TriangleWidget(
              size: size,
            ),
          ],
        ),
      ],
    );
  }
}
