import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';

class UtilizationLegends extends StatelessWidget {
  final String label1;
  final String label2;
  final String label3;
  final Color color1;
  final Color color2;
  final Color color3;
  const UtilizationLegends(
      {Key key,
      @required this.label1,
      @required this.label2,
      @required this.label3,
      @required this.color1,
      @required this.color2,
      @required this.color3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        statusWidget(color1),
        Text(
          label1.toUpperCase(),
          style: TextStyle(color: white, fontSize: 12),
        ),
        statusWidget(color2),
        Text(
          label2.toUpperCase(),
          style: TextStyle(color: white, fontSize: 12),
        ),
        statusWidget(color3),
        Text(
          label3.toUpperCase(),
          style: TextStyle(color: white, fontSize: 12),
        ),
      ],
    );
  }

  Container statusWidget(Color color) => Container(
        width: 10.0,
        height: 10.0,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      );
}
