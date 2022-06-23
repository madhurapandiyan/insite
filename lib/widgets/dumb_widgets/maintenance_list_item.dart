import 'package:flutter/material.dart';
import 'package:insite/core/models/fault.dart';
import 'package:insite/core/models/maintenance.dart';
import 'package:insite/core/models/maintenance_list_services.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/maintenance/main/main_view_model.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'insite_row_item_text.dart';
import 'insite_text.dart';

class MaintenanceListItem extends StatefulWidget {
  final SummaryData? summaryData;
  final VoidCallback? onCallback;
  const MaintenanceListItem(
      {this.summaryData, this.onCallback, this.serviceCalBack});
  final Function? serviceCalBack;

  @override
  State<MaintenanceListItem> createState() => _MaintenanceListItemState();
}

class _MaintenanceListItemState extends State<MaintenanceListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onCallback!();
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
                          path: widget.summaryData!.model != null
                              ? Utils().getImageWithAssetIconKey(
                                  model: widget.summaryData!.model,
                                  assetIconKey: widget.summaryData!.assetIcon)
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
                          content: widget.summaryData!.makeCode,
                        ),
                        InsiteTableRowItem(
                          title: "Model :",
                          content: widget.summaryData!.model,
                        )
                      ],
                    ),
                    TableRow(children: [
                      InsiteRichText(
                        title: "Serial No. : ",
                        content: widget.summaryData!.assetSerialNumber !=
                                    null &&
                                widget.summaryData!.assetSerialNumber != null
                            ? widget.summaryData!.assetSerialNumber
                            : "",
                        onTap: () {
                          widget.onCallback!();
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
                              buttonColor: Utils.getMaintenanceColor(
                                  widget.summaryData!.dueInfo!.serviceStatus),
                              content: widget.summaryData!.dueInfo != null
                                  ? Utils.getFaultLabel(widget
                                      .summaryData!.dueInfo!.serviceStatus!)
                                  : "",
                            ),
                          ])
                        ],
                      ),
                      InsiteTableRowItemWithButton(
                        title: "Service :",
                        content: widget.summaryData!.service,
                        onTap: () {
                          widget.serviceCalBack!();
                        },
                        buttonColor: Theme.of(context).buttonColor,
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
                            "${widget.summaryData!.dueInfo!.dueBy!.abs().toStringAsFixed(0)} hrs ",
                      ),
                      InsiteTableRowItem(
                        title: "Due At :",
                        content: widget.summaryData!.dueInfo!.dueAt!
                            .toStringAsFixed(0),
                      ),
                      InsiteTableRowItem(
                        title: "Due Date :",
                        content: Utils.getDateInFormatddMMyyyy(
                            widget.summaryData!.dueInfo!.dueDate),
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
                                "${widget.summaryData!.location!.streetAddress} , ${widget.summaryData!.location!.city} , ${widget.summaryData!.location!.state}"),
                        InsiteTableRowItem(
                          title: "Current Hour Meter :",
                          content: widget.summaryData!.currentHourMeter!
                              .toStringAsFixed(0),
                        ),
                      ]),
                    ],
                  ),
                  Table(
                    border: TableBorder.all(),
                    children: [
                      TableRow(children: [
                        InsiteTableRowItem(
                          title: "Product Family :",
                          content: widget.summaryData!.productFamily ?? "-",
                        ),
                        InsiteTableRowItem(
                          title: "Service Completed Date :",
                          content:
                              widget.summaryData!.serviceCompletedDate ?? "-",
                        ),
                      ]),
                    ],
                  ),
                  Table(
                    border: TableBorder.all(),
                    children: [
                      TableRow(children: [
                        InsiteTableRowItem(
                          title: "Fuel Level :",
                          content: widget.summaryData!.fuelPercentage ?? "-",
                        ),
                        InsiteTableRowItem(
                          title: "Last Reported Fuel Time :",
                          content: widget.summaryData!.fuelReportedTime ?? "-",
                        ),
                      ]),
                    ],
                  ),
                  Table(
                    border: TableBorder.all(),
                    children: [
                      TableRow(children: [
                        InsiteTableRowItem(
                          title: "Devie Id :",
                          content: widget.summaryData!.telematicDeviceId ?? "-",
                        ),
                        InsiteTableRowItem(
                          title: "Device Type :",
                          content: widget.summaryData!.deviceType ?? "-",
                        ),
                      ]),
                    ],
                  ),
                  Table(
                    border: TableBorder.all(),
                    children: [
                      TableRow(children: [
                        InsiteTableRowItem(
                          title: "Dealer Name :",
                          content: widget.summaryData!.dealerName ?? "-",
                        ),
                        InsiteTableRowItem(
                          title: "Customer Name :",
                          content: widget.summaryData!.customerName ?? "-",
                        ),
                      ]),
                    ],
                  ),
                  // viewModel.refreshing
                  //     ? Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: InsiteProgressBar(),
                  //       )
                  //     : SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
