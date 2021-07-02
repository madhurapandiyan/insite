import 'package:flutter/cupertino.dart';
import 'package:insite/core/models/cumulative.dart';
import 'package:insite/theme/colors.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CumulativeChart extends StatelessWidget {
  final RunTimeCumulative runTimeCumulative;
  final FuelBurnedCumulative fuelBurnedCumulative;
  final CumulativeChartType cumulativeChartType;
  final List<bool> shouldShowLabel;

  const CumulativeChart(
      {Key key,
      this.runTimeCumulative,
      this.fuelBurnedCumulative,
      this.cumulativeChartType,
      this.shouldShowLabel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (runTimeCumulative == null && fuelBurnedCumulative == null)
          ? SfCartesianChart(
              title: ChartTitle(
                  textStyle: TextStyle(color: white),
                  text: cumulativeChartType == CumulativeChartType.FUELBURNED
                      ? 'Daily average: NA'
                      : 'Daily average: NA'),
              primaryXAxis: CategoryAxis(
                title: AxisTitle(
                    text: cumulativeChartType == CumulativeChartType.FUELBURNED
                        ? 'Total Fuel Burned: NA'
                        : 'Total Hours: NA',
                    textStyle: TextStyle(color: white)),
                majorGridLines: MajorGridLines(width: 0),
              ),
              series: cumulativeChartType == CumulativeChartType.FUELBURNED
                  ? _getStackedColumnSeries(fuelBurnedCumulative)
                  : _getStackedColumnSeries(runTimeCumulative),
              primaryYAxis: NumericAxis(
                title: AxisTitle(
                    text: cumulativeChartType == CumulativeChartType.FUELBURNED
                        ? 'Cumulative Fuel Burned (Liters)'
                        : 'Cumulative Runtime (Hours)',
                    textStyle: TextStyle(color: white)),
                axisLine: AxisLine(width: 1),
                labelStyle: TextStyle(color: white),
                numberFormat: NumberFormat.compact(),
                majorGridLines: MajorGridLines(width: 0),
              ),
              tooltipBehavior: TooltipBehavior(),
              plotAreaBorderWidth: 0,
            )
          : SfCartesianChart(
              title: ChartTitle(
                  textStyle: TextStyle(color: white),
                  text: cumulativeChartType == CumulativeChartType.FUELBURNED
                      ? 'Daily average: ${fuelBurnedCumulative.cumulatives.averageFuelBurned.toStringAsFixed(2)} Liters'
                      : 'Daily average: ${runTimeCumulative.cumulatives.averageHours.toStringAsFixed(2)} Hours'),
              primaryXAxis: CategoryAxis(
                title: AxisTitle(
                    text: cumulativeChartType == CumulativeChartType.FUELBURNED
                        ? 'Total Fuel Burned: ${fuelBurnedCumulative.cumulatives.totalFuelBurned.toStringAsFixed(2)}'
                        : 'Total Hours: ${runTimeCumulative.cumulatives.cumulativeHours.toStringAsFixed(2)}',
                    textStyle: TextStyle(color: white)),
                majorGridLines: MajorGridLines(width: 0),
              ),
              series: cumulativeChartType == CumulativeChartType.FUELBURNED
                  ? _getStackedColumnSeries(fuelBurnedCumulative)
                  : _getStackedColumnSeries(runTimeCumulative),
              primaryYAxis: NumericAxis(
                title: AxisTitle(
                    text: cumulativeChartType == CumulativeChartType.FUELBURNED
                        ? 'Cumulative Fuel Burned (Liters)'
                        : 'Cumulative Runtime (Hours)',
                    textStyle: TextStyle(color: white)),
                axisLine: AxisLine(width: 1),
                labelStyle: TextStyle(color: white),
                numberFormat: NumberFormat.compact(),
                majorGridLines: MajorGridLines(width: 0),
              ),
              tooltipBehavior: TooltipBehavior(),
              plotAreaBorderWidth: 0,
            ),
    );
  }

  List<StackedColumnSeries<CumulativeChartData, String>>
      _getStackedColumnSeries(dynamic data) {
    final List<CumulativeChartData> chartData = <CumulativeChartData>[];

    if (data.runtimeType == RunTimeCumulative) {
      chartData.add(CumulativeChartData(
          '',
          data.cumulatives.totals.runtimeHours,
          data.cumulatives.totals.workingHours,
          data.cumulatives.totals.idleHours));
    }

    if (data.runtimeType == FuelBurnedCumulative) {
      chartData.add(CumulativeChartData(
          '',
          data.cumulatives.totals.runtimeFuelBurned,
          data.cumulatives.totals.workingFuelBurned,
          data.cumulatives.totals.idleFuelBurned));
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
  final double runtime;
  final double working;
  final double idle;

  CumulativeChartData(this.x, this.runtime, this.working, this.idle);
}

enum CumulativeChartType { RUNTIME, FUELBURNED }
