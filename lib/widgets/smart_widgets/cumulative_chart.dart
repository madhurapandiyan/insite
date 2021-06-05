import 'package:flutter/cupertino.dart';
import 'package:insite/core/models/cumulative.dart';
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
        plotAreaBorderWidth: 0,
        title: ChartTitle(text: 'Quarterly wise sales of products'),
        legend:
            Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
        primaryXAxis: CategoryAxis(
          majorGridLines: MajorGridLines(width: 0),
        ),
        series: _getStackedColumnSeries(),
        primaryYAxis: NumericAxis(
            axisLine: AxisLine(width: 0),
            labelFormat: '{value}K',
            maximum: 300,
            majorTickLines: MajorTickLines(size: 0)),
        tooltipBehavior: TooltipBehavior(),
      ),
    );
  }

  List<StackedColumnSeries<ChartSampleData, String>> _getStackedColumnSeries() {
    final List<ChartSampleData> chartData = <ChartSampleData>[
      ChartSampleData('Q1', 50, 55, 72, 65),
    ];
    return <StackedColumnSeries<ChartSampleData, String>>[
      StackedColumnSeries<ChartSampleData, String>(
          dataSource: chartData,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.y,
          name: 'Product A'),
      StackedColumnSeries<ChartSampleData, String>(
          dataSource: chartData,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.yValue,
          name: 'Product B'),
    ];
  }
}

class ChartSampleData {
  final String x;
  final int y;
  final int yValue;
  final int secondSeriesYValue;
  final int thirdSeriesYValue;

  ChartSampleData(this.x, this.y, this.yValue, this.secondSeriesYValue,
      this.thirdSeriesYValue);
}
