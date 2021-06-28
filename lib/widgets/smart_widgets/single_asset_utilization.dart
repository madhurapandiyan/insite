import 'package:flutter/material.dart';
import 'package:insite/core/models/asset_utilization.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/utilization_legends.dart';

class SingleAssetUtilizationWidget extends StatefulWidget {
  final double idleHighestValue;
  final double runtimeHighestValue;
  final double workingHighestValue;
  final AssetUtilization assetUtilization;
  @override
  _SingleAssetUtilizationWidgetState createState() =>
      _SingleAssetUtilizationWidgetState();

  const SingleAssetUtilizationWidget({
    Key key,
    @required this.assetUtilization,
    @required this.idleHighestValue,
    @required this.runtimeHighestValue,
    @required this.workingHighestValue,
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
                        checkNull(
                            widget.assetUtilization.totalDay.workingHours),
                        checkNull(widget.assetUtilization.totalDay.idleHours),
                        checkNull(
                            widget.assetUtilization.totalDay.runtimeHours),
                      ),
                      barChart(
                        'Current Week',
                        checkNull(
                            widget.assetUtilization.totalWeek.workingHours),
                        checkNull(widget.assetUtilization.totalWeek.idleHours),
                        checkNull(
                            widget.assetUtilization.totalWeek.runtimeHours),
                      ),
                      barChart(
                        'Current Month',
                        checkNull(
                            widget.assetUtilization.totalMonth.workingHours),
                        checkNull(widget.assetUtilization.totalMonth.idleHours),
                        checkNull(
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
                      barWidget(workingValue, emerald,
                          SingleAssetUtilizationType.WORKINGHOURS),
                      barWidget(idleValue, burntSienna,
                          SingleAssetUtilizationType.IDLEHOURS),
                      barWidget(runningValue, creamCan,
                          SingleAssetUtilizationType.RUNTIMEHOURS),
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

  Column barWidget(
      double value, Color color, SingleAssetUtilizationType barType) {
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
          height: getHighestValue(totalBarHeight, value, barType),
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

  double getHighestValue(
      double totalBarHeight, double value, SingleAssetUtilizationType barType) {
    if (value == 0) return 0.0;
    switch (barType) {
      case SingleAssetUtilizationType.IDLEHOURS:
        if (((value / widget.idleHighestValue) * 100) <= 0) return 0.0;
        return ((totalBarHeight / 100) +
            (((value / widget.idleHighestValue) * 100)));
        break;
      case SingleAssetUtilizationType.WORKINGHOURS:
        if (((value / widget.workingHighestValue) * 100) <= 0) return 0.0;
        return ((totalBarHeight / 100) +
            (((value / widget.workingHighestValue) * 100)));
        break;
      case SingleAssetUtilizationType.RUNTIMEHOURS:
        if (((value / widget.runtimeHighestValue) * 100) <= 0) return 0.0;
        return ((totalBarHeight / 100) +
            (((value / widget.runtimeHighestValue) * 100)));
        break;
    }
    return 0.0;
  }

  double checkNull(double value) {
    return value == null ? 0.0 : value;
  }
}

enum SingleAssetUtilizationType { IDLEHOURS, RUNTIMEHOURS, WORKINGHOURS }
