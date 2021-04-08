import 'package:flutter/material.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/insite_image.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';

class FleetItem extends StatelessWidget {
  final Fleet fleet;
  final VoidCallback onCallback;
  const FleetItem({this.fleet, this.onCallback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onCallback();
      },
      child: Card(
        color: cardcolor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: cardcolor)),
        child: Container(
          child: ExpansionTile(
            trailing: SizedBox(),
            // title: Table(
            //   border: TableBorder.all(),
            //   children: [
            //     TableRow(children: [
            //       Row(
            //         children: [
            //           Container(
            //             margin:
            //                 EdgeInsets.only(left: 10, right: 10, bottom: 10),
            //             decoration: BoxDecoration(
            //                 color: Colors.white,
            //                 borderRadius: BorderRadius.all(Radius.circular(4))),
            //             child: InsiteImage(
            //               height: 30,
            //               width: 50,
            //               path: "assets/images/truck.png",
            //             ),
            //           ),
            //           Text(
            //             fleet.dealerName,
            //             maxLines: 2,
            //             overflow: TextOverflow.ellipsis,
            //             style: TextStyle(
            //                 fontSize: 13.0,
            //                 fontFamily: 'Roboto',
            //                 fontWeight: FontWeight.w700,
            //                 fontStyle: FontStyle.normal,
            //                 color: textcolor),
            //           ),
            //         ],
            //       ),
            //       InsiteTableRow(
            //         title: "Last Known Status",
            //         content: "Not Reporting",
            //       )
            //     ]),
            //     TableRow(children: [
            //       RichText(
            //           text: TextSpan(children: [
            //         TextSpan(text: "Serial No. "),
            //         TextSpan(
            //           text: fleet.assetSerialNumber,
            //           style: TextStyle(
            //               decoration: TextDecoration.underline,
            //               fontSize: 13.0,
            //               fontWeight: FontWeight.bold,
            //               color: tango),
            //         )
            //       ])),
            //       InsiteTableRow(
            //         title: "Custom Asset State",
            //         content: fleet.customStateDescription,
            //       )
            //     ])
            //   ],
            // ),
            title: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_drop_down, color: Colors.white),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: Icon(Icons.crop_square, color: Colors.black)),
                  ],
                ),
                Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            child: InsiteImage(
                              height: 30,
                              width: 50,
                              path: "assets/images/truck.png",
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  fleet.dealerName,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      color: textcolor),
                                ),
                                Text(
                                  "",
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      color: textcolor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                        height: 10,
                      ),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(text: "Serial No. "),
                        TextSpan(
                          text: fleet.assetSerialNumber,
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                              color: tango),
                        )
                      ])),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Last Known Status",
                            style: TextStyle(
                                fontSize: 13.0,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                color: textcolor),
                          ),
                          Text(
                            fleet.status,
                            style: TextStyle(
                                fontSize: 13.0,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                color: textcolor),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Custom Asset State",
                            style: TextStyle(
                                fontSize: 13.0,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                color: textcolor),
                          ),
                          Text(
                            fleet.customStateDescription,
                            style: TextStyle(
                                fontSize: 13.0,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                color: textcolor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            children: [
              Table(
                border: TableBorder.all(),
                children: [
                  TableRow(
                    children: [
                      InsiteTableRow(
                        title: "Location - Last Reported",
                        content: "-",
                      ),
                      InsiteTableRow(
                        title: "Last Reported Time      ",
                        content: fleet.lastReportedUTC != null
                            ? Utils.getLastReportedDateFleet(
                                fleet.lastReportedUTC)
                            : "",
                      ),
                    ],
                  ),
                  TableRow(children: [
                    InsiteTableRow(
                      title: "Location                 ",
                      content: fleet.lastReportedLocationLatitude.toString() +
                          "/" +
                          fleet.lastReportedLocationLongitude.toString(),
                    ),
                    InsiteTableRow(
                      title: "Signal Strength          ",
                      content: "-",
                    ),
                  ]),
                  TableRow(children: [
                    InsiteTableRow(
                      title: "Fuel - Last Reported     ",
                      content: "-",
                    ),
                    InsiteTableRow(
                      title: "Fuel Level%",
                      content: fleet.fuelLevelLastReported != null
                          ? fleet.fuelLevelLastReported.toString()
                          : "-",
                    ),
                  ]),
                  TableRow(children: [
                    InsiteTableRow(
                      title: "Network Provider         ",
                      content: "-",
                    ),
                    InsiteTableRow(
                      title: "Customer Name            ",
                      content: "-",
                    ),
                  ]),
                  TableRow(children: [
                    InsiteTableRow(
                      title: "Asset Commissioning Date  ",
                      content: "-",
                    ),
                    InsiteTableRow(
                      title: "Dealer Name               ",
                      content: "-",
                    ),
                  ]),
                  TableRow(children: [
                    InsiteTableRow(
                      title: "Hr Meter",
                      content: fleet.hourMeter != null
                          ? fleet.hourMeter.toString() + " hrs"
                          : "-",
                    ),
                    InsiteTableRow(
                      title: "",
                      content: "",
                    ),
                  ])
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
