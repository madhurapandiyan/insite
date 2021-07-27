import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class PercentageWidget extends StatelessWidget {
  final String label;
  final double percentage;
  final Color color;
  final bool isPercentage;
  final String value;
  final bool isTwoLineLabel;

  const PercentageWidget({
    Key key,
    @required this.label,
    @required this.percentage,
    @required this.color,
    this.isPercentage,
    this.isTwoLineLabel = false,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: LinearPercentIndicator(
        width: MediaQuery.of(context).size.width * 0.6,
        animation: true,
        animationDuration: 1000,
        lineHeight: 20.0,
        leading: Text(
          !isTwoLineLabel
              ? label.length > 10
                  ? label.substring(0, 9) + '...'
                  : label
              : label,
          style: TextStyle(
            color: white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: value == null && value.toString().isNotEmpty
            ? percentage == null
                ? Text(
                    'NA',
                    style: TextStyle(
                      color: white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : isPercentage == null
                    ? Text(
                        '${double.parse((percentage).toStringAsFixed(1))}%',
                        style: TextStyle(
                          color: white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : isPercentage
                        ? Text(
                            '${double.parse((percentage).toStringAsFixed(1))}%',
                            style: TextStyle(
                              color: white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Text(
                            '${double.parse((percentage).toStringAsFixed(1))}',
                            style: TextStyle(
                              color: white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          )
            : Text(
                '$value',
                style: TextStyle(
                  color: white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
        percent: percentage == null ? 0 : percentage / 100,
        linearStrokeCap: LinearStrokeCap.butt,
        progressColor: color,
        backgroundColor: concrete,
      ),
    );
  }
}
