import 'package:flutter/material.dart';
import 'package:insite/core/models/fuel_burn_rate_trend.dart';
import 'package:insite/theme/colors.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FuelBurnRateGraph extends StatelessWidget {
  final int rangeSelection;
  final FuelBurnRateTrend fuelBurnRateTrend;
  const FuelBurnRateGraph(
      {Key key,
      @required this.rangeSelection,
      @required this.fuelBurnRateTrend})
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
          title: AxisTitle(
              text: 'Fuel Burned Rate (Liters per hour)',
              textStyle: TextStyle(color: white)),
          numberFormat: NumberFormat.compact(),
          axisLine: AxisLine(width: 1),
          labelStyle: TextStyle(color: white),
          majorGridLines: MajorGridLines(width: 0),
        ),
        tooltipBehavior: TooltipBehavior(),
        plotAreaBorderWidth: 0,
      ),
    );
  }

  List<SplineSeries<CumulativeChartData, String>> _getStackedColumnSeries() {
    final List<CumulativeChartData> chartData = <CumulativeChartData>[];

    if (fuelBurnRateTrend == null)
      return <SplineSeries<CumulativeChartData, String>>[];

    for (var item in fuelBurnRateTrend.intervals) {
      chartData.add(CumulativeChartData(
          DateFormat('dd/MM/yyyy').format(item.intervalEndDateLocalTime),
          item.burnrates.idleFuelBurnRate,
          item.burnrates.workingFuelBurnRate,
          item.burnrates.runtimeFuelBurnRate));
    }

    return <SplineSeries<CumulativeChartData, String>>[
      SplineSeries<CumulativeChartData, String>(
        dataSource: chartData,
        splineType: SplineType.natural,
        color: burntSienna,
        width: 2,
        xValueMapper: (CumulativeChartData chartDate, _) => chartDate.x,
        yValueMapper: (CumulativeChartData chartDate, _) =>
            chartDate.idleBurnRate,
      ),
      SplineSeries<CumulativeChartData, String>(
        dataSource: chartData,
        splineType: SplineType.natural,
        color: emerald,
        width: 2,
        xValueMapper: (CumulativeChartData chartDate, _) => chartDate.x,
        yValueMapper: (CumulativeChartData chartDate, _) =>
            chartDate.workingBurnRate,
      ),
      SplineSeries<CumulativeChartData, String>(
        dataSource: chartData,
        splineType: SplineType.natural,
        color: creamCan,
        width: 2,
        xValueMapper: (CumulativeChartData chartDate, _) => chartDate.x,
        yValueMapper: (CumulativeChartData chartDate, _) =>
            chartDate.runtimeBurnRate,
      ),
    ];
  }
}

class CumulativeChartData {
  final String x;
  final double idleBurnRate;
  final double workingBurnRate;
  final double runtimeBurnRate;

  CumulativeChartData(
    this.x,
    this.idleBurnRate,
    this.workingBurnRate,
    this.runtimeBurnRate,
  );
}
