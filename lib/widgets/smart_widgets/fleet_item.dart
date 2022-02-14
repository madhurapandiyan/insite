import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';

class FleetListItem extends StatelessWidget {
  final Fleet? fleet;
  final VoidCallback? onCallback;
  const FleetListItem({this.fleet, this.onCallback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onCallback!();
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       // SizedBox(
              //       //   height: 20,
              //       // ),
              //       // Icon(Icons.arrow_drop_down, color: Colors.white),
              //       // SizedBox(
              //       //   height: 20,
              //       // ),
              //       // Container(
              //       //     decoration: BoxDecoration(
              //       //         color: Colors.black,
              //       //         borderRadius: BorderRadius.all(Radius.circular(4))),
              //       //     child: Icon(Icons.crop_square, color: Colors.black)),
              //     ],
              //   ),
              // ),
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
                          InsiteTableRowItemWithImage(
                            title: fleet!.manufacturer! + "\n" + fleet!.model!,
                            path: fleet == null
                                ? "assets/images/EX210.png"
                                : Utils().imageData(fleet!.model!),
                          ),
                          InsiteTableRowItem(
                            title: "Last Known Status",
                            content: fleet!.status,
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          InsiteRichText(
                            title: "Serial No. ",
                            content: fleet!.assetSerialNumber,
                            onTap: () {
                              onCallback!();
                            },
                          ),
                          // InsiteTableRowItem(
                          //   title: "Custom Asset State",
                          //   content: fleet.customStateDescription,
                          // ),
                          InsiteTableRowItem(
                            title: "Last Reported Time      ",
                            content: fleet!.lastReportedUTC != null
                                ? Utils.getLastReportedDateOneUTC(
                                    fleet!.lastReportedUTC)
                                : "",
                          ),
                        ],
                      ),
                    ],
                  ),
                  childrenPadding: EdgeInsets.only(left: 8),
                  children: [
                    Column(
                      children: [
                        Table(
                          border: TableBorder.all(),
                          children: [
                            TableRow(
                              children: [
                                InsiteTableRowItem(
                                  title: "Location                 ",
                                  //changing to location text
                                  // content: fleet.lastReportedLocationLatitude
                                  //         .toString() +
                                  //     "/" +
                                  //     fleet.lastReportedLocationLongitude.toString(),
                                  content: fleet!.lastReportedLocation != null
                                      ? fleet!.lastReportedLocation
                                      : "-",
                                ),
                                InsiteTableRowItem(
                                  title: "Location - Last Reported",
                                  content: fleet!.lastReportedUTC != null
                                      ? Utils.getLastReportedDateOneUTC(
                                          fleet!.lastReportedUTC)
                                      : "-",
                                ),
                                // InsiteTableRowItem(
                                //   title: "Last Reported Time      ",
                                //   content: fleet.lastReportedUTC != null
                                //       ? Utils.getLastReportedDateOneUTC(
                                //           fleet.lastReportedUTC)
                                //       : "",
                                // ),
                                // InsiteTableRowItem(
                                //   title: "Dealer Name               ",
                                //   content: fleet.dealerName != null
                                //       ? fleet.dealerName
                                //       : "-",
                                // ),
                              ],
                            ),
                            TableRow(children: [
                              InsiteTableRowItem(
                                title: "Fuel Level%",
                                content: fleet!.fuelLevelLastReported != null
                                    ? fleet!.fuelLevelLastReported.toString()
                                    : "-",
                              ),
                              InsiteTableRowItem(
                                title: "Fuel - Last Reported     ",
                                content: fleet!.lastPercentFuelRemainingUTC != null
                                    ? Utils.getLastReportedDateOneUTC(
                                        fleet!.lastPercentFuelRemainingUTC)
                                    : "-",
                              ),
                            ]),
                            TableRow(children: [
                              InsiteTableRowItem(
                                title: "Hr Meter",
                                content: fleet!.hourMeter != null
                                    ? fleet!.hourMeter!.toString() + " hrs"
                                    : "-",
                              ),
                              InsiteTableRowItem(
                                title: "Asset Commissioning Date  ",
                                content: "-",
                              ),
                            ]),
                            TableRow(children: [
                              InsiteTableRowItem(
                                title: "Signal Strength          ",
                                content: "-",
                              ),
                              InsiteTableRowItem(
                                title: "Network Provider         ",
                                content: "-",
                              ),
                            ]),
                            TableRow(children: [
                              // InsiteTableRowItem(
                              //   title: "Asset Commissioning Date  ",
                              //   content: "-",
                              // ),
                              InsiteTableRowItem(
                                title: "Dealer Name               ",
                                content: fleet!.dealerName != null
                                    ? fleet!.dealerName
                                    : "-",
                              ),
                              InsiteTableRowItem(
                                title: "Customer Name            ",
                                content: fleet!.universalCustomerName != null
                                    ? fleet!.universalCustomerName
                                    : "-",
                              )
                              // InsiteTableRowItem(
                              //   title: "Hr Meter",
                              //   content: fleet.hourMeter != null
                              //       ? fleet.hourMeter.round().toString() + " hrs"
                              //       : "-",
                              // ),
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
                        ),
                        SizedBox(height: 10,)
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
