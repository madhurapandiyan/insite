import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';

Widget assetStatusOff(String title, String imgpath) {
  return Container(
    width: 130,
    child: new Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Container(
              width: 13.96,
              height: 15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [new BoxShadow(blurRadius: 1.0, color: emerald)],
                border: Border.all(width: 2.5, color: emerald),
                shape: BoxShape.rectangle,
              )),
        ),
        new Text(
          title,
          style: new TextStyle(
              fontWeight: FontWeight.w700,
              fontFamily: 'Roboto',
              color: textcolor,
              fontStyle: FontStyle.normal,
              fontSize: 11.0),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: new Container(
            width: 13.96,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [new BoxShadow(blurRadius: 1.0, color: silver)],
              border: Border.all(width: 2.5, color: silver),
              shape: BoxShape.rectangle,
            ),
            child: Image.asset(imgpath),
          ),
        )
      ],
    ),
  );
}

Widget assetStatusOn(String title, String imgpath) {
  return Container(
    width: 130,
    child: new Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Container(
              width: 13.96,
              height: 15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [new BoxShadow(blurRadius: 1.0, color: burntSienna)],
                border: Border.all(width: 2.5, color: burntSienna),
                shape: BoxShape.rectangle,
              )),
        ),
        new Text(
          title,
          style: new TextStyle(
              fontWeight: FontWeight.w700,
              fontFamily: 'Roboto',
              color: textcolor,
              fontStyle: FontStyle.normal,
              fontSize: 11.0),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 34.0),
          child: new Container(
            width: 13.96,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [new BoxShadow(blurRadius: 1.0, color: silver)],
              border: Border.all(width: 2.5, color: silver),
              shape: BoxShape.rectangle,
            ),
            child: Image.asset(imgpath),
          ),
        )
      ],
    ),
  );
}

Widget assetStatusFirstReport(String title, String imgpath) {
  return Container(
    width: 130,
    child: new Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: Container(
              width: 13.96,
              height: 15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [new BoxShadow(blurRadius: 1.0, color: mustard)],
                border: Border.all(width: 2.5, color: mustard),
                shape: BoxShape.rectangle,
              )),
        ),
        new Text(
          title,
          style: new TextStyle(
              fontWeight: FontWeight.w700,
              fontFamily: 'Roboto',
              color: textcolor,
              fontStyle: FontStyle.normal,
              fontSize: 11.0),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 5.0),
          child: new Container(
            width: 13.96,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [new BoxShadow(blurRadius: 1.0, color: silver)],
              border: Border.all(width: 2.5, color: silver),
              shape: BoxShape.rectangle,
            ),
            child: Image.asset(imgpath),
          ),
        )
      ],
    ),
  );
}

Widget assetStatusNotReport(String title, String imgpath) {
  return Container(
    width: 130,
    child: new Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 3.0),
          child: Container(
              width: 13.96,
              height: 15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  new BoxShadow(blurRadius: 1.0, color: tabpagecolor)
                ],
                border: Border.all(width: 2.5, color: tabpagecolor),
                shape: BoxShape.rectangle,
              )),
        ),
        new Text(
          title,
          style: new TextStyle(
              fontWeight: FontWeight.w700,
              fontFamily: 'Roboto',
              color: textcolor,
              fontStyle: FontStyle.normal,
              fontSize: 11.0),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: new Container(
            width: 13.96,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [new BoxShadow(blurRadius: 1.0, color: silver)],
              border: Border.all(width: 2.5, color: silver),
              shape: BoxShape.rectangle,
            ),
            child: Image.asset(imgpath),
          ),
        )
      ],
    ),
  );
}
