import 'package:flutter/material.dart';
import 'package:insite/core/models/asset_status.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:logger/logger.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class IdlingLevel extends StatefulWidget {
  final List<Count>? data;
  final bool? isLoading;
  final bool? isSwitching;
  final bool? isRefreshing;
  final Function(FilterData)? onFilterSelected;
  final Function? onRangeSelected;

  IdlingLevel(
      {this.data,
      this.isLoading,
      this.onFilterSelected,
      this.onRangeSelected,
      this.isRefreshing,
      this.isSwitching});
  @override
  _IdlingLevelState createState() => _IdlingLevelState();
}

class _IdlingLevelState extends State<IdlingLevel> {
  IdlingLevelRange idlingLevelRange = IdlingLevelRange.DAY;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.47;
    double maxheight = MediaQuery.of(context).size.height * 0.33;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        height: height,
        child: Stack(
          children: [
            Column(
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
                              text: "IDLING LEVEL",
                              fontWeight: FontWeight.w900,
                              size: 12.0),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 190.0,
                          ),
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
                (widget.isLoading! || widget.isRefreshing!)
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
                                  legend: Legend(
                                    isVisible: true,
                                    textStyle: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color),
                                    alignment: ChartAlignment.center,
                                    overflowMode: LegendItemOverflowMode.wrap,
                                    width: '100%',
                                    position: LegendPosition.bottom,
                                    isResponsive: true,
                                    toggleSeriesVisibility: false,
                                  ),
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
                                        color:
                                            Theme.of(context).backgroundColor),
                                  ),
                                  onAxisLabelTapped: (axisLabelTapArgs) {
                                    Logger().d("onAxisLabelTapped " +
                                        axisLabelTapArgs.toString());
                                  },
                                  onDataLabelTapped: (onTapArgs) {
                                    Logger().d("onDataLabelTapped " +
                                        onTapArgs.toString());
                                  },
                                  onLegendTapped: (legendTapArgs) {
                                    Logger().d("onLegendTapped " +
                                        legendTapArgs.toString());
                                  },
                                  onPointTapped: (pointTapArgs) {
                                    Logger().d("onPointTapped " +
                                        pointTapArgs.pointIndex.toString() +
                                        " " +
                                        pointTapArgs.seriesIndex.toString() +
                                        " " +
                                        pointTapArgs.viewportPointIndex
                                            .toString());
                                    Count countDatum = getCountDataFiltered()[
                                        pointTapArgs.pointIndex!];
                                    var x = countDatum.countOf!
                                        .split(",")
                                        .first
                                        .replaceAll("[", "")
                                        .replaceAll("]", "");
                                    var y = countDatum.countOf!
                                        .split(",")
                                        .last
                                        .replaceAll("[", "")
                                        .replaceAll("]", "");
                                    FilterData data = FilterData(
                                        isSelected: true,
                                        count: countDatum.count.toString(),
                                        title: countDatum.countOf,
                                        extras: [x, y],
                                        type: FilterType.IDLING_LEVEL);
                                    widget.onFilterSelected!(data);
                                  },
                                  primaryYAxis: NumericAxis(
                                      majorGridLines: MajorGridLines(
                                          width: 0,
                                          color: Theme.of(context)
                                              .backgroundColor),
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
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                toggelButton(),
                                SizedBox(
                                  height: 10.0,
                                ),
                                new InsiteText(
                                  text: widget.data![0].count.toString() +
                                      "\n" +
                                      "assets" +
                                      "\n" +
                                      "excluded",
                                  size: 9.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
              ],
            ),
            widget.isSwitching! ? InsiteProgressBar() : SizedBox()
          ],
        ),
      ),
    );
  }

  Widget toggelButton() {
    return Container(
      width: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: Theme.of(context).textTheme.bodyText1!.color!),
        boxShadow: [
          new BoxShadow(
              blurRadius: 1.0, color: Theme.of(context).backgroundColor)
        ],
        shape: BoxShape.rectangle,
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                idlingLevelRange = IdlingLevelRange.DAY;
                widget.onRangeSelected!(idlingLevelRange);
              });
            },
            child: Container(
                width: 55,
                alignment: Alignment.center,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: idlingLevelRange == IdlingLevelRange.DAY
                      ? Theme.of(context).buttonColor
                      : Theme.of(context).backgroundColor,
                  shape: BoxShape.rectangle,
                ),
                child: InsiteTextAlign(
                  text: "DAY",
                  textAlign: TextAlign.center,
                  color: idlingLevelRange == IdlingLevelRange.DAY
                      ? Colors.white
                      : Theme.of(context).textTheme.bodyText1!.color,
                  size: 11.0,
                  fontWeight: FontWeight.w700,
                )),
          ),
          Container(
              width: 55, child: Divider(thickness: 1.0, color: athenGrey)),
          GestureDetector(
            onTap: () {
              setState(() {
                idlingLevelRange = IdlingLevelRange.WEEK;
                widget.onRangeSelected!(idlingLevelRange);
              });
            },
            child: Container(
                width: 55,
                padding: EdgeInsets.all(8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: idlingLevelRange == IdlingLevelRange.WEEK
                      ? Theme.of(context).buttonColor
                      : Theme.of(context).backgroundColor,
                  shape: BoxShape.rectangle,
                ),
                child: InsiteTextAlign(
                  text: "WEEK",
                  textAlign: TextAlign.center,
                  size: 11.0,
                  color: idlingLevelRange == IdlingLevelRange.WEEK
                      ? Colors.white
                      : Theme.of(context).textTheme.bodyText1!.color,
                  fontWeight: FontWeight.w700,
                )),
          ),
          Container(
              width: 55, child: Divider(thickness: 1.0, color: athenGrey)),
          GestureDetector(
            onTap: () {
              setState(() {
                idlingLevelRange = IdlingLevelRange.MONTH;
                widget.onRangeSelected!(idlingLevelRange);
              });
            },
            child: Container(
                width: 55,
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: idlingLevelRange == IdlingLevelRange.MONTH
                      ? Theme.of(context).buttonColor
                      : Theme.of(context).backgroundColor,
                  shape: BoxShape.rectangle,
                ),
                child: InsiteTextAlign(
                  text: "MONTH",
                  textAlign: TextAlign.center,
                  color: idlingLevelRange == IdlingLevelRange.MONTH
                      ? Colors.white
                      : Theme.of(context).textTheme.bodyText1!.color,
                  size: 10.0,
                  fontWeight: FontWeight.w700,
                )),
          ),
        ],
      ),
    );
  }

  List<Count> getCountDataFiltered() {
    List<Count> chartData = [];
    for (Count count in widget.data!) {
      if (count.countOf != "Excluded") {
        chartData.add(count);
      }
    }
    return chartData;
  }

  List<BarSeries<IdlingLevelSampleData, String>> _getDefaultBarSeries() {
    List<IdlingLevelSampleData> chartData = [];
    for (Count count in widget.data!) {
      if (count.countOf != "Excluded") {
        print('idlingData:${widget.data![3].count}');
        chartData.add(
          IdlingLevelSampleData(
            x: Utils.getIdlingWidgetLabel(count.countOf),
            y: count.count,
          ),
        );
      }
    }

    return <BarSeries<IdlingLevelSampleData, String>>[
      BarSeries<IdlingLevelSampleData, String>(
          dataSource: chartData,
          isVisibleInLegend: true,
          legendItemText: "Unit x-axis (Idle %) , y-axis (Assets)",
          legendIconType: LegendIconType.horizontalLine,
          dataLabelSettings: DataLabelSettings(
              isVisible: true,
              textStyle: new TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                  fontSize: 10.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.normal),
              labelPosition: ChartDataLabelPosition.outside),
          pointColorMapper: (IdlingLevelSampleData charts, _) =>
              getColorData(charts.x),
          xValueMapper: (IdlingLevelSampleData charts, _) => charts.x,
          yValueMapper: (IdlingLevelSampleData charts, _) => charts.y),
    ];
  }

  Color? getColorData(String? data) {
    switch (data) {
      case "0-10%":
        return burntSienna;
      case "10-15%":
        return silver;
      case "15-25%":
        return mustard;
      case ">25%":
        return emerald;
      default:
        return null;
    }
  }
}

class IdlingLevelSampleData {
  final String? x;
  final int? y;

  IdlingLevelSampleData({this.x, this.y});
}
