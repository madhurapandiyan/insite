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
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        color: tuna,
        border: Border.all(color: black, width: 0.0),
        borderRadius: BorderRadius.all(Radius.circular(10)),
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
                              widget.assetUtilization.targetDay.workingHours ==
                                      null
                                  ? 0.0
                                  : widget
                                      .assetUtilization.targetDay.workingHours,
                              widget.assetUtilization.targetDay.idleHours ==
                                      null
                                  ? 0.0
                                  : widget.assetUtilization.targetDay.idleHours,
                              widget.assetUtilization.targetDay.runtimeHours ==
                                      null
                                  ? 0.0
                                  : widget
                                      .assetUtilization.targetDay.runtimeHours)
                          : barChart(
                              'Today',
                              widget.assetUtilization.totalDay.workingHours ==
                                      null
                                  ? 0.0
                                  : widget
                                      .assetUtilization.totalDay.workingHours,
                              widget.assetUtilization.totalDay.idleHours == null
                                  ? 0.0
                                  : widget.assetUtilization.totalDay.idleHours,
                              widget.assetUtilization.totalDay.runtimeHours ==
                                      null
                                  ? 0.0
                                  : widget
                                      .assetUtilization.totalDay.runtimeHours),
                      isAverageButtonSelected
                          ? barChart(
                              'Current Week',
                              widget.assetUtilization.targetWeek.workingHours ==
                                      null
                                  ? 0.0
                                  : widget
                                      .assetUtilization.targetWeek.workingHours,
                              widget.assetUtilization.targetWeek.idleHours ==
                                      null
                                  ? 0.0
                                  : widget
                                      .assetUtilization.targetWeek.idleHours,
                              widget.assetUtilization.targetWeek == null
                                  ? 0.0
                                  : widget
                                      .assetUtilization.targetWeek.runtimeHours)
                          : barChart(
                              'Current Week',
                              widget.assetUtilization.totalWeek.workingHours ==
                                      null
                                  ? 0.0
                                  : widget
                                      .assetUtilization.totalWeek.workingHours,
                              widget.assetUtilization.totalWeek.idleHours ==
                                      null
                                  ? 0.0
                                  : widget.assetUtilization.totalWeek.idleHours,
                              widget.assetUtilization.totalWeek.runtimeHours ==
                                      null
                                  ? 0.0
                                  : widget
                                      .assetUtilization.totalWeek.runtimeHours),
                      isAverageButtonSelected
                          ? barChart(
                              'Current Month',
                              widget.assetUtilization.targetMonth
                                          .workingHours ==
                                      null
                                  ? 0.0
                                  : widget.assetUtilization.targetMonth
                                      .workingHours,
                              widget.assetUtilization.targetMonth.idleHours ==
                                      null
                                  ? 0.0
                                  : widget
                                      .assetUtilization.targetMonth.idleHours,
                              widget.assetUtilization.targetMonth
                                          .runtimeHours ==
                                      null
                                  ? 0.0
                                  : widget.assetUtilization.targetMonth
                                      .runtimeHours)
                          : barChart(
                              'Current Month',
                              widget.assetUtilization.totalMonth.workingHours ==
                                      null
                                  ? 0.0
                                  : widget
                                      .assetUtilization.totalMonth.workingHours,
                              widget.assetUtilization.totalMonth.idleHours ==
                                      null
                                  ? 0.0
                                  : widget
                                      .assetUtilization.totalMonth.idleHours,
                              widget.assetUtilization.totalMonth.runtimeHours ==
                                      null
                                  ? 0.0
                                  : widget.assetUtilization.totalMonth
                                      .runtimeHours),
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
