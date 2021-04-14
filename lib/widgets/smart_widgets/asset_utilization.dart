import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:insite/core/models/asset_utilization.dart';
import 'package:insite/theme/colors.dart';

class AssetUtilizationWidget extends StatefulWidget {
  @override
  _AssetUtilizationWidgetState createState() => _AssetUtilizationWidgetState();

  const AssetUtilizationWidget({
    Key key,
  }) : super(key: key);
}

class _AssetUtilizationWidgetState extends State<AssetUtilizationWidget> {
  bool isAverageButtonSelected = true;

  // Hardcoded Response. Please change afterwards
  var assetUtilizationHours = AssetUtilization.fromJson(jsonDecode(
      '{"totalDay":{"idleHours":27.292,"runtimeHours":674.473234,"workingHours":24.033},"totalWeek":{"idleHours":139.712,"runtimeHours":3697.337071,"workingHours":201.631},"totalMonth":{"idleHours":659.954,"runtimeHours":18108.287383,"workingHours":1016.107},"averageDay":{"idleHours":0.162452381,"runtimeHours":4.014721631,"workingHours":0.1430535714},"averageWeek":{"idleHours":0.2531014493,"runtimeHours":6.698074404,"workingHours":0.3652735507},"averageMonth":{"idleHours":0.2710283368,"runtimeHours":7.4366683298,"workingHours":0.4172924025}}'));
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.35,
      decoration: BoxDecoration(
        color: tuna,
        border: Border.all(color: black, width: 0.0),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Asset Utilization'.toUpperCase(),
                      style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Icon(
                      Icons.more_vert,
                      color: white,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Divider(
                    color: shark,
                    thickness: 2,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    toggleButton(),
                    statusWidget(emerald),
                    Text(
                      'Working'.toUpperCase(),
                      style: TextStyle(color: white, fontSize: 15),
                    ),
                    statusWidget(burntSienna),
                    Text(
                      'Idle'.toUpperCase(),
                      style: TextStyle(color: white, fontSize: 15),
                    ),
                    statusWidget(creamCan),
                    Text(
                      'Running'.toUpperCase(),
                      style: TextStyle(color: white, fontSize: 15),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      isAverageButtonSelected
                          ? barChart(
                              'Today',
                              assetUtilizationHours.averageDay.workingHours /
                                  1000,
                              assetUtilizationHours.averageDay.idleHours / 1000,
                              assetUtilizationHours.averageDay.runtimeHours /
                                  1000)
                          : barChart(
                              'Today',
                              assetUtilizationHours.totalDay.workingHours /
                                  1000,
                              assetUtilizationHours.totalDay.idleHours / 1000,
                              assetUtilizationHours.totalDay.runtimeHours /
                                  1000),
                      isAverageButtonSelected
                          ? barChart(
                              'Current Week',
                              assetUtilizationHours.averageWeek.workingHours /
                                  1000,
                              assetUtilizationHours.averageWeek.idleHours /
                                  1000,
                              assetUtilizationHours.averageWeek.runtimeHours /
                                  1000)
                          : barChart(
                              'Current Week',
                              assetUtilizationHours.totalWeek.workingHours /
                                  1000,
                              assetUtilizationHours.totalWeek.idleHours / 1000,
                              assetUtilizationHours.totalWeek.runtimeHours /
                                  1000),
                      isAverageButtonSelected
                          ? barChart(
                              'Current Month',
                              assetUtilizationHours.averageMonth.workingHours /
                                  1000,
                              assetUtilizationHours.averageMonth.idleHours /
                                  1000,
                              assetUtilizationHours.averageMonth.runtimeHours /
                                  1000)
                          : barChart(
                              'Current Month',
                              assetUtilizationHours.totalMonth.workingHours /
                                  1000,
                              assetUtilizationHours.totalMonth.idleHours / 1000,
                              assetUtilizationHours.totalMonth.runtimeHours /
                                  1000),
                    ],
                  ),
                ),
              ],
            ),
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
                        fontSize: 12,
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
    print('In 100%: ${MediaQuery.of(context).size.height * 0.12}');
    print('In Value: ${calculatePercentage(value)}');

    double totalBarHeight = MediaQuery.of(context).size.height * 0.12;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          '${value.toStringAsFixed(1)} K',
          style: TextStyle(
              color: white, fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: 15,
          height: (totalBarHeight / 100) * calculatePercentage(value),
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
                        fontSize: 15,
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
                        fontSize: 15,
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
