import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';

class IdlingLevelData {
  final int level;
  final String percentage;

  final charts.Color color;
  IdlingLevelData({this.percentage, this.level, this.color});
}
 var data = [
        IdlingLevelData(
            level: 1950,
            percentage: "0-10 %",
            color: charts.ColorUtil.fromDartColor(Color(0xFFEB5757))),
        IdlingLevelData(
            level: 1130,
            percentage: "10-15 %",
            color: charts.ColorUtil.fromDartColor(Color((0xFFF3F3F3)))),
        IdlingLevelData(
            level: 1576,
            percentage: "10-25%",
            color: charts.ColorUtil.fromDartColor(Color(0xFFFDE050))),
        IdlingLevelData(
            level: 1911,
            percentage: ">25%",
            color: charts.ColorUtil.fromDartColor(Color(0xFF48C581)))
      ];