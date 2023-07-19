import 'dart:math';

import 'package:diceandcoin/Coin.dart';
import 'package:flutter/material.dart';

import 'dice.dart';

var pi = 3.14159265359;

int sign(double n) {
  if (n > 0) {
    return 1;
  } else if (n < 0) {
    return -1;
  }
  return 0;
}

class BouncingObjectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bouncing Object'),
      ),
      body: Center(
        child: BouncingNumber(),
      ),
    );
  }
}

class BouncingNumber extends StatefulWidget {
  double size;
  int start;
  int end;

  BouncingNumber({this.size = 100, this.start = 1, this.end = 7});

  @override
  _BouncingNumberState createState() => _BouncingNumberState(this.size, this.start, this.end);
}

class _BouncingNumberState extends State<BouncingNumber>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  double size;
  int start;
  int end;

  _BouncingNumberState(this.size, this.start, this.end);

  int _number = 1;
  double _yOffset = 0.0;
  double _rotation = 0.0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: size*1.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.addListener(() {
      setState(() {
        _yOffset = _animation.value;
        _rotation = _animation.value * 0.7; // Устанавливаем вращение в зависимости от _yOffset
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
      _number = Random().nextInt(end - start) + start;
    });
  }

  void _resetNumber() {
    setState(() {
    });
  }

  void _onTap() {
    if (!_controller.isAnimating) {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    _number = Random().nextInt(end-start) + start;
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
                  value: _number,
                  size: size,
                )
              ),
            ),
          );
        },
      ),
    );
  }
}