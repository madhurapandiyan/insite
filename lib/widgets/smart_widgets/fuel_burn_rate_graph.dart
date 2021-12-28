import 'package:flutter/material.dart';
import 'package:insite/core/models/fuel_burn_rate_trend.dart';
import 'package:insite/theme/colors.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FuelBurnRateGraph extends StatelessWidget {
  final int rangeSelection;
  final FuelBurnRateTrend? fuelBurnRateTrend;
  final List<bool>? shouldShowLabel;
  const FuelBurnRateGraph(
      {Key? key,
      required this.rangeSelection,
      required this.fuelBurnRateTrend,
      this.shouldShowLabel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SfCartesianChart(
        title: ChartTitle(
            textStyle:
                TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),
            text: ''),
        primaryXAxis: CategoryAxis(
          title: AxisTitle(
              text: '',
              textStyle: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color)),
          labelStyle:
              TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),
          majorGridLines: MajorGridLines(width: 0),
          labelRotation: 270,
        ),
        series: _getStackedColumnSeries(),
        primaryYAxis: NumericAxis(
          title: AxisTitle(
              text: 'Fuel Burned Rate (Liters per hour)',
              textStyle: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color)),
          numberFormat: NumberFormat.compact(),
          axisLine: AxisLine(width: 1),
          labelStyle:
              TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),
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

    for (var item in fuelBurnRateTrend!.intervals!) {
      chartData.add(CumulativeChartData(
          DateFormat('dd/MM/yyyy').format(item.intervalEndDateLocalTime!),
          item.burnrates!.idleFuelBurnRate,
          item.burnrates!.workingFuelBurnRate,
          item.burnrates!.runtimeFuelBurnRate));
    }

    return <SplineSeries<CumulativeChartData, String>>[
      shouldShowLabel![1]
          ? SplineSeries<CumulativeChartData, String>(
              dataSource: chartData,
              splineType: SplineType.natural,
              color: burntSienna,
              width: 2,
              xValueMapper: (CumulativeChartData chartDate, _) => chartDate.x,
              yValueMapper: (CumulativeChartData chartDate, _) =>
                  chartDate.idleBurnRate,
            )
          : SplineSeries<CumulativeChartData, String>(
              dataSource: [],
              xValueMapper: (CumulativeChartData chartDate, _) => '',
              yValueMapper: (CumulativeChartData chartDate, _) => 0,
            ),
      shouldShowLabel![0]
          ? SplineSeries<CumulativeChartData, String>(
              dataSource: chartData,
              splineType: SplineType.natural,
              color: emerald,
              width: 2,
              xValueMapper: (CumulativeChartData chartDate, _) => chartDate.x,
              yValueMapper: (CumulativeChartData chartDate, _) =>
                  chartDate.workingBurnRate,
            )
          : SplineSeries<CumulativeChartData, String>(
              dataSource: [],
              xValueMapper: (CumulativeChartData chartDate, _) => '',
              yValueMapper: (CumulativeChartData chartDate, _) => 0,
            ),
      shouldShowLabel![2]
          ? SplineSeries<CumulativeChartData, String>(
              dataSource: chartData,
              splineType: SplineType.natural,
              color: creamCan,
              width: 2,
              xValueMapper: (CumulativeChartData chartDate, _) => chartDate.x,
              yValueMapper: (CumulativeChartData chartDate, _) =>
                  chartDate.runtimeBurnRate,
            )
          : SplineSeries<CumulativeChartData, String>(
              dataSource: [],
              xValueMapper: (CumulativeChartData chartDate, _) => '',
              yValueMapper: (CumulativeChartData chartDate, _) => 0,
            ),
    ];
  }
}

class CumulativeChartData {
  final String x;
  final double? idleBurnRate;
  final double? workingBurnRate;
  final double? runtimeBurnRate;

  CumulativeChartData(
    this.x,
    this.idleBurnRate,
    this.workingBurnRate,
    this.runtimeBurnRate,
  );
}
