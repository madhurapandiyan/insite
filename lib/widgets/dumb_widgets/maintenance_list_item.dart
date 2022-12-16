import 'package:flutter/material.dart';
import 'package:insite/core/models/fault.dart';
import 'package:insite/core/models/maintenance.dart';
import 'package:insite/core/models/user_preference.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/maintenance/main/main_view_model.dart';
import 'package:insite/views/preference/model/time_zone.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'insite_row_item_text.dart';
import 'insite_text.dart';

class MaintenanceListItem extends StatefulWidget {
   final UserPreference?dateFormat;
  final UserPreferedData?timeZone;
  final SummaryData? summaryData;
  final VoidCallback? onCallback;
  const MaintenanceListItem(
      {this.summaryData, this.onCallback, this.serviceCalBack, this.dateFormat, this.timeZone});
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: InsiteExpansionTile(
                  title: Table(
                    border: TableBorder.all(),
                    columnWidths: {
                      0: FlexColumnWidth(3),
                      1: FlexColumnWidth(2),
                      //2: FlexColumnWidth(2.5),
                    },
                    children: [
                      TableRow(
                        children: [
                          InsiteTableRowItemWithImage(
                            title: widget.summaryData!.model,
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
                            title: "Product Family :",
                            content: widget.summaryData!.productFamily ?? "-",
                          ),
                          // InsiteTableRowItem(
                          //   title: "Service Completed Date :",
                          //   content:
                          //       widget.summaryData!.serviceCompletedDate ?? "-",
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
                        InsiteTableRowItem(
                          title: "Device Id :",
                          content: widget.summaryData!.telematicDeviceId ?? "-",
                        ),
                      ]),
                      TableRow(
                        
                        children: [
                          
                        InsiteTableRowItemWithRowButton(
                          title: "Service Status : ",
                          buttonColor: Utils.getMaintenanceColor(
                              widget.summaryData!.dueInfo!.serviceStatus),
                          content: widget.summaryData!.dueInfo != null
                              ? widget.summaryData!.dueInfo!.serviceStatus!
                              : "",
                        ),
                        InsiteRichText(
                          title: "Service :",
                          content: widget.summaryData!.service,
                          onTap: () {
                            widget.serviceCalBack!();
                          },
                        ),
                      ])
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
                      ]),
                    ]),
                    Table(
                      border: TableBorder.all(),
                      children: [
                        TableRow(children: [
                          InsiteTableRowItem(
                              title: "Location :",
                              content:Utils.getLocationDisplay(widget.dateFormat?.locationDisplay)?
                                  "${widget.summaryData!.location!.streetAddress} , ${widget.summaryData!.location!.city} , ${widget.summaryData!.location!.state}"
                                  :"${widget.summaryData!.geoLocation?.latitude??"-"}/${widget.summaryData!.geoLocation!.longitude??"-"}"
                                  ),
                          InsiteTableRowItem(
                            title: "Current Hour Meter :",
                            content: widget.summaryData!.currentHourMeter!
                                .toStringAsFixed(2),
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
                            content:
                               Utils.getDateUTC( widget.summaryData!.fuelReportedTime ?? "-", widget.dateFormat, widget.timeZone),
                          ),
                        ]),
                      ],
                    ),
                    Table(
                      border: TableBorder.all(),
                      children: [
                        TableRow(children: [
                          InsiteTableRowItem(
                            title: "Due Date :",
                            content: Utils.getPreferenceDate(
                                widget.summaryData!.dueInfo!.dueDate,widget.dateFormat,widget.timeZone),
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
      ),
    );
  }
}
