import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class DayCheck extends StatelessWidget {
  final String? day;
  final Color? colour;
  final VoidCallback? onTap;

  const DayCheck({this.day, this.colour, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: FittedBox(
              fit: BoxFit.cover,
              child: InsiteText(
                text: day,
                fontWeight: FontWeight.bold,
                size: day == "FRI" ? 10 : null,
                color: colour,
              ),
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
