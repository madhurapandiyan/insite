import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/core/models/idling_level.dart';
import 'package:insite/theme/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class IdlingLevel extends StatefulWidget {
  final List<CountDatum> data;
  final bool isLoading;

  IdlingLevel({this.data, this.isLoading});
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
    double maxheight = MediaQuery.of(context).size.height * 0.32;

    return Container(
      height: 333.00,
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
                        SvgPicture.asset("assets/images/arrowdown.svg"),
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
                        GestureDetector(
                          onTap: () => print("button is tapped"),
                          child: SvgPicture.asset(
                            "assets/images/menu.svg",
                            width: 20,
                            height: 20,
                          ),
                        ),
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
