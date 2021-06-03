import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/core/models/asset_fuel_level.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/asset_status_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AssetFuelLevel extends StatefulWidget {
  final List<FuelSampleData> fuelData;
  final bool isLoading;
  AssetFuelLevel({this.fuelData, this.isLoading});

  @override
  _AssetFuelLevelState createState() => _AssetFuelLevelState();
}

class _AssetFuelLevelState extends State<AssetFuelLevel> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [new BoxShadow(blurRadius: 1.0, color: cardcolor)],
        border: Border.all(width: 2.5, color: cardcolor),
        shape: BoxShape.rectangle,
      ),
      child: Stack(
        children: [
          Column(children: [
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
                        "FUEL LEVEL",
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
                ? Expanded(child: Center(child: CircularProgressIndicator()))
                : Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                              width: 150,
                              height: 150,
                              child: SfCircularChart(
                                legend: Legend(isVisible: false),
                                centerY: '70%',
                                series: _getSemiDoughnutSeries(),
                                tooltipBehavior: TooltipBehavior(enable: true),
                              )),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              AssetStatusWidget(
                                  burntSienna,
                                  "<" + widget.fuelData[0].x + "%",
                                  silver,
                                  "assets/images/arrows.png"),
                              Container(
                                  width: 127.29,
                                  child: Divider(
                                      thickness: 1.0, color: athenGrey)),
                              AssetStatusWidget(
                                  lightRose,
                                  "<" + widget.fuelData[1].x + "%",
                                  silver,
                                  "assets/images/arrows.png"),
                              Container(
                                  width: 127.29,
                                  child: Divider(
                                      thickness: 1.0, color: athenGrey)),
                              AssetStatusWidget(
                                  mustard,
                                  "<" + widget.fuelData[2].x + "%",
                                  silver,
                                  "assets/images/arrows.png"),
                              Container(
                                  width: 127.29,
                                  child: Divider(
                                      thickness: 1.0, color: athenGrey)),
                              AssetStatusWidget(
                                  emerald,
                                  "<=" + widget.fuelData[3].x + "%",
                                  silver,
                                  "assets/images/arrows.png")
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
          ]),
        ],
      ),
    );
  }

  _getSemiDoughnutSeries() {
    return <DoughnutSeries<FuelSampleData, String>>[
      DoughnutSeries<FuelSampleData, String>(
          dataSource: widget.fuelData,
          radius: '85%',
          startAngle: 270,
          endAngle: 90,
          xValueMapper: (FuelSampleData data, _) => data.x,
          yValueMapper: (FuelSampleData data, _) => data.y,
          dataLabelSettings: DataLabelSettings(
              connectorLineSettings:
                  ConnectorLineSettings(width: 1.5, length: "10%"),
              color: cardcolor,
              textStyle: new TextStyle(
                  color: textcolor,
                  fontSize: 10.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.normal),
              isVisible: true,
              labelPosition: ChartDataLabelPosition.outside,
              labelIntersectAction: LabelIntersectAction.none))
    ];
  }
}
