import 'package:flutter/material.dart';
import 'package:insite/core/models/asset_utilization.dart';
import 'package:insite/theme/colors.dart';

class AssetUtilizationWidget extends StatefulWidget {
  @override
  _AssetUtilizationWidgetState createState() => _AssetUtilizationWidgetState();

  const AssetUtilizationWidget({
    Key key,
    @required this.assetUtilization,
  }) : super(key: key);

  final AssetUtilization assetUtilization;
}

class _AssetUtilizationWidgetState extends State<AssetUtilizationWidget> {
  bool isAverageButtonSelected = true;

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
                      style: TextStyle(color: white, fontSize: 12),
                    ),
                    statusWidget(burntSienna),
                    Text(
                      'Idle'.toUpperCase(),
                      style: TextStyle(color: white, fontSize: 12),
                    ),
                    statusWidget(creamCan),
                    Text(
                      'Running'.toUpperCase(),
                      style: TextStyle(color: white, fontSize: 12),
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
                              widget.assetUtilization.averageDay.workingHours /
                                  1000,
                              widget.assetUtilization.averageDay.idleHours /
                                  1000,
                              widget.assetUtilization.averageDay.runtimeHours /
                                  1000)
                          : barChart(
                              'Today',
                              widget.assetUtilization.totalDay.workingHours /
                                  1000,
                              widget.assetUtilization.totalDay.idleHours / 1000,
                              widget.assetUtilization.totalDay.runtimeHours /
                                  1000),
                      isAverageButtonSelected
                          ? barChart(
                              'Current Week',
                              widget.assetUtilization.averageWeek.workingHours /
                                  1000,
                              widget.assetUtilization.averageWeek.idleHours /
                                  1000,
                              widget.assetUtilization.averageWeek.runtimeHours /
                                  1000)
                          : barChart(
                              'Current Week',
                              widget.assetUtilization.totalWeek.workingHours /
                                  1000,
                              widget.assetUtilization.totalWeek.idleHours /
                                  1000,
                              widget.assetUtilization.totalWeek.runtimeHours /
                                  1000),
                      isAverageButtonSelected
                          ? barChart(
                              'Current Month',
                              widget.assetUtilization.averageMonth.workingHours /
                                  1000,
                              widget.assetUtilization.averageMonth.idleHours /
                                  1000,
                              widget.assetUtilization.averageMonth
                                      .runtimeHours /
                                  1000)
                          : barChart(
                              'Current Month',
                              widget.assetUtilization.totalMonth.workingHours /
                                  1000,
                              widget.assetUtilization.totalMonth.idleHours /
                                  1000,
                              widget.assetUtilization.totalMonth.runtimeHours /
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
