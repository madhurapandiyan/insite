import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class PercentageWidget extends StatelessWidget {
  final String label;
  final double percentage;
  final Color color;
  final bool isPercentage;
  final String value;

  const PercentageWidget({
    Key key,
    @required this.label,
    @required this.percentage,
    @required this.color,
    this.isPercentage,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: LinearPercentIndicator(
        width: MediaQuery.of(context).size.width * 0.6,
        animation: true,
        animationDuration: 2000,
        lineHeight: 20.0,
        leading: Text(
          label.length > 10 ? label.substring(0, 7) + '...' : label,
          style: TextStyle(
            color: white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: value == null
            ? percentage == null
                ? Text('')
                : isPercentage == null
                    ? Text(
                        '${double.parse((percentage).toStringAsFixed(2))}%',
                        style: TextStyle(
                          color: white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : isPercentage
                        ? Text(
                            '${double.parse((percentage).toStringAsFixed(2))}%',
                            style: TextStyle(
                              color: white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Text(
                            '${double.parse((percentage).toStringAsFixed(2))}',
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
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
