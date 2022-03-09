import 'package:flutter/material.dart';
import 'package:insite/core/models/fault.dart';
import 'package:insite/core/models/maintenance.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';
import 'package:logger/logger.dart';
import 'insite_row_item_text.dart';
import 'insite_text.dart';

class MaintenanceListItem extends StatelessWidget {
  final SummaryData? summaryData;
  final VoidCallback? onCallback;
  const MaintenanceListItem({this.summaryData, this.onCallback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onCallback!();
      },
      child: Card(
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(2),
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
                    0: FlexColumnWidth(1.5),
                    1: FlexColumnWidth(1.5),
                  },
                  children: [
                    TableRow(
                      children: [
                        InsiteTableRowItemWithImage(
                          title: Utils.getMakeTitle("Asset ID:") + "\n" + "-",
                          path: summaryData!.model != null
                              ? Utils().imageData(summaryData!.model!)
                              : "assets/images/EX210.png",
                        ),
                        // InsiteTableRowItem(
                        //   title: "Date/Time :",
                        //   content: fault!.basic != null &&
                        //           fault!.basic!.faultOccuredUTC != null
                        //       ? Utils.getLastReportedDateOneUTC(
                        //           fault!.basic!.faultOccuredUTC)
                        //       : "-",
                        // )
                        InsiteTableRowItem(
                          title: "Make :",
                          content: summaryData!.makeCode,
                        ),
                        InsiteTableRowItem(
                          title: "Model :",
                          content: summaryData!.model,
                        )
                      ],
                    ),
                    TableRow(children: [
                      InsiteRichText(
                        title: "Serial No. : ",
                        content: summaryData!.assetSerialNumber != null &&
                                summaryData!.assetSerialNumber != null
                            ? summaryData!.assetSerialNumber
                            : "",
                        onTap: () {
                          onCallback!();
                        },
                      ),
                      Table(
                        columnWidths: {
                          0: FlexColumnWidth(2),
                          1: FlexColumnWidth(2),
                        },
                        children: [
                          TableRow(children: [
                            InsiteTableRowItemWithButton(
                              title: "Severity : ",
                              buttonColor: Utils.getFaultColor(
                                  summaryData!.dueInfo!.serviceStatus),
                              content: summaryData!.dueInfo != null
                                  ? Utils.getFaultLabel(
                                      summaryData!.dueInfo!.serviceStatus!)
                                  : "",
                            ),
                          ])
                        ],
                      ),
                      InsiteTableRowItem(
                        title: "Service :",
                        content: summaryData!.service,
                      ),
                    ]),
                  ],
                ),
                tilePadding: EdgeInsets.all(0),
                children: [
                  Table(border: TableBorder.all(), children: [
                    TableRow(children: [
                      InsiteTableRowItem(
                        title: "Due in/ Overdue :",
                        content:
                            "${summaryData!.dueInfo!.dueBy!.abs().toStringAsFixed(0)} hrs ",
                      ),
                      InsiteTableRowItem(
                        title: "Due At :",
                        content:
                            summaryData!.dueInfo!.dueAt!.toStringAsFixed(0),
                      ),
                      InsiteTableRowItem(
                        title: "Due Date :",
                        content: Utils.getDateInFormatddMMyyyy(
                            summaryData!.dueInfo!.dueDate),
                      ),
                    ]),
                  ]),
                  Table(
                    border: TableBorder.all(),
                    children: [
                      TableRow(children: [
                        InsiteTableRowItem(
                            title: "Location :",
                            content:
                                "${summaryData!.location!.streetAddress} , ${summaryData!.location!.city} , ${summaryData!.location!.state}"),
                        InsiteTableRowItem(
                          title: "Current Hour Meter :",
                          content:
                              summaryData!.currentHourMeter!.toStringAsFixed(0),
                        ),
                      ]),
                    ],
                  ),
                  Table(
                    border: TableBorder.all(),
                    children: [
                      TableRow(children: [
                        InsiteTableRowItem(
                          title: "Universal Customer :",
                          content: summaryData!.customerName,
                        ),
                        InsiteTableRowItem(
                          title: "DCN Name :",
                          content: summaryData!.dcnName,
                        ),
                      ]),
                    ],
                  ),
                  Table(
                    border: TableBorder.all(),
                    children: [
                      TableRow(children: [
                        InsiteTableRowItem(
                          title: "Registered Dealer :",
                          content: summaryData!.dealerName,
                        ),
                        InsiteTableRowItem(
                          title: "DCN Number :",
                          content: summaryData!.dcnNumber.toString(),
                        ),
                      ]),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
