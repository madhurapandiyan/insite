import 'package:flutter/material.dart';
import 'package:insite/core/models/idle_percent_trend.dart';
import 'package:insite/theme/colors.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class IdleTrendGraph extends StatelessWidget {
  final int rangeSelection;
  final IdlePercentTrend? idlePercentTrend;

  const IdleTrendGraph({
    Key? key,
    required this.rangeSelection,
    required this.idlePercentTrend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    idlePercentTrend?.intervals?.forEach((element) {
      Logger().w(element.toJson());
    });
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
        ),
        primaryYAxis: NumericAxis(
            title: AxisTitle(
                text: '',
                textStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1!.color)),
            numberFormat: NumberFormat.compact(),
            axisLine: AxisLine(width: 1),
            labelStyle:
                TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),
            majorGridLines: MajorGridLines(width: 0),
            minimum: 0,
            maximum: 25,
            labelFormat: '{value}%'),
        series: <SplineSeries<CumulativeChartData, String>>[
          SplineSeries<CumulativeChartData, String>(
              // Bind data source
              markerSettings: MarkerSettings(
             isVisible: true,
             height: 20,
             width: 20,
             shape: DataMarkerType.circle,
             borderWidth: 3,
             color: tango,
             borderColor:tango),
              dataSource: idlePercentTrend!.intervals!.map((e) {
                return CumulativeChartData(
                    DateFormat('dd/MM/yyyy')
                        .format(e.intervalEndDateLocalTime!),
                    e.idlePercentage);
              }).toList(),
              xValueMapper: (CumulativeChartData sales, _) => sales.x,
              yValueMapper: (CumulativeChartData sales, _) => sales.percentage)
        ],
        tooltipBehavior: TooltipBehavior(),
        plotAreaBorderWidth: 0,
      ),
    );
  }

  List<SplineSeries<CumulativeChartData, String>> _getStackedColumnSeries(
      BuildContext context) {
    final List<CumulativeChartData> chartData = <CumulativeChartData>[];

    if (idlePercentTrend == null)
      return <SplineSeries<CumulativeChartData, String>>[];

    for (var item in idlePercentTrend!.intervals!) {
      chartData.add(CumulativeChartData(
          DateFormat('dd/MM/yyyy').format(item.intervalEndDateLocalTime!),
          item.idlePercentage));
    }
    <SplineSeries<CumulativeChartData, String>>[
      SplineSeries<CumulativeChartData, String>(
        dataSource: chartData,
        splineType: SplineType.natural,
        color: Theme.of(context).buttonColor,
        width: 1,
        xValueMapper: (CumulativeChartData chartDate, _) => chartDate.x,
        yValueMapper: (CumulativeChartData chartDate, _) =>
            chartDate.percentage,
      ),
    ].forEach((element) {
      element.dataSource.forEach((element1) {
        Logger().i(element1.percentage);
      });
    });
    // List<SplineSeries<CumulativeChartData, String>> data = [];

    // chartData.forEach((element) {
    //   data.add(SplineSeries<CumulativeChartData, String>(
    //       splineType: SplineType.natural,
    //       color: Theme.of(context).buttonColor,
    //       width: 1,
    //       xValueMapper: (CumulativeChartData chartDate, _) => chartDate.x,
    //       yValueMapper: (CumulativeChartData chartDate, _) =>
    //           chartDate.percentage,
    //       dataSource: chartData));
    // });

    // return data;

    return <SplineSeries<CumulativeChartData, String>>[
      SplineSeries<CumulativeChartData, String>(
        dataSource: chartData,
        splineType: SplineType.natural,
        color: Theme.of(context).buttonColor,
        width: 1,
        xValueMapper: (CumulativeChartData chartDate, _) => chartDate.x,
        yValueMapper: (CumulativeChartData chartDate, _) =>
            chartDate.percentage,
      ),
    ];
  }
}

class CumulativeChartData {
  final String x;
  final double? percentage;

  CumulativeChartData(
    this.x,
    this.percentage,
  );
}
