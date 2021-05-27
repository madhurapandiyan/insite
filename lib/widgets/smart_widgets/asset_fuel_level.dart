import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/core/models/fuel_level.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/asset_status_widget.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class AssetFuelLevel extends StatefulWidget {
  final List<CountDatum> fuelLevel;
  AssetFuelLevel({this.fuelLevel});

  @override
  _AssetFuelLevelState createState() => _AssetFuelLevelState();
}

class _AssetFuelLevelState extends State<AssetFuelLevel> {
  @override
  Widget build(BuildContext context) {
    int result = (widget.fuelLevel[0].count +
        widget.fuelLevel[1].count +
        widget.fuelLevel[2].count +
        widget.fuelLevel[3].count);
    print('fuelLevel:$result');

    double gauge1 = ((widget.fuelLevel[0].count / result) * 100).roundToDouble();
    print('gauge1:$gauge1');
    double gauge2 =
        (((widget.fuelLevel[0].count + widget.fuelLevel[1].count) / result) *
            100).roundToDouble();
    print('gauge2:$gauge2');
    double gauge3 = (((widget.fuelLevel[0].count +
                widget.fuelLevel[1].count +
                widget.fuelLevel[2].count) /
            result) *
        100).roundToDouble();
    print('gauge3:$gauge3');
    double gauge4 = (((widget.fuelLevel[0].count +
                widget.fuelLevel[1].count +
                widget.fuelLevel[2].count +
                widget.fuelLevel[3].count) /
            result) *
        100).roundToDouble();
    print('gauge4:$gauge4');

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 345.13,
      height: 221.16,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [new BoxShadow(blurRadius: 1.0, color: cardcolor)],
        border: Border.all(width: 2.5, color: cardcolor),
        shape: BoxShape.rectangle,
      ),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: new Row(
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
          ),
        ),
        Divider(
          thickness: 1.0,
          color: black,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
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
                              endValue:
                                  ((widget.fuelLevel[0].count / result) * 100).roundToDouble(),
                              sizeUnit: GaugeSizeUnit.factor,
                              startWidth: 0.30,
                              endWidth: 0.30,
                              color: burntSienna),
                          GaugeRange(
                              startValue:
                                  ((widget.fuelLevel[0].count / result) * 100).roundToDouble(),
                              endValue:
                               (((widget.fuelLevel[0].count +
                                          widget.fuelLevel[1].count) /
                                      result) *
                                  100).roundToDouble(),
                              startWidth: 0.30,
                              sizeUnit: GaugeSizeUnit.factor,
                              endWidth: 0.30,
                              color: lightRose),
                          GaugeRange(
                              startValue:
                              (((widget.fuelLevel[0].count +
                                          widget.fuelLevel[1].count) /
                                      result) *
                                  100).roundToDouble(),
                              endValue:
                               (((widget.fuelLevel[0].count +
                                          widget.fuelLevel[1].count +
                                          widget.fuelLevel[2].count) /
                                      result) *
                                  100).roundToDouble(),
                              startWidth: 0.30,
                              sizeUnit: GaugeSizeUnit.factor,
                              endWidth: 0.30,
                              color: mustard),
                          GaugeRange(
                              startValue: 
                              (((widget.fuelLevel[0].count +
                                          widget.fuelLevel[1].count +
                                          widget.fuelLevel[2].count) /
                                      result) *
                                  100).roundToDouble(),
                              endValue: 
                              (((widget.fuelLevel[0].count +
                                          widget.fuelLevel[1].count +
                                          widget.fuelLevel[2].count +
                                          widget.fuelLevel[3].count) /
                                      result) *
                                  100).roundToDouble(),
                              startWidth: 0.30,
                              sizeUnit: GaugeSizeUnit.factor,
                              endWidth: 0.30,
                              color: emerald),
                        ]),
                  ],
                )),
            SizedBox(
              width: 30,
            ),
            Column(
              children: [
                AssetStatusWidget(
                    burntSienna,
                    "<" + widget.fuelLevel[0].countOf + "%",
                    silver,
                    "assets/images/arrows.png"),
                Container(
                    width: 127.29,
                    child: Divider(thickness: 1.0, color: athenGrey)),
                AssetStatusWidget(
                    lightRose,
                    "<" + widget.fuelLevel[1].countOf + "%",
                    silver,
                    "assets/images/arrows.png"),
                Container(
                    width: 127.29,
                    child: Divider(thickness: 1.0, color: athenGrey)),
                AssetStatusWidget(
                    mustard,
                    "<" + widget.fuelLevel[2].countOf + "%",
                    silver,
                    "assets/images/arrows.png"),
                Container(
                    width: 127.29,
                    child: Divider(thickness: 1.0, color: athenGrey)),
                AssetStatusWidget(
                    emerald,
                    "<=" + widget.fuelLevel[3].countOf + "%",
                    silver,
                    "assets/images/arrows.png")
              ],
            )
          ],
        ),
      ]),
    );
  }
}
