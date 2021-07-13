import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/core/models/asset_status.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:logger/logger.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class IdlingLevel extends StatefulWidget {
  final List<Count> data;
  final bool isLoading;
  final Function(FilterData) onFilterSelected;

  IdlingLevel({this.data, this.isLoading, this.onFilterSelected});
  @override
  _IdlingLevelState createState() => _IdlingLevelState();
}

class _IdlingLevelState extends State<IdlingLevel> {
  String calendar;

  @override
  void initState() {
    calendar = 'DAY';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.47;
    double maxheight = MediaQuery.of(context).size.height * 0.33;
    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [new BoxShadow(blurRadius: 1.0, color: cardcolor)],
        border: Border.all(width: 2.5, color: cardcolor),
        shape: BoxShape.rectangle,
      ),
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
                        new Text(
                          "IDLING LEVEL",
                          style: new TextStyle(
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Roboto',
                              color: textcolor,
                              fontStyle: FontStyle.normal,
                              fontSize: 12.0),
                        ),
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
                color: black,
              ),
              widget.isLoading
                  ? Expanded(child: Center(child: CircularProgressIndicator()))
                  : Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                                height: maxheight,
                                child: SfCartesianChart(
                                    isTransposed: true,
                                    plotAreaBorderWidth: 0,
                                    primaryXAxis: CategoryAxis(
                                      labelStyle: TextStyle(
                                          color: textcolor,
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Roboto',
                                          fontStyle: FontStyle.normal),
                                      majorGridLines: MajorGridLines(
                                          width: 0, color: silver),
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
                                      Count countDatum =
                                          widget.data[pointTapArgs.pointIndex];
                                      FilterData data = FilterData(
                                          isSelected: true,
                                          count: countDatum.count.toString(),
                                          title: countDatum.countOf,
                                          type: FilterType.IDLING_LEVEL);
                                      widget.onFilterSelected(data);
                                    },
                                    primaryYAxis: NumericAxis(
                                        majorGridLines: MajorGridLines(
                                            width: 2, color: silver),
                                        labelStyle: TextStyle(
                                            color: textcolor,
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Roboto',
                                            fontStyle: FontStyle.normal)),
                                    series: _getDefaultBarSeries())),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              toggelButton(),
                              SizedBox(
                                height: 10.0,
                              ),
                              new Text(
                                widget.data[0].count.toString() +
                                    "\n" +
                                    "assets" +
                                    "\n" +
                                    "excluded",
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 9.0,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                    color: textcolor),
                              )
                            ],
                          )
                        ],
                      ),
                    )
            ],
          ),
        ],
      ),
    );
  }

  Widget toggelButton() {
    return Container(
      width: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [new BoxShadow(blurRadius: 1.0, color: bgcolor)],
        shape: BoxShape.rectangle,
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              print(" 1 button is tapped");
              chooseCalendarType("DAY");
            },
            child: Container(
              width: 55,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: calendar == 'DAY' ? tango : bgcolor,
                shape: BoxShape.rectangle,
              ),
              child: Text("DAY",
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Roboto',
                      color: textcolor,
                      fontStyle: FontStyle.normal)),
            ),
          ),
          Container(
              width: 55, child: Divider(thickness: 1.0, color: athenGrey)),
          GestureDetector(
            onTap: () {
              print(" 2 button is tapped ");
              chooseCalendarType('WEEK');
            },
            child: Container(
              width: 55,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: calendar == 'WEEK' ? tango : bgcolor,
                shape: BoxShape.rectangle,
              ),
              child: Text("WEEK",
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Roboto',
                      color: textcolor,
                      fontStyle: FontStyle.normal)),
            ),
          ),
          Container(
              width: 55, child: Divider(thickness: 1.0, color: athenGrey)),
          GestureDetector(
            onTap: () {
              print('3 button is tapped ');
              chooseCalendarType('MONTH');
            },
            child: Container(
              width: 55,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: calendar == 'MONTH' ? tango : bgcolor,
                shape: BoxShape.rectangle,
              ),
              child: Text("MONTH",
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Roboto',
                      color: textcolor,
                      fontStyle: FontStyle.normal)),
            ),
          )
        ],
      ),
    );
  }

  chooseCalendarType(String s) {
    setState(() {
      calendar = s;
    });
  }

  // // Color getColor(String countOf) {
  // //   switch (countOf) {
  // //     case '[0,10]':
  // //       return burntSienna;
  // //       break;
  // //     case '[10,15]':
  // //       return silver;
  // //       break;
  // //     case '[15,25]':
  // //       return mustard;
  // //       break;
  // //     case '[25,]':
  // //       return emerald;
  // //       break;
  // //     default:
  // //       return Colors.lightBlueAccent;
  // //   }
  // }

  List<BarSeries<IdlingLevelSampleData, String>> _getDefaultBarSeries() {
    List<IdlingLevelSampleData> chartData = [];
    chartData.add(
      IdlingLevelSampleData(
          x: widget.data[1].countOf,
          y: widget.data[1].count,
          color: burntSienna),
    );
    chartData.add(IdlingLevelSampleData(
        x: widget.data[2].countOf, y: widget.data[2].count, color: silver));
    chartData.add(
      IdlingLevelSampleData(
          x: widget.data[3].countOf, y: widget.data[3].count, color: mustard),
    );
    chartData.add(
      IdlingLevelSampleData(
          x: widget.data[4].countOf, y: widget.data[4].count, color: emerald),
    );

    return <BarSeries<IdlingLevelSampleData, String>>[
      BarSeries<IdlingLevelSampleData, String>(
          dataSource: chartData,
          dataLabelSettings: DataLabelSettings(
              isVisible: true,
              textStyle: new TextStyle(
                  color: textcolor,
                  fontSize: 10.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.normal),
              labelPosition: ChartDataLabelPosition.outside),
          pointColorMapper: (IdlingLevelSampleData charts, _) => charts.color,
          xValueMapper: (IdlingLevelSampleData charts, _) => charts.x,
          yValueMapper: (IdlingLevelSampleData charts, _) => charts.y),
    ];
  }
}

class IdlingLevelSampleData {
  final String x;
  final int y;
  final Color color;
  IdlingLevelSampleData({this.x, this.y, this.color});
}
