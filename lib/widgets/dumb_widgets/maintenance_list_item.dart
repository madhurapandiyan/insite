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
  final Function(
          num? value, AssetData? assetDataValue, List<Services?>? serviceNames)?
      serviceCalBack;

  @override
  State<MaintenanceListItem> createState() => _MaintenanceListItemState();
}

class _MaintenanceListItemState extends State<MaintenanceListItem> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      builder: (BuildContext context, MainViewModel viewModel, Widget? _) {
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
                              title:
                                  Utils.getMakeTitle("Asset ID:") + "\n" + "-",
                              path: widget.summaryData!.model != null
                                  ? Utils()
                                      .imageData(widget.summaryData!.model!)
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
                            content:
                                widget.summaryData!.assetSerialNumber != null &&
                                        widget.summaryData!.assetSerialNumber !=
                                            null
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
                                  buttonColor: Utils.getFaultColor(widget
                                      .summaryData!.dueInfo!.serviceStatus),
                                  content: widget.summaryData!.dueInfo != null
                                      ? Utils.getFaultLabel(widget
                                          .summaryData!.dueInfo!.serviceStatus!)
                                      : "",
                                ),
                              ])
                            ],
                          ),
                          InsiteTableRowItem(
                            title: "Service :",
                            content: widget.summaryData!.service,
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
                              title: "Universal Customer :",
                              content: widget.summaryData!.customerName,
                            ),
                            InsiteTableRowItem(
                              title: "DCN Name :",
                              content: widget.summaryData!.dcnName,
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
                              content: widget.summaryData!.dealerName,
                            ),
                            InsiteTableRowItem(
                              title: "DCN Number :",
                              content: widget.summaryData!.dcnNumber.toString(),
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
                      viewModel.services.isNotEmpty
                          ? Table(
                              columnWidths: {
                                0: FlexColumnWidth(1),
                                1: FlexColumnWidth(1),
                                2: FlexColumnWidth(1),
                                3: FlexColumnWidth(1),
                                4: FlexColumnWidth(1),
                                5: FlexColumnWidth(1),
                              },
                              border: TableBorder.all(),
                              children: [
                                TableRow(children: [
                                  InsiteTextWithPadding(
                                    padding: EdgeInsets.all(8),
                                    text: "Service",
                                    size: 12,
                                  ),
                                  InsiteTextWithPadding(
                                    padding: EdgeInsets.all(8),
                                    text: "Service Status",
                                    size: 12,
                                  ),
                                  InsiteTextWithPadding(
                                    padding: EdgeInsets.all(8),
                                    text: "Service Interval",
                                    size: 12,
                                  ),
                                  InsiteTextWithPadding(
                                    padding: EdgeInsets.all(8),
                                    text: "Due At",
                                    size: 12,
                                  ),
                                  InsiteTextWithPadding(
                                    padding: EdgeInsets.all(8),
                                    text: "Due In/ Overdue By",
                                    size: 12,
                                  ),
                                  InsiteTextWithPadding(
                                    padding: EdgeInsets.all(8),
                                    text: "Due Date",
                                    size: 12,
                                  ),
                                  InsiteTextWithPadding(
                                    padding: EdgeInsets.all(8),
                                    text: "Service Type",
                                    size: 12,
                                  ),
                                ]),
                              ],
                            )
                          : SizedBox(),
                      viewModel.services.isNotEmpty
                          ? Container(
                              height: 200,
                              child: Scrollbar(
                                isAlwaysShown: true,
                                child: SingleChildScrollView(
                                  controller: viewModel.scrollController,
                                  child: Column(
                                    children: [
                                      Table(
                                        columnWidths: {
                                          0: FlexColumnWidth(1),
                                          1: FlexColumnWidth(2),
                                          2: FlexColumnWidth(1),
                                          3: FlexColumnWidth(1),
                                          4: FlexColumnWidth(1),
                                          5: FlexColumnWidth(1),
                                        },
                                        border: TableBorder.all(),
                                        children: List.generate(
                                            viewModel.services.length, (index) {
                                          Services? services =
                                              viewModel.services[index];
                                          return TableRow(children: [
                                            // InsiteTextWithPadding(
                                            //   padding: EdgeInsets.all(8),
                                            //   text: services!.serviceName,
                                            //   size: 12,
                                            // ),
                                            InsiteRichText(
                                              content: services!.serviceName,
                                              onTap: () {
                                                // serviceName!.clear();

                                                widget.serviceCalBack!(
                                                    services.serviceId,
                                                    viewModel.assetDataValue!,
                                                    viewModel.services);
                                              },
                                              title: " ",
                                            ),
                                            InsiteButton(
                                              title: services
                                                  .dueInfo!.serviceStatus,
                                              padding: EdgeInsets.all(8),
                                              margin: EdgeInsets.all(8),
                                              bgColor: Utils.getFaultColor(
                                                  "fault.severityLabel"),
                                              height: 30,
                                              width: 40,
                                            ),
                                            InsiteTextWithPadding(
                                              padding: EdgeInsets.all(8),
                                              text: services.nextOccurrence!
                                                  .toStringAsFixed(0),
                                              size: 12,
                                            ),
                                            InsiteTextWithPadding(
                                              padding: EdgeInsets.all(8),
                                              text: services.dueInfo!.dueAt!
                                                  .toStringAsFixed(0),
                                              size: 12,
                                            ),
                                            InsiteTextWithPadding(
                                              padding: EdgeInsets.all(8),
                                              text: services.dueInfo!.dueBy!
                                                  .abs()
                                                  .toStringAsFixed(0),
                                              size: 12,
                                            ),
                                            InsiteTextWithPadding(
                                              padding: EdgeInsets.all(8),
                                              text: Utils
                                                  .getLastReportedDateOneUTC(
                                                      services
                                                          .dueInfo!.dueDate),
                                              size: 12,
                                            ),
                                            InsiteTextWithPadding(
                                              padding: EdgeInsets.all(8),
                                              text: services.serviceType,
                                              size: 12,
                                            ),
                                          ]);
                                        }),
                                      ),
                                      viewModel.loadingMore
                                          ? Padding(
                                              padding: EdgeInsets.all(8),
                                              child: InsiteProgressBar(),
                                            )
                                          : SizedBox(),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => MainViewModel(widget.summaryData),
    );
  }
}
