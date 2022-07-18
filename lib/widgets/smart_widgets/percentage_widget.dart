import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:logger/logger.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class PercentageWidget extends StatelessWidget {
  final String? label;
  final dynamic percentage;
  final Color color;
  final bool? isPercentage;
  final String? value;
  final bool isTwoLineLabel;
  final dynamic minMax;

  const PercentageWidget(
      {Key? key,
      required this.label,
      required this.percentage,
      required this.color,
      this.isPercentage,
      this.isTwoLineLabel = false,
      this.value,
      this.minMax})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InsiteText(
            text: label,
          ),
          SizedBox(
            height: 10,
          ),
          LinearPercentIndicator(
            width: MediaQuery.of(context).size.width * 0.6,
            animation: true,
            animationDuration: 1000,
            lineHeight: 20.0,
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
                            text: percentage.toString(),
                            color: white,
                            size: 12,
                            fontWeight: FontWeight.bold,
                          )
                        :
                        // isPercentage!
                        //     ? InsiteText(
                        //         text: percentage.toString(),
                        //         color: white,
                        //         size: 12,
                        //         fontWeight: FontWeight.bold,
                        //       )
                        //     :
                        InsiteText(
                            text: percentage.toString(),
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
            percent:
                percentage == null ? 0.0 : double.parse(percentage.toString()),
            linearStrokeCap: LinearStrokeCap.butt,
            progressColor: color,
            backgroundColor: concrete,
          ),
        ],
      ),
    );
  }
}

class CustomPercentageWidget extends StatelessWidget {
  final String? label;
  final dynamic percentage;
  final Color color;
  final bool? isPercentage;
  final String? value;
  final bool isTwoLineLabel;
  final String? trailText;

  const CustomPercentageWidget(
      {Key? key,
      required this.label,
      required this.percentage,
      required this.color,
      this.isPercentage,
      this.isTwoLineLabel = false,
      this.value,
      this.trailText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InsiteText(
                text: label,
              ),
              InsiteText(
                  text: trailText == "null" || trailText == null
                      ? ""
                      : trailText),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Stack(
            children: [
              Container(
                height: mediaQuery.height * 0.030,
                width: mediaQuery.width * 1,
                color: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .color!
                    .withOpacity(0.5),
              ),
              AnimatedContainer(
                duration: Duration(seconds: 2),
                height: mediaQuery.height * 0.030,
                width: mediaQuery.width * percentage,
                color: Theme.of(context).buttonColor,
              )
            ],
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}