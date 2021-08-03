import 'package:flutter/material.dart';
import 'package:insite/core/models/fault.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';
import 'insite_row_item_text.dart';
import 'insite_text.dart';

class FaultListItem extends StatelessWidget {
  final Fault fault;
  final VoidCallback onCallback;
  const FaultListItem({this.fault, this.onCallback});

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
          children: [
            Container(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                title: Table(
                  border: TableBorder.all(),
                  columnWidths: {
                    0: FlexColumnWidth(3),
                    1: FlexColumnWidth(3),
                  },
                  children: [
                    TableRow(
                      children: [
                        InsiteTableRowItemWithImage(
                          title: "Asset ID :",
                          path: fault.asset["details"] != null &&
                                  fault.asset["details"]["model"] != null
                              ? Utils()
                                  .imageData(fault.asset["details"]["model"])
                              : "assets/images/EX210.png",
                        ),
                        Table(
                          border: TableBorder.all(),
                          columnWidths: {
                            0: FlexColumnWidth(3),
                            1: FlexColumnWidth(3),
                          },
                          children: [
                            TableRow(children: [
                              InsiteTableRowItem(
                                title: "Make :",
                                content: fault.asset["details"] != null &&
                                        fault.asset["details"]["makeCode"] !=
                                            null
                                    ? fault.asset["details"]["makeCode"]
                                    : "-",
                              ),
                              InsiteTableRowItem(
                                title: "Model :",
                                content: fault.asset["details"] != null &&
                                        fault.asset["details"]["model"] != null
                                    ? fault.asset["details"]["model"]
                                    : "-",
                              ),
                            ])
                          ],
                        )
                      ],
                    ),
                    TableRow(children: [
                      InsiteRichText(
                        title: "Serial No. : ",
                        content: fault.asset["basic"] != null &&
                                fault.asset["basic"]["serialNumber"] != null
                            ? fault.asset["basic"]["serialNumber"]
                            : "",
                        onTap: () {},
                      ),
                      Table(
                        border: TableBorder.all(),
                        columnWidths: {
                          0: FlexColumnWidth(3),
                          1: FlexColumnWidth(3),
                        },
                        children: [
                          TableRow(children: [
                            InsiteTableRowItem(
                              title: "Date/Time :",
                              content: fault.basic != null &&
                                      fault.basic.faultOccuredUTC != null
                                  ? Utils.getLastReportedDateOne(
                                      fault.basic.faultOccuredUTC)
                                  : "-",
                            ),
                            InsiteTableRowItemWithButton(
                              title: "Severity : ",
                              buttonColor:
                                  Utils.getFaultColor(fault.basic.severity),
                              content: fault.basic != null &&
                                      fault.basic.severity != null
                                  ? fault.basic.severity.toLowerCase() == "red"
                                      ? "HIGH"
                                      : fault.basic.severity.toLowerCase() ==
                                              "green"
                                          ? "MEDIUM"
                                          : fault.basic.severity
                                                      .toLowerCase() ==
                                                  "yellow"
                                              ? "LOW"
                                              : ""
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
                          content:
                              fault.basic != null && fault.basic.source != null
                                  ? fault.basic.source
                                  : "",
                          style: TextStyle(color: Colors.white),
                        ),
                      ]),
                      TableRow(children: [
                        InsiteRichText(
                          title: "Description : ",
                          content: fault.basic != null &&
                                  fault.basic.description != null
                              ? fault.basic.description
                              : "",
                          style: TextStyle(color: Colors.white),
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
    );
  }
}
