import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/core/models/utilization_summary.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/utilization_legends.dart';

class AssetUtilizationWidget extends StatefulWidget {
  @override
  _AssetUtilizationWidgetState createState() => _AssetUtilizationWidgetState();

  const AssetUtilizationWidget({
    Key key,
    @required this.assetUtilization,
    @required this.isLoading,
  }) : super(key: key);

  final UtilizationSummary assetUtilization;
  final bool isLoading;
}

class _AssetUtilizationWidgetState extends State<AssetUtilizationWidget> {
  bool isAverageButtonSelected = true;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.3;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: height,
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
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                child: Column(
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
                              Text(
                                "Asset Utilization".toUpperCase(),
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
                                width: 210,
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
                        ? Expanded(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Column(
                            children: [
                              UtilizationLegends(
                                label1: 'Working',
                                label2: 'Idle',
                                label3: 'Running',
                                color1: emerald,
                                color2: burntSienna,
                                color3: creamCan,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    isAverageButtonSelected
                                        ? barChart(
                                            'Today',
                                            Utils.checkNull(widget
                                                .assetUtilization
                                                .averageDay
                                                .workingHours),
                                            Utils.checkNull(widget
                                                .assetUtilization
                                                .averageDay
                                                .idleHours),
                                            Utils.checkNull(widget
                                                .assetUtilization
                                                .averageDay
                                                .runtimeHours),
                                          )
                                        : barChart(
                                            'Today',
                                            Utils.checkNull(widget
                                                .assetUtilization
                                                .totalDay
                                                .workingHours),
                                            Utils.checkNull(widget
                                                .assetUtilization
                                                .totalDay
                                                .idleHours),
                                            Utils.checkNull(widget
                                                .assetUtilization
                                                .totalDay
                                                .runtimeHours),
                                          ),
                                    isAverageButtonSelected
                                        ? barChart(
                                            'Current Week',
                                            Utils.checkNull(widget
                                                .assetUtilization
                                                .averageWeek
                                                .workingHours),
                                            Utils.checkNull(widget
                                                .assetUtilization
                                                .averageWeek
                                                .idleHours),
                                            Utils.checkNull(widget
                                                .assetUtilization
                                                .averageWeek
                                                .runtimeHours),
                                          )
                                        : barChart(
                                            'Current Week',
                                            Utils.checkNull(widget
                                                .assetUtilization
                                                .totalWeek
                                                .workingHours),
                                            Utils.checkNull(widget
                                                .assetUtilization
                                                .totalWeek
                                                .idleHours),
                                            Utils.checkNull(widget
                                                .assetUtilization
                                                .totalWeek
                                                .runtimeHours),
                                          ),
                                    isAverageButtonSelected
                                        ? barChart(
                                            'Current Month',
                                            Utils.checkNull(widget
                                                .assetUtilization
                                                .averageMonth
                                                .workingHours),
                                            Utils.checkNull(widget
                                                .assetUtilization
                                                .averageMonth
                                                .idleHours),
                                            Utils.checkNull(widget
                                                .assetUtilization
                                                .averageMonth
                                                .runtimeHours),
                                          )
                                        : barChart(
                                            'Current Month',
                                            Utils.checkNull(widget
                                                .assetUtilization
                                                .totalMonth
                                                .workingHours),
                                            Utils.checkNull(widget
                                                .assetUtilization
                                                .totalMonth
                                                .idleHours),
                                            Utils.checkNull(widget
                                                .assetUtilization
                                                .totalMonth
                                                .runtimeHours),
                                          ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container barChart(String title, double workingValue, double idleValue,
          double runningValue) =>
      Container(
        width: MediaQuery.of(context).size.width * 0.25,
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
          color: ship_grey,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  color: ship_grey,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      barWidget(workingValue, emerald),
                      barWidget(idleValue, burntSienna),
                      barWidget(runningValue, creamCan),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.25,
                decoration: BoxDecoration(
                  color: black,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Center(
                  child: Text(
                    title.toUpperCase(),
                    style: TextStyle(
                        color: white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  double calculatePercentage(double value) {
    return ((value / 18) * 100);
  }

  Column barWidget(double value, Color color) {
    double totalBarHeight = MediaQuery.of(context).size.height * 0.12;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          '${value.toStringAsFixed(1)}',
          style: TextStyle(
              color: white, fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: 15,
          height: (totalBarHeight / 100) * calculatePercentage(value / 10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Container toggleButton() => Container(
        width: 130,
        height: 30,
        decoration: BoxDecoration(
          color: white,
          border: Border.all(color: tango, width: 2.0),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isAverageButtonSelected = true;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isAverageButtonSelected ? tango : white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Average'.toUpperCase(),
                      style: TextStyle(
                        color: isAverageButtonSelected ? white : doveGray,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isAverageButtonSelected = false;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isAverageButtonSelected ? white : tango,
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Total'.toUpperCase(),
                      style: TextStyle(
                        color: isAverageButtonSelected ? doveGray : white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Container statusWidget(Color color) => Container(
        width: 10.0,
        height: 10.0,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      );
}
