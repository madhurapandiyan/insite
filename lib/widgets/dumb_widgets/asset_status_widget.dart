import 'package:flutter/material.dart';
import 'package:insite/core/models/assetstatus_model.dart';
import 'package:insite/theme/colors.dart';

class AssetStatusWidget extends StatefulWidget {
  final ChartSampleData chartData;
  final Color chartColor;
  final Function(ChartSampleData) callBack;
  AssetStatusWidget({this.chartData, this.chartColor, this.callBack});
  @override
  _AssetStatusWidgetState createState() => _AssetStatusWidgetState();
}

class _AssetStatusWidgetState extends State<AssetStatusWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.callBack(widget.chartData);
      },
      child: Container(
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
      ),
    );
  }
}
