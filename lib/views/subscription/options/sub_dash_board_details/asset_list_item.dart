import 'package:flutter/material.dart';
import 'package:insite/core/models/subscription_dashboard_details.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';
import 'package:logger/logger.dart';

class AssetListItem extends StatelessWidget {
  final DetailResult? detailResult;
  final VoidCallback? onCallback;
  const AssetListItem({Key? key, this.detailResult, this.onCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: () {},
      child: Card(
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
                        title: "Model :",
                        content: detailResult!.model != null
                            ? detailResult!.model
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
                            detailResult!.vin!= null ? detailResult!.vin : "",
                        onTap: () {
                          onCallback!();
                        },
                      ),
                      InsiteTableRowItem(
                        title: "Product Family :",
                        content: detailResult!.productFamily != null
                            ? detailResult!.productFamily
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
                          title: "Subscription Start Date :",
                          content: detailResult!.subscriptionStartDate != null
                              ? Utils.getDateInFormatddMMyyyy(
                                  detailResult!.subscriptionStartDate)
                              : "",
                        ),
                        InsiteTableRowItem(
                          title: "Subscription End Date :",
                          content: detailResult!.subscriptionStartDate != null
                              ? Utils.getDateInFormatddMMyyyy(
                                  detailResult!.subscriptionEndDate)
                              : "",
                        ),
                      ],
                    ),
                  ],
                ),
                Table(
                  border: TableBorder.all(),
                  children: [
                    TableRow(children: [
                      InsiteTableRowItem(
                        title: "Actual Start Date :",
                        content: detailResult!.subscriptionStartDate != null
                            ? Utils.getDateInFormatddMMyyyy(
                                detailResult!.actualStartDate)
                            : "",
                      ),
                    ])
                  ],
                ),
              ],
              tilePadding: EdgeInsets.all(0),
            ))
          ],
        ),
      ),
    );
  }
}
