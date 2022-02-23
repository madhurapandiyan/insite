import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class DayCheck extends StatelessWidget {
  final String? day;
  const DayCheck({this.day});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          FittedBox(
            child: InsiteText(
              text: day,
              fontWeight: FontWeight.bold,
              size: 14,
             ),
          ),
          SizedBox(
            height: 10,
          ),
          Icon(
            Icons.check,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
