import 'package:flutter/material.dart';
import 'package:insite/core/models/idle_percent_trend.dart';
import 'package:insite/theme/colors.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class IdleTrendGraph extends StatelessWidget {
  final int rangeSelection;
  final IdlePercentTrend idlePercentTrend;
  const IdleTrendGraph(
      {Key key, @required this.rangeSelection, @required this.idlePercentTrend})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SfCartesianChart(
        title: ChartTitle(textStyle: TextStyle(color: white), text: ''),
        primaryXAxis: CategoryAxis(
          title: AxisTitle(text: '', textStyle: TextStyle(color: white)),
          labelStyle: TextStyle(color: white),
          majorGridLines: MajorGridLines(width: 0),
          labelRotation: 270,
        ),
        series: _getStackedColumnSeries(),
        primaryYAxis: NumericAxis(
            title: AxisTitle(text: '', textStyle: TextStyle(color: white)),
            numberFormat: NumberFormat.compact(),
            axisLine: AxisLine(width: 1),
            labelStyle: TextStyle(color: white),
            majorGridLines: MajorGridLines(width: 0),
            minimum: 0,
            maximum: 100,
            labelFormat: '{value}%'),
        tooltipBehavior: TooltipBehavior(),
        plotAreaBorderWidth: 0,
      ),
    );
  }

  List<SplineSeries<CumulativeChartData, String>> _getStackedColumnSeries() {
    final List<CumulativeChartData> chartData = <CumulativeChartData>[];

    for (var item in idlePercentTrend.intervals) {
      chartData.add(CumulativeChartData(
          DateFormat('dd/MM/yyyy').format(item.intervalEndDateLocalTime),
          item.idlePercentage));
    }

    return <SplineSeries<CumulativeChartData, String>>[
      SplineSeries<CumulativeChartData, String>(
        dataSource: chartData,
        splineType: SplineType.natural,
        color: tango,
        width: 2,
        xValueMapper: (CumulativeChartData chartDate, _) => chartDate.x,
        yValueMapper: (CumulativeChartData chartDate, _) =>
            chartDate.percentage,
      ),
    ];
  }
}

class CumulativeChartData {
  final String x;
  final double percentage;

  CumulativeChartData(
    this.x,
    this.percentage,
  );
}
