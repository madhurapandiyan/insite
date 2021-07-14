import 'package:flutter/material.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';

class FleetListItem extends StatelessWidget {
  final Fleet fleet;
  final VoidCallback onCallback;
  const FleetListItem({this.fleet, this.onCallback});

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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Icon(Icons.arrow_drop_down, color: Colors.white),
                  SizedBox(
                    height: 20,
                  ),
                  // Container(
                  //     decoration: BoxDecoration(
                  //         color: Colors.black,
                  //         borderRadius: BorderRadius.all(Radius.circular(4))),
                  //     child: Icon(Icons.crop_square, color: Colors.black)),
                ],
              ),
            ),
            Expanded(
              child: InsiteExpansionTile(
                tilePadding: EdgeInsets.only(left: 8),
                title: Table(
                  border: TableBorder.all(),
                  columnWidths: {
                    0: FlexColumnWidth(5),
                    1: FlexColumnWidth(3),
                  },
                  children: [
                    TableRow(
                      children: [
                        InsiteTableRowWithImage(
                          title: fleet.dealerName,
                          path: fleet == null
                              ? "assets/images/EX210.png"
                              : Utils().imageData(fleet.model),
                        ),
                        InsiteTableRowItem(
                          title: "Last Known Status",
                          content: fleet.status,
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        InsiteRichText(
                          title: "Serial No. ",
                          content: fleet.assetSerialNumber,
                        ),
                        // InsiteTableRowItem(
                        //   title: "Custom Asset State",
                        //   content: fleet.customStateDescription,
                        // ),
                        InsiteTableRowItem(
                          title: "Last Reported Time      ",
                          content: fleet.lastReportedUTC != null
                              ? Utils.getLastReportedDateOneUTC(
                                  fleet.lastReportedUTC)
                              : "",
                        ),
                      ],
                    ),
                  ],
                ),
                childrenPadding: EdgeInsets.only(left: 8),
                children: [
                  Table(
                    border: TableBorder.all(),
                    children: [
                      TableRow(
                        children: [
                          InsiteTableRowItem(
                            title: "Location - Last Reported",
                            content: fleet.lastReportedUTC != null
                                ? Utils.getLastReportedDateOneUTC(
                                    fleet.lastReportedUTC)
                                : "-",
                          ),
                          // InsiteTableRowItem(
                          //   title: "Last Reported Time      ",
                          //   content: fleet.lastReportedUTC != null
                          //       ? Utils.getLastReportedDateOneUTC(
                          //           fleet.lastReportedUTC)
                          //       : "",
                          // ),
                          InsiteTableRowItem(
                            title: "Dealer Name               ",
                            content: fleet.dealerName != null
                                ? fleet.dealerName
                                : "-",
                          ),
                        ],
                      ),
                      TableRow(children: [
                        InsiteTableRowItem(
                          title: "Location                 ",
                          //changing to location text
                          // content: fleet.lastReportedLocationLatitude
                          //         .toString() +
                          //     "/" +
                          //     fleet.lastReportedLocationLongitude.toString(),
                          content: fleet.lastReportedLocation != null
                              ? fleet.lastReportedLocation
                              : "-",
                        ),
                        InsiteTableRowItem(
                          title: "Signal Strength          ",
                          content: "-",
                        ),
                      ]),
                      TableRow(children: [
                        InsiteTableRowItem(
                          title: "Fuel - Last Reported     ",
                          content: fleet.lastPercentFuelRemainingUTC != null
                              ? Utils.getLastReportedDateOneUTC(
                                  fleet.lastPercentFuelRemainingUTC)
                              : "-",
                        ),
                        InsiteTableRowItem(
                          title: "Fuel Level%",
                          content: fleet.fuelLevelLastReported != null
                              ? fleet.fuelLevelLastReported.toString()
                              : "-",
                        ),
                      ]),
                      TableRow(children: [
                        InsiteTableRowItem(
                          title: "Network Provider         ",
                          content: "-",
                        ),
                        InsiteTableRowItem(
                          title: "Customer Name            ",
                          content: fleet.dealerCustomerName != null
                              ? fleet.dealerCustomerName
                              : "-",
                        ),
                      ]),
                      TableRow(children: [
                        InsiteTableRowItem(
                          title: "Asset Commissioning Date  ",
                          content: "-",
                        ),
                        // InsiteTableRowItem(
                        //   title: "Dealer Name               ",
                        //   content:
                        //       fleet.dealerName != null ? fleet.dealerName : "-",
                        // ),
                        InsiteTableRowItem(
                          title: "Hr Meter",
                          content: fleet.hourMeter != null
                              ? fleet.hourMeter.round().toString() + " hrs"
                              : "-",
                        ),
                      ]),
                      // TableRow(children: [
                      //   InsiteTableRowItem(
                      //     title: "Hr Meter",
                      //     content: fleet.hourMeter != null
                      //         ? fleet.hourMeter.round().toString() + " hrs"
                      //         : "-",
                      //   ),
                      //   InsiteTableRowItem(
                      //     title: "",
                      //     content: "",
                      //   ),
                      // ])
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
