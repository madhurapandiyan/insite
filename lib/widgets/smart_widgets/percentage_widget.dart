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

  const PercentageWidget({
    Key? key,
    required this.label,
    required this.percentage,
    required this.color,
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
              ? label!.length > 10
                  ? label!.substring(0, 9) + '...'
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
                        text: percentage.toString(),
                        color: white,
                        size: 12,
                        fontWeight: FontWeight.bold,
                      )
                    : isPercentage!
                        ? InsiteText(
                            text: percentage.toString(),
                            color: white,
                            size: 12,
                            fontWeight: FontWeight.bold,
                          )
                        : InsiteText(
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
        percent: percentage == null ? 0.0 : (percentage as double ),
        linearStrokeCap: LinearStrokeCap.butt,
        progressColor: color,
        backgroundColor: concrete,
      ),
    );
  }
}

// class CustomBarChart extends StatelessWidget {
//   final String? label;
//   final dynamic percentage;
//   final Color? color;
//   final bool? isPercentage;
//   final String? value;
//   final bool isTwoLineLabel;
//   const CustomBarChart({
//     Key? key,
//     required this.label,
//     required this.percentage,
//     this.color,
//     this.isPercentage,
//     this.isTwoLineLabel = false,
//     this.value,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         InsiteText(
//           text: !isTwoLineLabel
//               ? label!.length > 10
//                   ? label!.substring(0, 9) + '...'
//                   : label
//               : label,
//           size: 10,
//           fontWeight: FontWeight.bold,
//         ),
//         Expanded(
//           child: Stack(
//             children: [
//               Container(
//                 width: MediaQuery.of(context).size.width * 1,
//                 height: MediaQuery.of(context).size.height * 0.03,
//                 color: white,
//               ),
//               FractionallySizedBox(
//                 widthFactor: percentage,
//                 child: Container(
//                   height: MediaQuery.of(context).size.height * 0.03,
//                   width: MediaQuery.of(context).size.width * 1,
//                   color: tango,
//                 ),
//               )
//             ],
//           ),
//         ),
//         value == null && value.toString().isNotEmpty
//             ? percentage == null
//                 ? InsiteText(
//                     text: 'NA',
//                     color: white,
//                     size: 12,
//                     fontWeight: FontWeight.bold,
//                   )
//                 : isPercentage == null
//                     ? InsiteText(
//                         text: percentage.toString(),
//                         color: white,
//                         size: 12,
//                         fontWeight: FontWeight.bold,
//                       )
//                     : isPercentage!
//                         ? InsiteText(
//                             text: percentage.toString(),
//                             color: white,
//                             size: 12,
//                             fontWeight: FontWeight.bold,
//                           )
//                         : InsiteText(
//                             text: percentage.toString(),
//                             color: white,
//                             size: 12,
//                             fontWeight: FontWeight.bold,
//                           )
//             : InsiteText(
//                 text: '$value',
//                 color: white,
//                 size: 12,
//                 fontWeight: FontWeight.bold,
//               ),
//       ],
//     );
//   }
// }
