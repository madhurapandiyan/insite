import 'package:flutter/material.dart';
import 'package:insite/core/models/subscription_dashboard_details.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';

class SubscriptionDeviceListItem extends StatelessWidget {
  final DetailResult detailResult;
  final VoidCallback onCallback;
  const SubscriptionDeviceListItem(
      {Key key, this.detailResult, this.onCallback})
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
                        title: detailResult.GPSDeviceID != null
                            ? "Device ID : " + "\n" + detailResult.GPSDeviceID
                            : "Device ID : " + "\n",
                        path: detailResult == null || detailResult.Model == null
                            ? "assets/images/EX210.png"
                            : detailResult.Model != null
                                ? Utils().imageData(detailResult.Model)
                                : "",
                      ),
                      Table(
                        children: [
                          TableRow(
                            children: [
                              InsiteTableRowItem(
                                title: "Make :",
                                content: "",
                              ),
                              InsiteTableRowItem(
                                title: "Model :",
                                content: detailResult.Model != null
                                    ? detailResult.Model
                                    : "",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      InsiteRichText(
                        title: "Serial No. ",
                        content:
                            detailResult.VIN != null ? detailResult.VIN : "",
                        onTap: () {
                          onCallback();
                        },
                      ),
                      InsiteTableRowItem(
                        title: "Product Family :",
                        content: detailResult.ProductFamily != null
                            ? detailResult.ProductFamily
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
                          title: "Network Provider : ",
                          content: detailResult.NetworkProvider != null
                              ? detailResult.NetworkProvider
                              : "",
                        ),
                        InsiteTableRowItem(
                          title: "Dealer Name : ",
                          content: detailResult.DealerName != null
                              ? detailResult.DealerName
                              : "",
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        InsiteTableRowItem(
                          title: "Dealer Code :",
                          content: detailResult.DealerCode != null
                              ? detailResult.DealerCode
                              : "",
                        ),
                        InsiteTableRowItem(
                          title: "Customer Name :",
                          content: detailResult.CustomerName != null
                              ? detailResult.CustomerName
                              : detailResult.Name != null
                                  ? detailResult.Name
                                  : "",
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        InsiteTableRowItem(
                          title: "Customer Code :",
                          content: detailResult.CustomerCode != null
                              ? detailResult.CustomerCode
                              : detailResult.Code != null
                                  ? detailResult.Code
                                  : "",
                        ),
                        InsiteTableRowItem(
                          title: "Subscription Start Date :",
                          content: detailResult.SubscriptionStartDate != null
                              ? Utils.getDateInFormatddMMyyyy(
                                  detailResult.SubscriptionStartDate)
                              : "",
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        InsiteTableRowItem(
                          title: "Actual Start Date :",
                          content: detailResult.SubscriptionStartDate != null
                              ? Utils.getDateInFormatddMMyyyy(
                                  detailResult.ActualStartDate)
                              : "",
                        ),
                        InsiteTableRowItem(
                          title: "Subscription End Date :",
                          content: detailResult.SubscriptionStartDate != null
                              ? Utils.getDateInFormatddMMyyyy(
                                  detailResult.SubscriptionEndDate)
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
    );
  }
}
