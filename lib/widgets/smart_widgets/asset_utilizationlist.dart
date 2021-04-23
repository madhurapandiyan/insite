import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/core/models/utilization_data.dart';
import 'package:insite/theme/colors.dart';

class AssetOperation extends StatelessWidget {
  UtilizationData data;
  AssetOperation({this.data});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 387,
        height: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(10.0),
              topRight: const Radius.circular(10.0),
              bottomLeft: const Radius.circular(10.0),
              bottomRight: const Radius.circular(10.0)),
          boxShadow: [
            new BoxShadow(
              blurRadius: 1.0,
              color: cardcolor,
            ),
          ],
          border: Border.all(color: cardcolor),
          shape: BoxShape.rectangle,
        ),
        child: Column(
          children: [
            IntrinsicHeight(
              child: new Row(
                children: [
                  SvgPicture.asset("assets/images/arrowdown.svg"),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    data.date,
                    style: new TextStyle(
                        fontSize: 12.0,
                        color: textcolor,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Roboto',
                        decoration: TextDecoration.none),
                  ),
                  VerticalDivider(
                    thickness: 2.0,
                    color: black,
                  ),
                  Stack(
                    children: [
                      new Column(
                        children: [
                          SizedBox(
                            height: 8.0,
                          ),
                          new Text(
                            "LastReportedTime",
                            style: new TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w700,
                                color: textcolor),
                          ),
                          Row(
                            children: [
                              new Text(
                                data.lastReportedTime,
                                style: new TextStyle(
                                    fontSize: 12.0,
                                    color: textcolor,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto',
                                    decoration: TextDecoration.none),
                              ),
                              // new Text(data.date,
                              //     style: new TextStyle(
                              //         fontSize: 12.0,
                              //         color: textcolor,
                              //         fontStyle: FontStyle.normal,
                              //         fontWeight: FontWeight.w400,
                              //         fontFamily: 'Roboto',
                              //         decoration: TextDecoration.none))
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  VerticalDivider(
                    thickness: 2.0,
                    color: black,
                  ),
                  Flexible(
                    child: Stack(
                      children: [
                        new Column(
                          children: [
                            Expanded(
                              flex: 2,
                              child: new Text(
                                "Runtimeperformance",
                                style: new TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 12.0,
                                    fontFamily: 'Roboto',
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                    color: textcolor),
                              ),
                            ),
                            new Text(
                              data.targetRuntimePerformance.toString(),
                              style: new TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400,
                                  color: textcolor,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'Roboto',
                                  decoration: TextDecoration.none),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
