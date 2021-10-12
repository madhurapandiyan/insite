import 'package:flutter/material.dart';
import 'package:insite/core/models/total_hours.dart';
import 'package:insite/theme/colors.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TotalHoursChart extends StatelessWidget {
  final int rangeSelection;
  final TotalHours totalHours;
  final List<bool> shouldShowLabel;
  const TotalHoursChart(
      {Key key,
      @required this.rangeSelection,
      @required this.totalHours,
      this.shouldShowLabel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: totalHours == null
          ? SfCartesianChart(
              title: ChartTitle(
                  textStyle: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1.color),
                  text: rangeSelection == 1
                      ? 'Daily average: NA'
                      : rangeSelection == 2
                          ? 'Weekly average: NA'
                          : 'Monthly average: NA'),
              primaryXAxis: CategoryAxis(
                title: AxisTitle(
                    text: '',
                    textStyle: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1.color)),
                labelStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1.color),
                majorGridLines: MajorGridLines(width: 0),
              ),
              series: _getStackedColumnSeries(),
              primaryYAxis: NumericAxis(
                title: AxisTitle(
                    text: '',
                    textStyle: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1.color)),
                numberFormat: NumberFormat.compact(),
                axisLine: AxisLine(width: 1),
                labelStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1.color),
                majorGridLines: MajorGridLines(width: 0),
              ),
              tooltipBehavior: TooltipBehavior(),
              isTransposed: true,
              plotAreaBorderWidth: 0,
            )
          : SfCartesianChart(
              title: ChartTitle(
                  textStyle: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1.color),
                  text: rangeSelection == 1
                      ? 'Daily average: ${totalHours.cumulatives.averageHours.toStringAsFixed(2)} Hours'
                      : rangeSelection == 2
                          ? 'Weekly average: ${totalHours.cumulatives.averageHours.toStringAsFixed(2)} Hours'
                          : 'Monthly average: ${totalHours.cumulatives.averageHours.toStringAsFixed(2)} Hours'),
              primaryXAxis: CategoryAxis(
                title: AxisTitle(
                    text: '',
                    textStyle: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1.color)),
                labelStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1.color),
                majorGridLines: MajorGridLines(width: 0),
              ),
              series: _getStackedColumnSeries(),
              primaryYAxis: NumericAxis(
                title: AxisTitle(
                    text: '',
                    textStyle: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1.color)),
                numberFormat: NumberFormat.compact(),
                axisLine: AxisLine(width: 1),
                labelStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1.color),
                majorGridLines: MajorGridLines(width: 0),
              ),
              tooltipBehavior: TooltipBehavior(),
              isTransposed: true,
              plotAreaBorderWidth: 0,
            ),
    );
  }

  List<StackedColumnSeries<CumulativeChartData, String>>
      _getStackedColumnSeries() {
    final List<CumulativeChartData> chartData = <CumulativeChartData>[];

    if (totalHours == null)
      return <StackedColumnSeries<CumulativeChartData, String>>[];

    for (var item in totalHours.intervals) {
      chartData.add(CumulativeChartData(
          DateFormat('dd/MM/yyyy').format(item.intervalEndDateLocalTime),
          item.totalHours,
          item.totals.runtimeHours,
          item.totals.workingHours,
          item.totals.idleHours));
    }

    return <StackedColumnSeries<CumulativeChartData, String>>[
      shouldShowLabel[0]
          ? StackedColumnSeries<CumulativeChartData, String>(
              dataSource: chartData,
              color: emerald,
              width: 0.2,
              xValueMapper: (CumulativeChartData chartDate, _) => chartDate.x,
              yValueMapper: (CumulativeChartData chartDate, _) =>
                  chartDate.working,
            )
          : StackedColumnSeries<CumulativeChartData, String>(
              dataSource: [],
              xValueMapper: (CumulativeChartData chartDate, _) => '',
              yValueMapper: (CumulativeChartData chartDate, _) => 0,
            ),
      shouldShowLabel[1]
          ? StackedColumnSeries<CumulativeChartData, String>(
              dataSource: chartData,
              color: burntSienna,
              width: 0.2,
              xValueMapper: (CumulativeChartData chartDate, _) => chartDate.x,
              yValueMapper: (CumulativeChartData chartDate, _) =>
                  chartDate.idle,
            )
          : StackedColumnSeries<CumulativeChartData, String>(
              dataSource: [],
              xValueMapper: (CumulativeChartData chartDate, _) => '',
              yValueMapper: (CumulativeChartData chartDate, _) => 0,
            ),
      shouldShowLabel[2]
          ? StackedColumnSeries<CumulativeChartData, String>(
              dataSource: chartData,
              color: creamCan,
              width: 0.2,
              xValueMapper: (CumulativeChartData chartDate, _) => chartDate.x,
              yValueMapper: (CumulativeChartData chartDate, _) =>
                  chartDate.runtime,
            )
          : StackedColumnSeries<CumulativeChartData, String>(
              dataSource: [],
              xValueMapper: (CumulativeChartData chartDate, _) => '',
              yValueMapper: (CumulativeChartData chartDate, _) => 0,
            ),
    ];
  }
}

class CumulativeChartData {
  final String x;
  final double totalHours;
  final double runtime;
  final double working;
  final double idle;

  CumulativeChartData(
      this.x, this.totalHours, this.runtime, this.working, this.idle);
}
