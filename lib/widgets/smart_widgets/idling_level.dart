import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/core/models/idling_level_model.dart';
import 'package:insite/theme/colors.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class IdlingLevel extends StatefulWidget {
  @override
  _IdlingLevelState createState() => _IdlingLevelState();
}

class _IdlingLevelState extends State<IdlingLevel> {
  var chartDisplay;
  String calendar;

  @override
  void initState() {
    calendar = '';
    setState(() {
      var series = [
        charts.Series(
            domainFn: (IdlingLevelData addcharts, _) => addcharts.percentage,
            measureFn: (IdlingLevelData addcharts, _) => addcharts.level,
            colorFn: (IdlingLevelData addcharts, _) => addcharts.color,
            id: 'addcharts',
            data: data)
      ];
      chartDisplay = charts.BarChart(series,
          animationDuration: Duration(microseconds: 2000),
          barGroupingType: charts.BarGroupingType.grouped,
          animate: true,
          domainAxis: new charts.OrdinalAxisSpec(
              renderSpec: new charts.SmallTickRendererSpec(
                  labelStyle: new charts.TextStyleSpec(
                      fontSize: 9, // size in Pts.
                      color: charts.MaterialPalette.white,
                      fontFamily: 'Roboto',
                      fontWeight: 'bold'),
                  lineStyle: new charts.LineStyleSpec(
                      color: charts.MaterialPalette.white))),
          primaryMeasureAxis: new charts.NumericAxisSpec(
              renderSpec: new charts.GridlineRendererSpec(
                  labelStyle: new charts.TextStyleSpec(
                      fontSize: 9, // size in Pts.
                      color: charts.MaterialPalette.white,
                      fontFamily: 'Roboto',
                      fontWeight: 'bold'),
                  lineStyle: new charts.LineStyleSpec(
                      color: charts.MaterialPalette.white))),
          defaultRenderer: new charts.BarRendererConfig(
              cornerStrategy: const charts.ConstCornerStrategy(5)));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double maxheight = .30 * MediaQuery.of(context).size.height;
    double maxwidth = .65 * MediaQuery.of(context).size.width;
    return Container(
      width: 330.13,
      height: 261.16,
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
                ),
              ),
              Divider(
                thickness: 1.0,
                color: black,
              ),
              Stack(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: maxheight,
                        width: maxwidth,
                        child: chartDisplay,
                      ),
                      new Container(
                        width: 75,
                        height: 170,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            toggelButton(),
                            SizedBox(
                              height: 35.0,
                            ),
                            new Text(
                              "1212\nassets\nexcluded",
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 9.0,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  color: textcolor),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget toggelButton() {
    return Container(
      width: 52.5,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [new BoxShadow(blurRadius: 1.0, color: bgcolor)],
        border: Border.all(width: 2.5, color: bgcolor),
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
              width: 52.5,
              height: 20.89,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  new BoxShadow(
                      blurRadius: 1.0,
                      color: calendar == 'DAY' ? tango : bgcolor)
                ],
                border: Border.all(
                    width: 2.5, color: calendar == 'DAY' ? tango : bgcolor),
                shape: BoxShape.rectangle,
              ),
              child: Text("DAY",
                  style: new TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Roboto',
                      color: textcolor,
                      fontStyle: FontStyle.normal)),
            ),
          ),
          Container(
              width: 52.5, child: Divider(thickness: 1.0, color: athenGrey)),
          GestureDetector(
            onTap: () {
              print(" 2 button is tapped ");
              chooseCalendarType('WEEK');
            },
            child: Container(
              width: 52.5,
              height: 20.89,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  new BoxShadow(
                      blurRadius: 1.0,
                      color: calendar == "WEEK" ? tango : bgcolor)
                ],
                border: Border.all(
                    width: 2.5, color: calendar == "WEEK" ? tango : bgcolor),
                shape: BoxShape.rectangle,
              ),
              child: Text("WEEK",
                  style: new TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Roboto',
                      color: textcolor,
                      fontStyle: FontStyle.normal)),
            ),
          ),
          Container(
              width: 52.5, child: Divider(thickness: 1.0, color: athenGrey)),
          GestureDetector(
            onTap: () {
              print('3 button is tapped ');
              chooseCalendarType('MONTH');
            },
            child: Container(
              width: 52.5,
              height: 20.89,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  new BoxShadow(
                      blurRadius: 1.0,
                      color: calendar == 'MONTH' ? tango : bgcolor)
                ],
                border: Border.all(
                    width: 2.5, color: calendar == 'MONTH' ? tango : bgcolor),
                shape: BoxShape.rectangle,
              ),
              child: Text("MONTH",
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
}
