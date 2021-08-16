import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:logger/logger.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class IdleWorkingGraphWidget extends StatelessWidget {
  final String label;
  final idleLength;
  final workingLength;
  const IdleWorkingGraphWidget({
    Key key,
    @required this.label,
    @required this.idleLength,
    @required this.workingLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Logger().d("idle $idleLength");
    Logger().d("working $workingLength");
    double width = MediaQuery.of(context).size.width * 0.35;
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16.0),
      child: Row(
        children: [
          Text(
            // label.length > 10 ? label.substring(0, 7) + '...' : label,
            label,
            style: TextStyle(
              color: white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            width: 2,
            height: 60,
            color: white,
          ),
          SizedBox(
            width: 8,
          ),
          LinearPercentIndicator(
            animation: true,
            animationDuration: 1000,
            padding: EdgeInsets.all(0),
            isRTL: true,
            width: width,
            center: Text(
              "${idleLength.toStringAsFixed(1)}",
              style: TextStyle(fontSize: 12),
            ),
            lineHeight: 20.0,
            percent: (idleLength * 10 / 100) > 1 ? 1 : (idleLength * 10 / 100),
            linearStrokeCap: LinearStrokeCap.butt,
            progressColor: burntSienna,
            backgroundColor: concrete,
          ),
          SizedBox(
            width: 8,
          ),
          Container(
            width: 2,
            height: 60,
            color: white,
          ),
          LinearPercentIndicator(
            alignment: MainAxisAlignment.start,
            animation: true,
            animationDuration: 1000,
            lineHeight: 20.0,
            width: width,
            center: Text(
              // "${(idleLength + workingLength).toStringAsFixed(1)}",
              "${(workingLength).toStringAsFixed(1)}",
              style: TextStyle(fontSize: 12),
            ),
            // percent: ((idleLength + workingLength) * 10 / 100) > 1
            //     ? 1
            //     : ((idleLength + workingLength) * 10 / 100),
            percent: ((workingLength) * 10 / 100) > 1
                ? 1
                : ((workingLength) * 10 / 100),
            linearStrokeCap: LinearStrokeCap.butt,
            progressColor: burntSienna,
            backgroundColor: concrete,
          ),
        ],
      ),
    );
  }
}
