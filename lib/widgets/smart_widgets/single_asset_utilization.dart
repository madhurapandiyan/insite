import 'package:flutter/material.dart';
import 'package:insite/core/models/asset_utilization.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/utilization_legends.dart';

class SingleAssetUtilizationWidget extends StatefulWidget {
  final AssetUtilization assetUtilization;
  @override
  _SingleAssetUtilizationWidgetState createState() =>
      _SingleAssetUtilizationWidgetState();

  const SingleAssetUtilizationWidget({
    Key key,
    @required this.assetUtilization,
  }) : super(key: key);
}

class _SingleAssetUtilizationWidgetState
    extends State<SingleAssetUtilizationWidget> {
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      barChart(
                        'Today',
                        Utils.checkNull(
                            widget.assetUtilization.totalDay.workingHours),
                        Utils.checkNull(
                            widget.assetUtilization.totalDay.idleHours),
                        Utils.checkNull(
                            widget.assetUtilization.totalDay.runtimeHours),
                      ),
                      barChart(
                        'Current Week',
                        Utils.checkNull(
                            widget.assetUtilization.totalWeek.workingHours),
                        Utils.checkNull(
                            widget.assetUtilization.totalWeek.idleHours),
                        Utils.checkNull(
                            widget.assetUtilization.totalWeek.runtimeHours),
                      ),
                      barChart(
                        'Current Month',
                        Utils.checkNull(
                            widget.assetUtilization.totalMonth.workingHours),
                        Utils.checkNull(
                            widget.assetUtilization.totalMonth.idleHours),
                        Utils.checkNull(
                            widget.assetUtilization.totalMonth.runtimeHours),
                      ),
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
    return ((value / 18) * 10);
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
          height: ((value / widget.assetUtilization.totalMonth.runtimeHours) *
                      100) <=
                  0
              ? 0.0
              : ((totalBarHeight / 100) +
                  ((value / widget.assetUtilization.totalMonth.runtimeHours) *
                      100)),
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
