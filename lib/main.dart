import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:math';
import 'ColorfulPiePainter.dart';
import 'RandomColorfulWheel.dart';
import 'RotatingWidget.dart';
import 'Coin.dart';
import 'test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    home: CoinPage(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RandomColorWheel wheel = RandomColorWheel(
      colors: [
        Colors.black,
        Colors.amber,
        Colors.black12,
        Color(0xFF9D53CC),
        Color(0xFF67508D),
        Color(0xff141460),
        Color.fromRGBO(10, 186, 181, 1),
      ],
      size: 100,
    );
    return MaterialApp(
      title: 'Shaking Color Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Shaking Color Demo'),
        ),
        body: Center(
            child: Column(
          children: [

            SizedBox(
              width: 200,
              height: 200,
              child: Container(
                color: Colors.red,
                child: RandomNumberWidget(),
              ),
            ),
            wheel,
            SizedBox(
              width: 30,
              height: 30,
            ),
            SizedBox(
              width: 300,
              height: 300,
              child: ColorChangerWidget(
                wheel: wheel,
              ),
            ),
          ],
        )),
      ),
    );
  }
}

class ShakingColorWidget extends StatefulWidget {
  @override
  _ShakingColorWidgetState createState() => _ShakingColorWidgetState();
}

class _ShakingColorWidgetState extends State<ShakingColorWidget> {
  bool _isShaking = false;
  Color _currentColor = Colors.blue;

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      if (event.x.abs() > 15 || event.y.abs() > 15 || event.z.abs() > 100) {
        setState(() {
          _isShaking = true;
          _currentColor = Colors.red;
        });
      } else {
        setState(() {
          _isShaking = false;
          _currentColor = Colors.blue;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    accelerometerEvents.drain();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _currentColor,
      child: Center(
        child: Text(
          _isShaking ? 'Shaking' : 'Not shaking',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}

class RandomNumberWidget extends StatefulWidget {
  @override
  _RandomNumberWidgetState createState() => _RandomNumberWidgetState();
}

class _RandomNumberWidgetState extends State<RandomNumberWidget> {
  int randomNum = 0;
  int shakeCount = 0;

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      const double accelerationThreshold =
          15.0; // Порог ускорения для обнаружения тряски (может потребоваться настройка)

      if (event.x.abs() > accelerationThreshold ||
          event.y.abs() > accelerationThreshold ||
          event.z.abs() > accelerationThreshold) {
        setState(() {
          shakeCount++;
          if (shakeCount == 1) {
            randomNum = _generateRandomNumber();
            shakeCount = 0;
          }
        });
      }
    });
  }

  int _generateRandomNumber() {
    return Random().nextInt(
        100); // Замените 100 на максимальное значение числа, которое вам нужно
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Случайное число:',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 10),
        Text(
          '$randomNum',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class RotatingCircleWidget extends StatefulWidget {
  double size;

  @override
  _RotatingCircleWidgetState createState() => _RotatingCircleWidgetState(size);

  RotatingCircleWidget(this.size);
}

class _RotatingCircleWidgetState extends State<RotatingCircleWidget>
    with SingleTickerProviderStateMixin {
  double size;
  late AnimationController _animationController;

  _RotatingCircleWidgetState(this.size);

  late Animation<double> _rotationAnimation;

  double _totalRotation = 0.0;
  double _targetRotation =
      1.0; // Установите желаемое количество градусов для остановки анимации

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _totalRotation += 10;
        if (_totalRotation >= _targetRotation) {
          _animationController.stop();
        } else {
          _animationController.repeat();
        }
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_animationController.isAnimating) {
          _animationController.stop();
        } else {
          print('here');
          _totalRotation = 0.0;
          _animationController.repeat();
        }
      },
      child: AnimatedBuilder(
        animation: _rotationAnimation,
        builder: (context, child) {
          return Transform.rotate(
            angle: _rotationAnimation.value * 2.0 * 3.1415 +
                _totalRotation * (3.1415 / 180.0),
            child: child,
          );
        },
        child: Container(
          width: size,
          height: size,
          child: Stack(
            children: [
              CustomPaint(
                size: Size(size, size),
                painter: PieSlicePainter(
                  color: Colors.red,
                  startAngle: 0,
                  sweepAngle: 2.0944,
                ),
              ),
              CustomPaint(
                size: Size(size, size),
                painter: PieSlicePainter(
                  color: Colors.green,
                  startAngle: 2.0944,
                  sweepAngle: 2.0944,
                ),
              ),
              CustomPaint(
                size: Size(size, size),
                painter: PieSlicePainter(
                  color: Colors.blue,
                  startAngle: 2.0944 * 2,
                  sweepAngle: 2.0944,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
