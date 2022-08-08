import 'package:flutter/material.dart';
import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/models/subscription_dashboard_details.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';

class DeviceListItem extends StatelessWidget {
  final detailResult;
  final VoidCallback? onCallback;
  const DeviceListItem({Key? key, this.detailResult, this.onCallback})
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
              enableGraphQl
                  ? Expanded(
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
                                title: detailResult!.gpsDeviceID != null
                                    ? "Device ID : " +
                                        "\n" +
                                        detailResult!.gpsDeviceID!
                                    : "Device ID : " + "\n",
                                path: detailResult == null ||
                                        detailResult!.model == null
                                    ? "assets/images/EX210.png"
                                    : detailResult!.model != null
                                        ? Utils()
                                            .imageData(detailResult!.model!)
                                        : "-",
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
                                    : "-",
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
                                content: detailResult!.vin != null
                                    ? detailResult!.vin
                                    : "-",
                                onTap: () {
                                  onCallback!();
                                },
                              ),
                              InsiteTableRowItem(
                                title: "Product Family :",
                                content: detailResult!.productFamily != null
                                    ? detailResult!.productFamily
                                    : "-",
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
                                  title: "Customer Code : ",
                                  content: detailResult!.customerCode != null
                                      ? detailResult!.customerCode
                                      : "-",
                                ),
                                InsiteTableRowItem(
                                  title: "Dealer Name : ",
                                  content: detailResult!.dealerName != null
                                      ? detailResult!.dealerName
                                      : "-",
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                InsiteTableRowItem(
                                  title: "Dealer Code :",
                                  content: detailResult!.dealerCode != null
                                      ? detailResult!.dealerCode
                                      : "-",
                                ),
                                InsiteTableRowItem(
                                  title: "Customer Name :",
                                  content: detailResult!.customerName != null
                                      ? detailResult!.customerName
                                      : detailResult!.customerName != null
                                          ? detailResult!.customerName
                                          : "-",
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                InsiteTableRowItem(
                                  title: "Status :",
                                  content: detailResult!.status == 2
                                      ? "Success"
                                      : "Failed",
                                ),
                                InsiteTableRowItem(
                                  title: "Description :",
                                  content: detailResult!.description != null
                                      ? detailResult!.description
                                      : "",
                                ),
                              ],
                            ),
                            // TableRow(
                            //   children: [
                            //     InsiteTableRowItem(
                            //       title: "Actual Start Date :",
                            //       content: detailResult!.SubscriptionStartDate != null
                            //           ? Utils.getDateInFormatddMMyyyy(
                            //               detailResult!.ActualStartDate)
                            //           : "",
                            //     ),
                            //     InsiteTableRowItem(
                            //       title: "Subscription End Date :",
                            //       content: detailResult!.SubscriptionStartDate != null
                            //           ? Utils.getDateInFormatddMMyyyy(
                            //               detailResult!.SubscriptionEndDate)
                            //           : "",
                            //     ),
                            //   ],
                            // ),
                          ],
                        )
                      ],
                      tilePadding: EdgeInsets.all(0),
                    ))
                  : Expanded(
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
                                title: detailResult!.GPSDeviceID != null
                                    ? "Device ID : " +
                                        "\n" +
                                        detailResult!.GPSDeviceID!
                                    : "Device ID : " + "\n",
                                path: detailResult == null ||
                                        detailResult!.Model == null
                                    ? "assets/images/EX210.png"
                                    : detailResult!.Model != null
                                        ? Utils()
                                            .imageData(detailResult!.Model!)
                                        : "-",
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
                                content: detailResult!.Model != null
                                    ? detailResult!.Model
                                    : "-",
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
                                content: detailResult!.VIN != null
                                    ? detailResult!.VIN
                                    : "-",
                                onTap: () {
                                  onCallback!();
                                },
                              ),
                              InsiteTableRowItem(
                                title: "Product Family :",
                                content: detailResult!.ProductFamily != null
                                    ? detailResult!.ProductFamily
                                    : "-",
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
                                  title: "Customer Code : ",
                                  content: detailResult!.CustomerCode != null
                                      ? detailResult!.CustomerCode
                                      : "-",
                                ),
                                InsiteTableRowItem(
                                  title: "Dealer Name : ",
                                  content: detailResult!.DealerName != null
                                      ? detailResult!.DealerName
                                      : "-",
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                InsiteTableRowItem(
                                  title: "Dealer Code :",
                                  content: detailResult!.DealerCode != null
                                      ? detailResult!.DealerCode
                                      : "-",
                                ),
                                InsiteTableRowItem(
                                  title: "Customer Name :",
                                  content: detailResult!.CustomerName != null
                                      ? detailResult!.CustomerName
                                      : detailResult!.CustomerName != null
                                          ? detailResult!.CustomerName
                                          : "-",
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                InsiteTableRowItem(
                                  title: "Status :",
                                  content: detailResult!.fk_State == 2
                                      ? "Success"
                                      : "Failed",
                                ),
                                InsiteTableRowItem(
                                  title: "Description :",
                                  content: detailResult!.Description != null
                                      ? detailResult!.Description
                                      : "",
                                ),
                              ],
                            ),
                            // TableRow(
                            //   children: [
                            //     InsiteTableRowItem(
                            //       title: "Actual Start Date :",
                            //       content: detailResult!.SubscriptionStartDate != null
                            //           ? Utils.getDateInFormatddMMyyyy(
                            //               detailResult!.ActualStartDate)
                            //           : "",
                            //     ),
                            //     InsiteTableRowItem(
                            //       title: "Subscription End Date :",
                            //       content: detailResult!.SubscriptionStartDate != null
                            //           ? Utils.getDateInFormatddMMyyyy(
                            //               detailResult!.SubscriptionEndDate)
                            //           : "",
                            //     ),
                            //   ],
                            // ),
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
