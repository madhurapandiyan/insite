import 'package:flutter/cupertino.dart';
import 'package:insite/core/models/cumulative.dart';
import 'package:insite/theme/colors.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CumulativeChart extends StatelessWidget {
  final RunTimeCumulative runTimeCumulative;
  final FuelBurnedCumulative fuelBurnedCumulative;

  const CumulativeChart(
      {Key key, this.runTimeCumulative, this.fuelBurnedCumulative})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SfCartesianChart(
        title: ChartTitle(
            textStyle: TextStyle(color: white),
            text: runTimeCumulative == null
                ? 'Daily average: ${fuelBurnedCumulative.cumulatives.averageFuelBurned.toStringAsFixed(2)} Liters'
                : 'Daily average: ${runTimeCumulative.cumulatives.averageHours.toStringAsFixed(2)} Hours'),
        primaryXAxis: CategoryAxis(
          title: AxisTitle(
              text: runTimeCumulative == null
                  ? 'Total Fuel Burned: ${fuelBurnedCumulative.cumulatives.totalFuelBurned.toStringAsFixed(2)}'
                  : 'Total Hours: ${runTimeCumulative.cumulatives.cumulativeHours.toStringAsFixed(2)}',
              textStyle: TextStyle(color: white)),
          majorGridLines: MajorGridLines(width: 0),
        ),
        series: runTimeCumulative == null
            ? _getStackedColumnSeries(fuelBurnedCumulative)
            : _getStackedColumnSeries(runTimeCumulative),
        primaryYAxis: NumericAxis(
          title: AxisTitle(
              text: runTimeCumulative == null
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
  final double runtime;
  final double working;
  final double idle;

  CumulativeChartData(this.x, this.runtime, this.working, this.idle);
}
