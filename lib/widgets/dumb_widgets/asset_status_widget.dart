import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';

class AssetStatusWidget extends StatelessWidget {
  final Color firstColor;
  final String text;
  final Color lastColor;
  final String imgPath;
  AssetStatusWidget(this.firstColor, this.text, this.lastColor, this.imgPath);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              width: 13.96,
              height: 15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  new BoxShadow(blurRadius: 1.0, color: firstColor)
                ],
                border: Border.all(width: 2.5, color: firstColor),
                shape: BoxShape.rectangle,
              )),
          new Text(
            text,
            style: new TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: 'Roboto',
                color: textcolor,
                fontStyle: FontStyle.normal,
                fontSize: 11.0),
          ),
          new Container(
            width: 13.96,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [new BoxShadow(blurRadius: 1.0, color: lastColor)],
              border: Border.all(width: 2.5, color: lastColor),
              shape: BoxShape.rectangle,
            ),
            child: Image.asset(imgPath),
          )
        ],
      ),
    );
  }
}

