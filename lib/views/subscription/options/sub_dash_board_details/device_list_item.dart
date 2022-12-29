import 'package:flutter/material.dart';
import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/models/subscription_dashboard_details.dart';
import 'package:insite/core/models/subscription_fleet_graphql.dart';
import 'package:insite/core/models/user_preference.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';

class DeviceListItem extends StatelessWidget {
  final DetailResult? detailResult;
  final FleetProvisionStatusInfo? fleetProvisionStatusInfo;
  final VoidCallback? onCallback;
  final UserPreference ? dateFormat;
  const DeviceListItem(
      {Key? key,
      this.detailResult,
      this.dateFormat,
      this.onCallback,
      this.fleetProvisionStatusInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: detailResult != null
            ? Card(
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
                                  title: detailResult!.gpsDeviceId!= null
                                      ? "Device ID : " +
                                          "\n" +
                                          detailResult!.gpsDeviceId!
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
                                    title: "Network Provider",
                                    content:
                                        detailResult!.networkProvider != null
                                            ? detailResult!.networkProvider
                                            : "-",
                                  ),
                                  InsiteTableRowItem(
                                    title: "Subscription Start Date",
                                    content: detailResult!.subscriptionStartDate != null
                                        ? Utils.getDateFromString(
                                            detailResult!.subscriptionStartDate,dateFormat)
                                        : "-",
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  InsiteTableRowItem(
                                    title: "Actual Start Date :",
                                    content:
                                        detailResult!.subscriptionStartDate !=
                                                null
                                            ? Utils.getDateFromString(
                                                detailResult!.actualStartDate,dateFormat)
                                            : "",
                                  ),
                                  InsiteTableRowItem(
                                    title: "Subscription End Date :",
                                    content: detailResult!
                                                .subscriptionStartDate !=
                                            null
                                        ? Utils.getDateFromString(
                                            detailResult!.subscriptionEndDate,dateFormat)
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
              )
            : Card(
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
                                  title: fleetProvisionStatusInfo!
                                              .gpsDeviceID !=
                                          null
                                      ? "Device ID : " +
                                          "\n" +
                                          fleetProvisionStatusInfo!.gpsDeviceID!
                                      : "Device ID : " + "\n",
                                  path: fleetProvisionStatusInfo == null ||
                                          fleetProvisionStatusInfo!.model ==
                                              null
                                      ? "assets/images/EX210.png"
                                      : fleetProvisionStatusInfo!.model != null
                                          ? Utils().imageData(
                                              fleetProvisionStatusInfo!.model!)
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
                                  content:
                                      fleetProvisionStatusInfo!.model != null
                                          ? fleetProvisionStatusInfo!.model
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
                                  content: fleetProvisionStatusInfo!.vin != null
                                      ? fleetProvisionStatusInfo!.vin
                                      : "-",
                                  onTap: () {
                                    onCallback!();
                                  },
                                ),
                                InsiteTableRowItem(
                                  title: "Product Family :",
                                  content: fleetProvisionStatusInfo!
                                              .productFamily !=
                                          null
                                      ? fleetProvisionStatusInfo!.productFamily
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
                                    content: fleetProvisionStatusInfo!
                                                .customerCode !=
                                            null
                                        ? fleetProvisionStatusInfo!.customerCode
                                        : "-",
                                  ),
                                  InsiteTableRowItem(
                                    title: "Dealer Name : ",
                                    content: fleetProvisionStatusInfo!
                                                .dealerName !=
                                            null
                                        ? fleetProvisionStatusInfo!.dealerName
                                        : "-",
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  InsiteTableRowItem(
                                    title: "Dealer Code :",
                                    content: fleetProvisionStatusInfo!
                                                .dealerCode !=
                                            null
                                        ? fleetProvisionStatusInfo!.dealerCode
                                        : "-",
                                  ),
                                  InsiteTableRowItem(
                                    title: "Customer Name :",
                                    content: fleetProvisionStatusInfo!
                                                .customerName !=
                                            null
                                        ? fleetProvisionStatusInfo!.customerName
                                        : fleetProvisionStatusInfo!
                                                    .customerName !=
                                                null
                                            ? fleetProvisionStatusInfo!
                                                .customerName
                                            : "-",
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  InsiteTableRowItem(
                                    title: "Status :",
                                    content:
                                        fleetProvisionStatusInfo!.status == 2
                                            ? "Success"
                                            : "Failed",
                                  ),
                                  InsiteTableRowItem(
                                    title: "Description :",
                                    content: fleetProvisionStatusInfo!
                                                .description !=
                                            null
                                        ? fleetProvisionStatusInfo!.description
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
              ));
  }
}
