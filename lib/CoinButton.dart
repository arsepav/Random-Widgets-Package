import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui' as ui;

enum Coins { Ruble, Euro, Cent }

class CoinButton extends StatefulWidget {
  final double radius;
  final ui.VoidCallback? onPressed;
  final Coins coin;
  final Duration duration;
  final bool waitForAnimation;

  const CoinButton({
    this.onPressed,
    required this.radius,
    super.key,
    required this.coin,
    this.duration = const Duration(milliseconds: 500),
    this.waitForAnimation = true,
  });

  @override
  State<CoinButton> createState() => _CoinButtonState();
}

class _CoinButtonState extends State<CoinButton> with TickerProviderStateMixin {
  late AnimationController controller;

  _CoinButtonState();

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: widget.duration, vsync: this)
      ..addListener(() {
        if (controller.value >= 0.4 && controller.value < 0.5) {
          reverseAndElevateDown();
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  Future<void> reverseAndElevateDown() async {
    await controller.animateBack(0.2);
    await controller.forward(from: 1);
  }

  @override
  Widget build(BuildContext context) {
    return _StaggeredAnimation(
      waitForAnimation: widget.waitForAnimation,
      onPressed: widget.onPressed,
      radius: widget.radius,
      controller: controller,
      coin: widget.coin,
      duration: widget.duration,
    );
  }
}

class _StaggeredAnimation extends StatelessWidget {
  bool _odd = false;
  final bool waitForAnimation;
  final Duration duration;

  _StaggeredAnimation(
      {this.onPressed,
      required this.duration,
      required this.waitForAnimation,
      required double this.radius,
      Key? key,
      required this.controller,
      required this.coin})
      : flip = Tween(begin: 0.0, end: 10 * pi).animate(CurvedAnimation(
            parent: controller,
            curve: const Interval(0.0, 0.4, curve: Curves.bounceIn))),
        size = Tween(begin: radius * 2, end: radius * 2).animate(
            CurvedAnimation(
                parent: controller,
                curve: const Interval(0.0, 0.4, curve: Curves.bounceIn))),
        super(key: key);

  final Animation<double> flip;
  final Animation<double> size;
  final VoidCallback? onPressed;
  final double radius;
  final Coins coin;
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: _buildAnimation,
    );
  }

  Widget _buildAnimation(BuildContext context, Widget? child) {
    _checkHeadTail();
    return GestureDetector(
      child: Transform(
        alignment: FractionalOffset.center,
        transform: Matrix4.rotationY(flip.value),
        child: Container(
            height: radius * 2,
            width: radius * 2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: ExactAssetImage(
                  _odd
                      ? "coins/${coin.toString().split('.')[1]}Tail.png"
                      : "coins/${coin.toString().split('.')[1]}Head.png",
                ),
                fit: BoxFit.fitHeight,
              ),
            )),
      ),
      onTap: () {
        controller.reset();
        controller.forward();
        if (waitForAnimation) {
          Future.delayed(duration, () {
            onPressed?.call();
          });
        } else {
          onPressed?.call();
        }
      },
    );
  }

  _checkHeadTail() {
    int num = Random().nextInt(2);
    if (!num.isEven) {
      _odd = !_odd;
    }
  }
}
