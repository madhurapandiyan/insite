import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
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
        leading: InsiteText(
          text: !isTwoLineLabel
              ? label.length > 10
                  ? label.substring(0, 9) + '...'
                  : label
              : label,
          size: 10,
          fontWeight: FontWeight.bold,
        ),
        trailing: value == null && value.toString().isNotEmpty
            ? percentage == null
                ? InsiteText(
                    text: 'NA',
                    color: white,
                    size: 12,
                    fontWeight: FontWeight.bold,
                  )
                : isPercentage == null
                    ? InsiteText(
                        text:
                            '${double.parse((percentage).toStringAsFixed(1))}%',
                        color: white,
                        size: 12,
                        fontWeight: FontWeight.bold,
                      )
                    : isPercentage
                        ? InsiteText(
                            text:
                                '${double.parse((percentage).toStringAsFixed(1))}%',
                            color: white,
                            size: 12,
                            fontWeight: FontWeight.bold,
                          )
                        : InsiteText(
                            text:
                                '${double.parse((percentage).toStringAsFixed(1))}',
                            color: white,
                            size: 12,
                            fontWeight: FontWeight.bold,
                          )
            : InsiteText(
                text: '$value',
                color: white,
                size: 12,
                fontWeight: FontWeight.bold,
              ),
        percent: percentage == null ? 0 : percentage / 100,
        linearStrokeCap: LinearStrokeCap.butt,
        progressColor: color,
        backgroundColor: concrete,
      ),
    );
  }
}
