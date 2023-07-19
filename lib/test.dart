import 'package:flutter/material.dart';

import 'RandomColorfulWheel.dart';

class ColorChangerWidget extends StatefulWidget {
  RandomColorWheel wheel;

  ColorChangerWidget({required this.wheel});

  @override
  _ColorChangerWidgetState createState() => _ColorChangerWidgetState();
}

class _ColorChangerWidgetState extends State<ColorChangerWidget> {
  Color _currentColor = Colors.blue;

  void changeColor() {
    setState(() {
      _currentColor = widget.wheel.getColor();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        height: 200,
        color: _currentColor,
        child: Container(
          alignment: Alignment.bottomRight,
          height: 25,
          width: 25,
          child: FloatingActionButton(
            backgroundColor: Colors.redAccent,
            onPressed: changeColor,
            child: Icon(Icons.color_lens, color: Colors.cyan,),
          ),
        ));
  }
}
