import 'package:flutter/material.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';

class AssetDetailWidget extends StatelessWidget {
  final Fleet fleet;
  const AssetDetailWidget({this.fleet});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardcolor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: cardcolor)),
      child: Container(
        child: ExpansionTile(
          title: Row(
            children: [],
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
        padding: EdgeInsets.all(8),
      ),
    );
  }
}
