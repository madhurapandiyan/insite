import 'package:flutter/material.dart';
import 'package:insite/core/models/utilization_summary.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/utilization_legends.dart';

class AssetUtilizationWidget extends StatefulWidget {
  final UtilizationSummary assetUtilization;
  final double totalGreatestNumber;
  final double averageGreatestNumber;
  final bool isLoading;
  @override
  _AssetUtilizationWidgetState createState() => _AssetUtilizationWidgetState();

  const AssetUtilizationWidget({
    Key key,
    @required this.assetUtilization,
    @required this.totalGreatestNumber,
    @required this.averageGreatestNumber,
    @required this.isLoading,
  }) : super(key: key);
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
                widget.isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: [
                          Row(
                            children: [
                              Container(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                            color: isAverageButtonSelected
                                                ? tango
                                                : white,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(4),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Average'.toUpperCase(),
                                              style: TextStyle(
                                                color: isAverageButtonSelected
                                                    ? white
                                                    : doveGray,
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
                                            color: isAverageButtonSelected
                                                ? white
                                                : tango,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(4),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Total'.toUpperCase(),
                                              style: TextStyle(
                                                color: isAverageButtonSelected
                                                    ? doveGray
                                                    : white,
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
                              ),
                              Expanded(
                                child: UtilizationLegends(
                                  label1: 'Working',
                                  label2: 'Idle',
                                  label3: 'Running',
                                  color1: emerald,
                                  color2: burntSienna,
                                  color3: creamCan,
                                ),
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
                                        Utils.checkNull(widget.assetUtilization
                                            .averageDay.workingHours),
                                        Utils.checkNull(widget.assetUtilization
                                            .averageDay.idleHours),
                                        Utils.checkNull(widget.assetUtilization
                                            .averageDay.runtimeHours),
                                      )
                                    : barChart(
                                        'Today',
                                        Utils.checkNull(widget.assetUtilization
                                            .totalDay.workingHours),
                                        Utils.checkNull(widget.assetUtilization
                                            .totalDay.idleHours),
                                        Utils.checkNull(widget.assetUtilization
                                            .totalDay.runtimeHours),
                                      ),
                                isAverageButtonSelected
                                    ? barChart(
                                        'Current Week',
                                        Utils.checkNull(widget.assetUtilization
                                            .averageWeek.workingHours),
                                        Utils.checkNull(widget.assetUtilization
                                            .averageWeek.idleHours),
                                        Utils.checkNull(widget.assetUtilization
                                            .averageWeek.runtimeHours),
                                      )
                                    : barChart(
                                        'Current Week',
                                        Utils.checkNull(widget.assetUtilization
                                            .totalWeek.workingHours),
                                        Utils.checkNull(widget.assetUtilization
                                            .totalWeek.idleHours),
                                        Utils.checkNull(widget.assetUtilization
                                            .totalWeek.runtimeHours),
                                      ),
                                isAverageButtonSelected
                                    ? barChart(
                                        'Current Month',
                                        Utils.checkNull(widget.assetUtilization
                                            .averageMonth.workingHours),
                                        Utils.checkNull(widget.assetUtilization
                                            .averageMonth.idleHours),
                                        Utils.checkNull(widget.assetUtilization
                                            .averageMonth.runtimeHours),
                                      )
                                    : barChart(
                                        'Current Month',
                                        Utils.checkNull(widget.assetUtilization
                                            .totalMonth.workingHours),
                                        Utils.checkNull(widget.assetUtilization
                                            .totalMonth.idleHours),
                                        Utils.checkNull(widget.assetUtilization
                                            .totalMonth.runtimeHours),
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
    return ((value / 18) * 10);
  }

  Column barWidget(double value, Color color) {
    double totalBarHeight = MediaQuery.of(context).size.height * 0.12;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          value < 1000
              ? '${value.toStringAsFixed(1)}'
              : '${(value / 1000).toStringAsFixed(1)}K',
          style: TextStyle(
              color: white, fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: 15,
          height: (value == 0 ||
                  widget.totalGreatestNumber == 0 ||
                  widget.averageGreatestNumber == 0)
              ? 0.0
              // : ((value / widget.assetUtilization.totalMonth.runtimeHours) *
              //             100) <=
              //         0
              //     ? 0.0
              // : ((totalBarHeight / 100) +
              //     ((value /
              //             widget.assetUtilization.totalMonth.runtimeHours) *
              //         100)),
              : isAverageButtonSelected
                  ? ((((value / widget.averageGreatestNumber) * 100) /
                          totalBarHeight) *
                      100)
                  : ((((value / widget.totalGreatestNumber) * 100) /
                          totalBarHeight) *
                      100),
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
}
