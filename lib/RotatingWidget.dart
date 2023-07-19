import "package:flutter/material.dart";
import 'ColorfulPiePainter.dart';
import 'dart:math';

const pi = 3.14159265359;


class RotationAnimationWidget extends StatefulWidget {
  double size;
  StatelessWidget child;
  int duration;
  double rotation;
  double c = 0;

  double getPosition(){
    return c;
  }

  RotationAnimationWidget(
      {required this.size,
      required this.child,
      this.duration = 1,
      this.rotation = 360});

  @override
  _RotationAnimationWidgetState createState() {
    return _RotationAnimationWidgetState(
        size: size,
        widget1: child,
        timeDuration: duration,
        rotation: rotation);
  }
}

class _RotationAnimationWidgetState extends State<RotationAnimationWidget>
    with SingleTickerProviderStateMixin {
  double size;
  StatelessWidget widget1;
  int timeDuration;
  double rotation;
  double position = 0;
  late double rotationRad;


  _RotationAnimationWidgetState(
      {required this.size,
      required this.widget1,
      required this.rotation,
      required this.timeDuration});

  late AnimationController _animationController;
  Animation<double>? _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: Duration(seconds: timeDuration),
      vsync: this,
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.stop();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _animationController.reset();
    _rotationAnimation =
        Tween<double>(begin: position, end: position + rotationRad)
            .animate(_animationController);
    position += rotationRad;
    position = position % (pi * 4);
    widget.c = position;
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    rotationRad = (Random().nextInt(720) + 360) * pi / 180;
    return GestureDetector(
      onTap: () {
        if (!_animationController.isAnimating) {
          setState(() {
          });
          _startAnimation();
        }
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.rotate(
            angle: _rotationAnimation?.value ?? 0.0,
            child: child,
          );
        },
        child: widget1,
      ),
    );
  }
}
