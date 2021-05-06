import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class PercentageWidget extends StatelessWidget {
  final String label;
  final double percentage;
  final Color color;
  final bool isPercentage;

  const PercentageWidget({
    Key key,
    @required this.label,
    @required this.percentage,
    @required this.color,
    this.isPercentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: LinearPercentIndicator(
        width: MediaQuery.of(context).size.width * 0.8,
        animation: true,
        animationDuration: 2000,
        lineHeight: 20.0,
        leading: Text(
          label,
          style: TextStyle(
            color: white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        percent: percentage == null ? 0 : percentage / 100,
        center: percentage == null
            ? Text('')
            : isPercentage == null
                ? Text('${double.parse((percentage).toStringAsFixed(2))}%')
                : isPercentage
                    ? Text('${double.parse((percentage).toStringAsFixed(2))}%')
                    : Text('${double.parse((percentage).toStringAsFixed(2))}'),
        linearStrokeCap: LinearStrokeCap.butt,
        progressColor: color,
        backgroundColor: concrete,
      ),
    );
  }
}
