import 'package:flutter/material.dart';
import 'package:insite/core/models/asset_fuel_level.dart';
import 'package:insite/theme/colors.dart';

class AssetFuelLevelWidget extends StatefulWidget {
  final FuelSampleData chartData;
  final Color chartColor;

  AssetFuelLevelWidget({this.chartData, this.chartColor});
  @override
  _AssetStatusFuelLevelWidgetState createState() => _AssetStatusFuelLevelWidgetState();
}

class _AssetStatusFuelLevelWidgetState extends State<AssetFuelLevelWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  new BoxShadow(blurRadius: 1.0, color: widget.chartColor)
                ],
                border: Border.all(width: 2.5, color: widget.chartColor),
                shape: BoxShape.rectangle,
              )),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: new Text(
              widget.chartData.x.toUpperCase(),
              textAlign: TextAlign.start,
              style: new TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Roboto',
                  color: textcolor,
                  fontStyle: FontStyle.normal,
                  fontSize: 11.0),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          new Container(
            width: 15,
            height: 20,
            child: Image.asset("assets/images/arrows.png"),
          )
        ],
      ),
    );
  }
}
