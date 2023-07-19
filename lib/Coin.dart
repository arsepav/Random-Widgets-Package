import 'package:flutter/material.dart';

import 'BouncingObj.dart';
import 'dice.dart';

class CoinPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coin'),
      ),
      body: Column(
        children: [
          Center(
            child: CustomPaint(
              size: Size(200, 200),
              painter: CoinPainter(5),
            ),
          ),
          BouncingNumber(size: 50, start: 1, end: 7,),
          const Dice(
            value: 7,
            size: 200,
          ),
        ],
      ),
    );
  }
}

class CoinPainter extends CustomPainter {
  int number;

  CoinPainter(this.number);

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    final center = Offset(size.width / 2, size.height / 2);

    final coinPaint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;

    final rimPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final textPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, coinPaint);
    canvas.drawCircle(center, radius, rimPaint);

    final textSpan = TextSpan(
      text: '$number',
      style: TextStyle(
        fontSize: size.width / 2,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    final textCenter = Offset(
      center.dx - textPainter.width / 2,
      center.dy - textPainter.height / 2,
    );

    textPainter.paint(canvas, textCenter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
