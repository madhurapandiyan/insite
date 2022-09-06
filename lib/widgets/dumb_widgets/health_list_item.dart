import 'package:flutter/material.dart';
import 'package:insite/core/models/health_list_response.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';

class HealthListItem extends StatelessWidget {
  final Fault? faultElement;
  HealthListItem({this.faultElement});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //       SizedBox(
                //         height: 20,
                //       ),
                //       Icon(Icons.arrow_drop_down, color: Colors.white),
                //       SizedBox(
                //         height: 20,
                //       ),
                //       Container(
                //           decoration: BoxDecoration(
                //               color: Colors.black,
                //               borderRadius: BorderRadius.all(Radius.circular(4))),
                //           child: Icon(
                //             Icons.crop_square,
                //             color: Colors.black,
                //           )),
              ],
            ),
          ),
          Expanded(
              child: InsiteExpansionTile(
            title: Table(
              border: TableBorder.all(),
              columnWidths: {
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(1)
              },
              children: [
                TableRow(children: [
                  InsiteTableRowItem(
                    title: 'Description :',
                    content: faultElement!.description ?? "-",
                  ),
                  InsiteTableRowItem(
                    title: 'Location :',
                    content: "${faultElement!.lastReportedLocationLatitude ?? "-"}/${faultElement!.lastReportedLocationLongitude ?? "-"}",
                  ),
                ]),
                TableRow(children: [
                  InsiteTableRowItem(
                    title: 'Hour Meter :',
                    content: faultElement!.hours == null
                        ? "-"
                        : faultElement!.hours.toString(),
                  ),
                  InsiteTableRowItem(
                    title: 'Source :',
                    content: faultElement!.source ?? "-",
                  ),
                ]),
                TableRow(children: [
                  InsiteTableRowItem(
                    title: 'Fault Reported Time :',
                    content: Utils.getLastReportedDateOneUTC(faultElement!.lastReportedTimeUTC)
                    
                  ),
                  Column(
                    children: [
                      InsiteText(
                        text: "Severity",
                        size: 13,
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      InsiteButton(
                        width: 70,
                        height: 30,
                        bgColor:
                            Utils.getFaultColor(faultElement!.severityLabel),
                        title: faultElement!.severityLabel,
                        textColor: textcolor,
                      )
                    ],
                  )
                ]),
              ],
            ),
            children: [
              Table(
                border: TableBorder.all(),
                columnWidths: {
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(1),
                  3: FlexColumnWidth(1)
                },
                children: [
                  TableRow(children: [
                    InsiteTableRowItem(
                      title: 'SPN_FMI',
                      content: faultElement!.faultIdentifiers != null
                          ? faultElement!.faultIdentifiers
                          : "-",
                    ),
                    InsiteTableRowItem(
                      title: 'Occurence Count :',
                      content: faultElement!.occurrences ?? "-",
                    ),
                  ]),
                  // TableRow(children: [
                  //   InsiteTableRowItem(
                  //     title: 'Fault Reported Time :',
                  //     content: faultElement!.lastReportedTimeUTC != null
                  //         ? faultElement!.lastReportedTimeUTC
                  //         : "-",
                  //   ),
                  //   InsiteTableRowItem(
                  //       title: 'Location :',
                  //       content:
                  //           "${faultElement!.lastReportedLocationLatitude ?? "-"}/${faultElement!.lastReportedLocationLongitude ?? "-"}"),
                  // ])
                ],
              )
            ],
            tilePadding: EdgeInsets.all(0),
            childrenPadding: EdgeInsets.all(0),
          ))
        ],
      ),
    );
  }
}
