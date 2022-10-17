import 'package:flutter/material.dart';
import 'package:insite/core/models/subscription_dashboard_details.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';

class TransferHistoryListItem extends StatelessWidget {
  final DetailResult? detailResult;
  final VoidCallback? onCallback;
  const TransferHistoryListItem({Key? key, this.detailResult, this.onCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // SizedBox(
                    // height: 20,
                    // ),
                    // Icon(Icons.arrow_drop_down, color: Colors.white),
                    // SizedBox(
                    // height: 20,
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
                    0: FlexColumnWidth(5),
                    1: FlexColumnWidth(3),
                  },
                  children: [
                    TableRow(
                      children: [
                        InsiteTableRowItemWithImage(
                          title: detailResult!.gpsDeviceId != null
                              ? "Device ID : " + "\n" + detailResult!.gpsDeviceId!
                              : "Device ID : " + "\n",
                          path: detailResult == null || detailResult!.model == null
                              ? "assets/images/EX210.png"
                              : detailResult!.model != null
                                  ? Utils().imageData(detailResult!.model!)
                                  : "",
                        ),
                        // Table(
                        // children: [
                        // TableRow(
                        // children: [
                        // InsiteTableRowItem(
                        //   title: "Make :",
                        //   content: "",
                        // ),
                        InsiteTableRowItem(
                          title: "Source Name 1 :",
                          content: detailResult!.sourceName1 != null
                              ? detailResult!.sourceName1
                              : "",
                        ),
                        // ],
                        // ),
                        // ],
                        // ),
                      ],
                    ),
                    TableRow(
                      children: [
                        InsiteRichText(
                          title: "Serial No. ",
                          content:
                              detailResult!.vin != null ? detailResult!.vin : "",
                          onTap: () {
                            onCallback!();
                          },
                        ),
                        InsiteTableRowItem(
                          title: "Source Name 2 :",
                          content: detailResult!.sourceName2 != null
                              ? detailResult!.sourceName2
                              : "",
                        ),
                      ],
                    ),
                  ],
                ),
                children: [
                  Table(
                    border: TableBorder.all(),
                    children: [
                      TableRow(
                        children: [
                          InsiteTableRowItem(
                            title: "Destination Name 1 :",
                            content: detailResult!.destinationName1 != null
                                ? detailResult!.destinationName1
                                : "",
                          ),
                          InsiteTableRowItem(
                            title: "Destination Name 2 : ",
                            content: detailResult!.destinationName2 != null
                                ? detailResult!.destinationName2
                                : "",
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          InsiteTableRowItem(
                            title: "Source Type :",
                            content: detailResult!.sourceCustomerType != null
                                ? detailResult!.sourceCustomerType
                                : "",
                          ),
                          InsiteTableRowItem(
                            title: "Destination Type :",
                            content: detailResult!.destinationCustomerType != null
                                ? detailResult!.destinationCustomerType
                                : "",
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          InsiteTableRowItem(
                            title: "Transfer Status :",
                            content: detailResult!.status != null
                                ? detailResult!.status
                                : detailResult!.status != null
                                    ? detailResult!.status
                                    : "",
                          ),
                          InsiteTableRowItem(
                            title: "Transferered Time :",
                            content: detailResult!.insertUtc != null
                                ? Utils.getLastReportedDate(
                                    detailResult!.insertUtc)
                                : "",
                          ),
                        ],
                      ),
                    ],
                  )
                ],
                tilePadding: EdgeInsets.all(0),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
