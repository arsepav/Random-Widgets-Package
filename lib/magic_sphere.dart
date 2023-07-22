import 'package:flutter/material.dart';
import 'dart:math';


class Magic8Ball extends StatefulWidget {
  final double radius;
  final num numberOfShakes;
  final Duration durationOfTextAppearance;
  final Duration durationOfShake;
  final double shakeDistance;
  final List<String> answers;

  const Magic8Ball({
    super.key,
    required this.radius,
    this.durationOfTextAppearance = const Duration(milliseconds: 500),
    this.numberOfShakes = 10,
    this.durationOfShake = const Duration(milliseconds: 100),
    this.shakeDistance = 20,
    this.answers = const [
      'It is certain',
      'Without a doubt',
      'You may rely on \n it',
      'Yes, definitely',
      'As I see it, yes',
      'Most \n likely',
      'Yes',
      'Outlook good',
      'Signs point to yes',
      'Reply hazy, try again',
      'Better not tell you\n now',
      'Ask again later',
      'Cannot predict\n now',
      'Don\'t count on \n it',
      'Outlook not so good',
      'My sources say no',
      'Very doubtful',
      'My reply\n is no'
    ],
  });

  @override
  _Magic8BallState createState() => _Magic8BallState();
}

class _Magic8BallState extends State<Magic8Ball>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _shakeAnimation;
  int shakeCount = 0;
  bool showAnswer = false;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: widget.durationOfShake);

    _shakeAnimation =
        Tween<double>(begin: 0, end: widget.shakeDistance).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        if (shakeCount < widget.numberOfShakes) {
          _animationController.forward();
          shakeCount++;
        } else {
          setState(() {
            _generateAnswer();
            showAnswer = true;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _startAnimation() {
    if (!_animationController.isAnimating) {
      _animationController.forward(from: 0.0);
      shakeCount = 1;
      setState(() {
        showAnswer = false;
      });
    }
  }

  int _randomNumber = 1;

  void _generateAnswer() {
    setState(() {
      _randomNumber = Random().nextInt(widget.answers.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _startAnimation,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) {
          return Transform.translate(
            offset: Offset(_shakeAnimation.value, 0),
            child: child,
          );
        },
        child: Center(
          child: Stack(alignment: Alignment.center, children: [
            Container(
              width: widget.radius,
              height: widget.radius,
              decoration: BoxDecoration(
                gradient: const RadialGradient(
                  center: Alignment.topLeft,
                  stops: [0.1, 0.45],
                  radius: 2,
                  colors: [
                    Colors.black45,
                    Colors.black,
                  ],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: widget.radius / 25)
                ],
              ),
            ),
            Container(
                width: widget.radius / 1.6,
                height: widget.radius / 1.6,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade700,
                        offset: const Offset(1.25, 1.25))
                  ],
                  shape: BoxShape.circle,
                  color: Colors.black,
                )),
            AnimatedOpacity(
              opacity: showAnswer ? 1.0 : 0.0,
              duration: widget.durationOfTextAppearance,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: widget.radius / 2.5,
                    height: widget.radius / 2.5,
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        radius: 0.5,
                        colors: [
                          Colors.blue.shade900,
                          Colors.black45,
                        ],
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(
                    height: widget.radius / 1.6,
                    width: widget.radius / 1.6,
                    child: CustomPaint(
                      painter: InverseTrianglePainter(),
                    ),
                  ),
                  SizedBox(
                    width: widget.radius / 3,
                    child: Text(
                      widget.answers[_randomNumber],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: widget.radius / 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class InverseTrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blue.shade900
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final path = Path();
    path.moveTo(size.width * 0.1, size.height * 0.25); // Starting point
    path.lineTo(size.width * 0.9, size.height * 0.25); // Top vertex
    path.lineTo(size.width / 2, size.height * 0.94); // Ending point
    path.close(); // Connects the ending point to the starting point

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
