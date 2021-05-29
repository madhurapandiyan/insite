import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/core/models/fuel_level.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/asset_status_widget.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class AssetFuelLevel extends StatefulWidget {
  final List<CountDatum> fuelLevel;
  final bool isLoading;
  AssetFuelLevel({this.fuelLevel, this.isLoading});

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
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                              width: 150,
                              height: 150,
                              child: SfRadialGauge(
                                axes: <RadialAxis>[
                                  RadialAxis(
                                      showAxisLine: false,
                                      showLabels: false,
                                      showTicks: false,
                                      startAngle: 180,
                                      endAngle: 360,
                                      minimum: 0,
                                      maximum: 100,
                                      canScaleToFit: true,
                                      radiusFactor: 0.95,
                                      pointers: <GaugePointer>[
                                        NeedlePointer(
                                            needleStartWidth: 1,
                                            value: 30,
                                            needleLength: 0.7,
                                            lengthUnit: GaugeSizeUnit.factor,
                                            knobStyle: KnobStyle(
                                              knobRadius: 0.08,
                                              sizeUnit: GaugeSizeUnit.factor,
                                            ))
                                      ],
                                      ranges: <GaugeRange>[
                                        GaugeRange(
                                            startValue: 0,
                                            endValue: gaugeValue(0),
                                            sizeUnit: GaugeSizeUnit.factor,
                                            startWidth: 0.30,
                                            endWidth: 0.30,
                                            color: burntSienna),
                                        GaugeRange(
                                            startValue: gaugeValue(0),
                                            endValue: gaugeValue(1),
                                            startWidth: 0.30,
                                            sizeUnit: GaugeSizeUnit.factor,
                                            endWidth: 0.30,
                                            color: lightRose),
                                        GaugeRange(
                                            startValue: gaugeValue(1),
                                            endValue: gaugeValue(2),
                                            startWidth: 0.30,
                                            sizeUnit: GaugeSizeUnit.factor,
                                            endWidth: 0.30,
                                            color: mustard),
                                        GaugeRange(
                                            startValue: gaugeValue(2),
                                            endValue: gaugeValue(3),
                                            startWidth: 0.30,
                                            sizeUnit: GaugeSizeUnit.factor,
                                            endWidth: 0.30,
                                            color: emerald),
                                      ]),
                                ],
                              )),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              AssetStatusWidget(
                                  burntSienna,
                                  "<" + widget.fuelLevel[0].countOf + "%",
                                  silver,
                                  "assets/images/arrows.png"),
                              Container(
                                  width: 127.29,
                                  child: Divider(
                                      thickness: 1.0, color: athenGrey)),
                              AssetStatusWidget(
                                  lightRose,
                                  "<" + widget.fuelLevel[1].countOf + "%",
                                  silver,
                                  "assets/images/arrows.png"),
                              Container(
                                  width: 127.29,
                                  child: Divider(
                                      thickness: 1.0, color: athenGrey)),
                              AssetStatusWidget(
                                  mustard,
                                  "<" + widget.fuelLevel[2].countOf + "%",
                                  silver,
                                  "assets/images/arrows.png"),
                              Container(
                                  width: 127.29,
                                  child: Divider(
                                      thickness: 1.0, color: athenGrey)),
                              AssetStatusWidget(
                                  emerald,
                                  "<=" + widget.fuelLevel[3].countOf + "%",
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

  double gaugeValue(index) {
    double value = 0;
    int result;
    result = (widget.fuelLevel[0].count +
        widget.fuelLevel[1].count +
        widget.fuelLevel[2].count +
        widget.fuelLevel[3].count);
    print('gauge total :$result');
    if (index == 0) {
      value = ((widget.fuelLevel[0].count / result) * 100).roundToDouble();
    } else if (index == 1) {
      value =
          (((widget.fuelLevel[0].count + widget.fuelLevel[1].count) / result) *
                  100)
              .roundToDouble();
    } else if (index == 2) {
      value = (((widget.fuelLevel[0].count +
                      widget.fuelLevel[1].count +
                      widget.fuelLevel[2].count) /
                  result) *
              100)
          .roundToDouble();
    } else if (index == 3) {
      value = (((widget.fuelLevel[0].count +
                      widget.fuelLevel[1].count +
                      widget.fuelLevel[2].count +
                      widget.fuelLevel[3].count) /
                  result) *
              100)
          .roundToDouble();
    }
    print('gauge  $index return :$value');
    return value;
  }
}
