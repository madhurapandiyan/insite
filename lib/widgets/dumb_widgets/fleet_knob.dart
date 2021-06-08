import 'package:flutter/material.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/theme/colors.dart';

class FleetKnob extends StatelessWidget {
  const FleetKnob({this.filterData});

  final FilterData filterData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 130,
      margin: EdgeInsets.only(left: 8),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                filterData.count,
                style: TextStyle(
                  color: white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                filterData.title.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: white,
                  fontSize: 12,
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
