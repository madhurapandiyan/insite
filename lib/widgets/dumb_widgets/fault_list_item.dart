import 'package:flutter/material.dart';
import 'package:insite/core/models/fault.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';
import 'package:logger/logger.dart';
import 'insite_row_item_text.dart';
import 'insite_text.dart';

class FaultListItem extends StatelessWidget {
  final Fault? fault;
  final VoidCallback? onCallback;
  const FaultListItem({this.fault, this.onCallback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onCallback!();
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(right: 10,left: 10),
          child: Row(
            children: [
              Container(
                //padding: EdgeInsets.all(2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // Icon(Icons.arrow_drop_down, color: Colors.white),
                    // SizedBox(
                    //   height: 20,
                    // ),
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
                  title: Table(
                    border: TableBorder.all(),
                    columnWidths: {
                      0: FlexColumnWidth(4),
                      1: FlexColumnWidth(3),
                    },
                    children: [
                      TableRow(
                        children: [
                          InsiteTableRowItemWithImage(
                            title: Utils.getMakeTitle(
                                    fault!.asset['details']["makeCode"]) +
                                "\n" +
                                fault?.asset["details"]["model"],
                            path: fault?.asset["details"] != null &&
                                    fault?.asset["details"]["model"] != null
                                ? Utils().getImageWithAssetIconKey(
                                    model: fault!.asset["details"]["model"],
                                    assetIconKey: fault!.asset["details"]
                                        ["assetIcon"])
                                : "assets/images/0.png",
                          ),
                          InsiteTableRowItem(
                            title: "Fault Reported Time :",
                            content: fault!.basic != null &&
                                    fault!.basic!.faultOccuredUTC != null
                                ? Utils.getLastReportedDateOneUTC(
                                    fault!.basic!.faultOccuredUTC)
                                : "-",
                          )
                        ],
                      ),
                      TableRow(children: [
                        InsiteRichText(
                          title: "Serial No. : ",
                          content: fault!.asset["basic"] != null &&
                                  fault!.asset["basic"]["serialNumber"] != null
                              ? fault!.asset["basic"]["serialNumber"]
                              : "",
                          onTap: () {
                            onCallback!();
                          },
                        ),
                        Table(
                          border: TableBorder.all(),
                          columnWidths: {
                            0: FlexColumnWidth(3),
                            1: FlexColumnWidth(3),
                          },
                          children: [
                            TableRow(children: [
                              InsiteTableRowItemWithButton(
                                title: "Severity : ",
                                buttonColor:
                                    Utils.getFaultColor(fault!.basic!.severity),
                                content: fault!.basic != null &&
                                        fault!.basic!.severity != null
                                    ? Utils.getFaultLabel(fault!.basic!.severity!)
                                    : "",
                              ),
                            ])
                          ],
                        )
                      ]),
                    ],
                  ),
                  tilePadding: EdgeInsets.all(0),
                  children: [
                    Table(
                      border: TableBorder.all(),
                      children: [
                        TableRow(children: [
                          InsiteRichText(
                            title: "Source : ",
                            content: fault!.basic != null &&
                                    fault!.basic!.source != null
                                ? fault!.basic!.source
                                : "",
                            style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.bodyText1!.color),
                            onTap: () {
                              onCallback!();
                            },
                          ),
                        ]),
                        TableRow(children: [
                          InsiteRichText(
                            title: "Description : ",
                            content: fault!.basic != null &&
                                    fault!.basic!.description != null
                                ? fault!.basic!.description
                                : "",
                            onTap: () {
                              onCallback!();
                            },
                            style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.bodyText1!.color),
                          ),
                        ]),
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
