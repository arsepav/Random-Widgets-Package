import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'Dice.dart';

int sign(double n) {
  if (n > 0) {
    return 1;
  } else if (n < 0) {
    return -1;
  }
  return 0;
}

class DiceButtonValue {
  int value = 0;
}

class BouncingDiceButton extends StatefulWidget {
  final double size;
  final int start;
  final int end;
  final Duration duration;
  int value = 1;


  int getValue(){
    return value;
  }

  final ui.VoidCallback? onPressed;

  BouncingDiceButton({super.key,
    this.size = 100,
    this.start = 1,
    this.end = 7,
    required this.onPressed,
    this.duration = const Duration(milliseconds: 500),
  });

  @override
  State<BouncingDiceButton> createState() =>
      _BouncingDiceButtonState();
}

class _BouncingDiceButtonState extends State<BouncingDiceButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;


  _BouncingDiceButtonState();

  double _yOffset = 0.0;
  double _rotation = 0.0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: widget.size * 1.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.addListener(() {
      setState(() {
        _yOffset = _animation.value;
        _rotation = _animation.value * 0.7;
      });
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _changeNumber();
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _resetNumber();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _changeNumber() {
    setState(() {
      widget.value = Random().nextInt(widget.end - widget.start) + widget.start;
    });
  }

  void _resetNumber() {
    setState(() {});
  }

  void _onTap() {
    if (!_controller.isAnimating) {
      _controller.forward();
      Future.delayed(widget.duration, () {
        widget.onPressed?.call();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.value = Random().nextInt(widget.end - widget.start) + widget.start;
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          return Transform.translate(
            offset: Offset(0, -_yOffset),
            child: Transform.rotate(
              angle: _rotation,
              child: Center(
                  child: Dice(
                value: widget.value,
                size: widget.size,
              )),
            ),
          );
        },
      ),
    );
  }
}
