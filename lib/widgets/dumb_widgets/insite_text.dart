import 'package:flutter/material.dart';

class InsiteText extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  final FontWeight fontWeight;
  const InsiteText({this.text, this.color, this.fontWeight, this.size});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
          color: color,
          fontWeight: fontWeight,
          fontSize: size,
        ));
  }
}
