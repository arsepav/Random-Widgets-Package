import 'package:flutter/material.dart';

Widget dots(int n, double size) {
  switch (n) {
    case 1:
      return Dot(
        size: size,
      );
    case 2:
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Dot(
            size: size,
          ),
          Dot(
            size: size,
          )
        ],
      );
    case 3:
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Dot(
            size: size,
          ),
          Dot(
            size: size,
          ),
          Dot(
            size: size,
          )
        ],
      );
    case 4:
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Dot(
                size: size,
              ),
              Dot(
                size: size,
              )
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Dot(
                size: size,
              ),
              Dot(
                size: size,
              )
            ],
          ),
        ],
      );
    case 5:
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Dot(
                size: size,
              ),
              Dot(
                color: Colors.transparent,
                size: size,
              ),
              Dot(
                size: size,
              )
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Dot(
                color: Colors.transparent,
                size: size,
              ),
              Dot(
                size: size,
              ),
              Dot(
                color: Colors.transparent,
                size: size,
              )
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Dot(
                size: size,
              ),
              Dot(
                color: Colors.transparent,
                size: size,
              ),
              Dot(
                size: size,
              )
            ],
          ),
        ],
      );
    case 6:
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Dot(
                size: size,
              ),
              Dot(
                size: size,
              ),
              Dot(
                size: size,
              )
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Dot(
                size: size,
              ),
              Dot(
                size: size,
              ),
              Dot(
                size: size,
              )
            ],
          ),
        ],
      );
  }
  return Text(
    '$n',
    style: TextStyle(
      fontSize: size / 3.4,
      fontWeight: FontWeight.bold,
    ),
  );
}

class Dice extends StatelessWidget {
  final int value;
  final double size;

  const Dice({required this.value, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(size / 10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(2, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Center(
        child: dots(value, size),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  Color color;
  double size;

  Dot({super.key, this.color = Colors.black, this.size = 20});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(size / 14.4),
      child: Container(
        width: size / 6,
        height: size / 6,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
