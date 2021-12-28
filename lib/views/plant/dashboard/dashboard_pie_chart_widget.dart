import 'package:flutter/material.dart';
import 'package:insite/core/models/assetstatus_model.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardPieChartWidget extends StatefulWidget {
  final List<ChartSampleData>? data;
  final String? title;
  final String? title2;
  final bool? isLoading;
  final bool? isRefreshing;
  final Function(String?)? onFilterSelected;
  const DashboardPieChartWidget(
      {Key? key,
      this.data,
      this.title,
      this.isLoading,
      this.isRefreshing,
      this.onFilterSelected,
      this.title2})
      : super(key: key);

  @override
  _DashboardPieChartWidgetState createState() =>
      _DashboardPieChartWidgetState();
}

class _DashboardPieChartWidgetState extends State<DashboardPieChartWidget> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.45;
    double maxheight = MediaQuery.of(context).size.height * 0.33;
    return Card(
        child: Container(
      height: height,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // SvgPicture.asset("assets/images/arrowdown.svg"),
                    SizedBox(
                      width: 10,
                    ),
                    InsiteText(
                        text: "ACTIVATED ASSETS - " +
                            DateFormat.yMMMM().format(DateTime.now()),
                        fontWeight: FontWeight.w900,
                        size: 12.0),
                  ],
                ),
                Row(
                  children: [
                    // GestureDetector(
                    //   onTap: () => print("button is tapped"),
                    //   child: SvgPicture.asset(
                    //     "assets/images/menu.svg",
                    //     width: 20,
                    //     height: 20,
                    //   ),
                    // ),
                  ],
                )
              ],
            ),
          ),
          Divider(
            thickness: 1.0,
            color: Theme.of(context).dividerColor,
          ),
          widget.isLoading!
              ? Expanded(child: InsiteProgressBar())
              : Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        //flex: 1,
                        child: Container(
                          height: maxheight,
                          child: SfCartesianChart(
                            isTransposed: true,
                            plotAreaBorderWidth: 0,
                            primaryXAxis: CategoryAxis(
                              labelStyle: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Roboto',
                                  fontStyle: FontStyle.normal),
                              majorGridLines: MajorGridLines(
                                  width: 0,
                                  color: Theme.of(context).backgroundColor),
                            ),
                            onAxisLabelTapped: (axisLabelTapArgs) {
                              Logger().d("onAxisLabelTapped " +
                                  axisLabelTapArgs.toString());
                            },
                            onDataLabelTapped: (onTapArgs) {
                              Logger().d(
                                  "onDataLabelTapped " + onTapArgs.toString());
                            },
                            onLegendTapped: (legendTapArgs) {
                              Logger().d(
                                  "onLegendTapped " + legendTapArgs.toString());
                            },
                            onPointTapped: (pointTapArgs) {
                              try {
                                Logger().d("onPointTapped " +
                                    pointTapArgs.pointIndex.toString() +
                                    " " +
                                    pointTapArgs.seriesIndex.toString() +
                                    " " +
                                    pointTapArgs.viewportPointIndex.toString());
                                widget.onFilterSelected!(
                                    widget.data![pointTapArgs.pointIndex!].z);
                              } catch (e) {}
                            },
                            primaryYAxis: NumericAxis(
                                majorGridLines: MajorGridLines(
                                    width: 0,
                                    color: Theme.of(context).backgroundColor),
                                labelStyle: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color,
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Roboto',
                                    fontStyle: FontStyle.normal)),
                            series: _getDefaultBarSeries(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    ));
  }

  List<BarSeries<ChartSampleData, String>> _getDefaultBarSeries() {
    return <BarSeries<ChartSampleData, String>>[
      BarSeries<ChartSampleData, String>(
          dataSource: widget.data!,
          isVisibleInLegend: true,
          dataLabelSettings: DataLabelSettings(
              isVisible: true,
              textStyle: new TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                  fontSize: 10.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.normal),
              labelPosition: ChartDataLabelPosition.outside),
          pointColorMapper: (ChartSampleData charts, _) =>
              getColorData(charts.x),
          xValueMapper: (ChartSampleData charts, _) => charts.x,
          yValueMapper: (ChartSampleData charts, _) => charts.y),
    ];
  }

  Color? getColorData(String? data) {
    switch (data) {
      case "Today":
        return burntSienna;
      case "Week":
        return silver;
      case "Month":
        return mustard;
      default:
        return null;
    }
  }
}
