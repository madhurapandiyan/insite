import 'package:flutter/material.dart';
import 'package:insite/core/models/total_fuel_burned.dart';
import 'package:insite/theme/colors.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TotalFuelBurnedGraph extends StatelessWidget {
  final int rangeSelection;
  final TotalFuelBurned totalFuelBurned;
  const TotalFuelBurnedGraph(
      {Key key, @required this.rangeSelection, @required this.totalFuelBurned})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SfCartesianChart(
        title: ChartTitle(
            textStyle: TextStyle(color: white),
            text: rangeSelection == 1
                ? 'Daily average: ${totalFuelBurned.cumulatives.averageFuelBurned.toStringAsFixed(2)} Liters'
                : rangeSelection == 2
                    ? 'Weekly average: ${totalFuelBurned.cumulatives.averageFuelBurned.toStringAsFixed(2)} Liters'
                    : 'Monthly average: ${totalFuelBurned.cumulatives.averageFuelBurned.toStringAsFixed(2)} Liters'),
        primaryXAxis: CategoryAxis(
          title: AxisTitle(text: '', textStyle: TextStyle(color: white)),
          labelStyle: TextStyle(color: white),
          majorGridLines: MajorGridLines(width: 0),
        ),
        series: _getStackedColumnSeries(),
        primaryYAxis: NumericAxis(
          title: AxisTitle(text: '', textStyle: TextStyle(color: white)),
          numberFormat: NumberFormat.compact(),
          axisLine: AxisLine(width: 1),
          labelStyle: TextStyle(color: white),
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

    for (var item in totalFuelBurned.intervals) {
      chartData.add(CumulativeChartData(
          DateFormat('dd/MM/yyyy').format(item.intervalEndDateLocalTime),
          item.totalFuelBurned,
          item.totals.runtimeFuelBurned,
          item.totals.workingFuelBurned,
          item.totals.idleFuelBurned));
    }

    return <StackedColumnSeries<CumulativeChartData, String>>[
      StackedColumnSeries<CumulativeChartData, String>(
        dataSource: chartData,
        color: emerald,
        width: 0.2,
        xValueMapper: (CumulativeChartData chartDate, _) => chartDate.x,
        yValueMapper: (CumulativeChartData chartDate, _) => chartDate.working,
      ),
      StackedColumnSeries<CumulativeChartData, String>(
        dataSource: chartData,
        color: burntSienna,
        width: 0.2,
        xValueMapper: (CumulativeChartData chartDate, _) => chartDate.x,
        yValueMapper: (CumulativeChartData chartDate, _) => chartDate.idle,
      ),
      StackedColumnSeries<CumulativeChartData, String>(
        dataSource: chartData,
        color: creamCan,
        width: 0.2,
        xValueMapper: (CumulativeChartData chartDate, _) => chartDate.x,
        yValueMapper: (CumulativeChartData chartDate, _) => chartDate.runtime,
      ),
    ];
  }
}

class CumulativeChartData {
  final String x;
  final double totalFuelBurned;
  final double runtime;
  final double working;
  final double idle;

  CumulativeChartData(
      this.x, this.totalFuelBurned, this.runtime, this.working, this.idle);
}
