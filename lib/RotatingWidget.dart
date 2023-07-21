import "package:flutter/material.dart";
import 'dart:math';
import 'dart:ui' as ui;

const pi = 3.14159265359;

class RotationAnimationWheel extends StatefulWidget {
  final double size;
  final StatelessWidget child;
  final double rotation;
  double position = 0;
  final ui.VoidCallback? onPressed;
  final Duration duration;
  final bool waitForAnimation;

  double getPosition() {
    return position;
  }

  RotationAnimationWheel({
    super.key,
    required this.size,
    required this.child,
    this.rotation = 360,
    required this.onPressed,
    this.duration = const Duration(milliseconds: 500),
    this.waitForAnimation = true,
  });

  @override
  State<RotationAnimationWheel> createState() => _RotationAnimationWheelState();
}

class _RotationAnimationWheelState extends State<RotationAnimationWheel>
    with SingleTickerProviderStateMixin {
  double position = 0;
  late double rotationRad;

  // final ui.VoidCallback? onPressed;
  // bool waitForAnimation;

  _RotationAnimationWheelState();

  late AnimationController _animationController;
  Animation<double>? _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: widget.duration,
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
    widget.position = position;
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    rotationRad = (Random().nextInt(720) + 360) * pi / 180;
    return GestureDetector(
      onTap: () {
        if (!_animationController.isAnimating) {
          setState(() {});
          _startAnimation();
        }
        if (widget.waitForAnimation) {
          Future.delayed(widget.duration, () {
            widget.onPressed?.call();
          });
        } else {
          widget.onPressed?.call();
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
        child: widget.child,
      ),
    );
  }
}
