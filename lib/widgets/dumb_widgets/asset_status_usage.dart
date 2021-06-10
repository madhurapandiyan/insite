import 'package:flutter/material.dart';
import 'package:insite/core/models/assetstatus_model.dart';
import 'package:insite/theme/colors.dart';

class AssetStatusUsageWidget extends StatefulWidget {
  final ChartSampleData assetStatusData;
  final Color chartColor;
  final String chartHrsData;

  AssetStatusUsageWidget({this.assetStatusData, this.chartColor,this.chartHrsData});
  @override
  _AssetStatusWidgetState createState() => _AssetStatusWidgetState();
}

class _AssetStatusWidgetState extends State<AssetStatusUsageWidget> {
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
              widget.chartHrsData.toUpperCase(),
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
