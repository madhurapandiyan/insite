import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';

class FleetKnob extends StatelessWidget {
  const FleetKnob({
    Key key,
    @required this.count,
    @required this.label,
  }) : super(key: key);

  final String count;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: cardcolor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              color: cardcolor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: black,
                  offset: Offset(
                    5.0,
                    5.0,
                  ),
                  blurRadius: 10.0,
                  spreadRadius: -3.0,
                ),
                BoxShadow(
                  color: black,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ),
              ],
              gradient: RadialGradient(
                center: Alignment.topLeft,
                radius: 1.5,
                colors: [
                  cardcolor,
                  cardcolor,
                  Colors.black87,
                ],
                stops: [0.5, 0.5, 0.8],
              )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                count,
                style: TextStyle(
                  color: white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                label.toUpperCase(),
                style: TextStyle(
                  color: white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
