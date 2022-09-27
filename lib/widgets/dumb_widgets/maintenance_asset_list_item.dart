import 'package:flutter/material.dart';
import 'package:insite/core/models/fault.dart';
import 'package:insite/core/models/maintenance_asset.dart';
import 'package:insite/core/models/maintenance_asset_india_stack.dart';
import 'package:insite/core/models/maintenance_list_services.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/detail/maintenance_detail_view_model.dart';
import 'package:insite/views/detail/tabs/health/fault_list_item_view_model.dart';
import 'package:insite/views/maintenance/asset/asset_view_model.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'insite_button.dart';
import 'insite_row_item_text.dart';
import 'insite_text.dart';

class MaintenanceAssetListItem extends StatefulWidget {
  final AssetCentricData? assetData;
  final VoidCallback? onCallback;

  final Function(
          num? value, AssetData? assetDataValue, List<Services?>? serviceNames)?
      serviceCalBack;

  final Key? key;
  const MaintenanceAssetListItem(
      {this.assetData, this.key, this.onCallback, this.serviceCalBack})
      : super(key: key);

  @override
  _MaintenanceAssetListItemState createState() =>
      _MaintenanceAssetListItemState();
}

class _MaintenanceAssetListItemState extends State<MaintenanceAssetListItem> {
  int overdue = 0;
  int upcoming = 0;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MaintenanceItemDetailViewModel>.reactive(
      builder: (BuildContext context, MaintenanceItemDetailViewModel viewModel,
          Widget? _) {
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
                      // childrenPadding: EdgeInsets.all(0),
                      title: Column(
                        children: [
                          Table(
                            border: TableBorder.all(),
                            columnWidths: {
                              0: FlexColumnWidth(1.8),
                              1: FlexColumnWidth(1),
                            },
                            children: [
                              TableRow(
                                children: [
                                  InsiteTableRowItemWithImage(
                                    title: widget.assetData!.model,
                                    // "${widget.assetData!.assetUID == null ? "-" : widget.assetData!.assetUID}",
                                    path: widget.assetData!.model != null
                                        ? Utils().getImageWithAssetIconKey(
                                            model: widget.assetData!.model,
                                            assetIconKey:
                                                widget.assetData!.assetIcon)
                                        : "assets/images/EX210.png",
                                  ),
                                  // InsiteTableRowItem(
                                  //   title: "Product Family :",
                                  //   content: widget.assetData!.model,
                                  // )
                                ],
                              ),
                            ],
                          ),
                          Table(
                            border: TableBorder.all(),
                            columnWidths: {
                              0: FlexColumnWidth(1),
                              1: FlexColumnWidth(1),
                            },
                            children: [
                              TableRow(children: [
                                InsiteRichText(
                                  title: "Serial No. : ",
                                  content: widget.assetData!.assetSerialNumber,
                                  onTap: () {
                                    widget.onCallback!();
                                  },
                                ),
                                InsiteTableRowItem(
                                  title: "Current Hour Meter : ",
                                  content: widget.assetData!.currentHourMeter!
                                      .toStringAsFixed(1),
                                ),
                              ]),
                            ],
                          ),
                          Table(
                            columnWidths: {
                              0: FlexColumnWidth(3),
                              1: FlexColumnWidth(3),
                            },
                            border: TableBorder.all(),
                            children: [
                              TableRow(children: [
                                // InsiteTableRowItem(
                                //   title: "Current Hour Meter : ",
                                //   content: widget.assetData!.currentHourMeter!
                                //       .toStringAsFixed(0),
                                // ),
                                InsiteTableRowItem(
                                  title: "Device Id :",
                                  content: widget.assetData!.deviceSerialNumber,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // InsiteTableRowItemWithButton(
                                      //   title: "Maintenance Totals: ",
                                      //   buttonColor: Utils.getMaintenanceColor(
                                      //       widget
                                      //           .assetData!.dueInfo!.serviceStatus),
                                      //   content: widget.assetData!.dueInfo != null
                                      //       ? Utils.getFaultLabel(widget
                                      //           .assetData!.overDueCount
                                      //           .toString())
                                      //       : "",
                                      // ),
                                      InsiteText(
                                        text: "Maintenance Totals: ",
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InsiteButton(
                                            title: Utils.getMaintenanceCount(widget
                                                            .assetData!
                                                            .maintenanceTotals)
                                                        .first
                                                        .count ==
                                                    0
                                                ? "-"
                                                : Utils.getMaintenanceCount(widget
                                                        .assetData!
                                                        .maintenanceTotals)
                                                    .first
                                                    .count
                                                    .toString(),

                                            bgColor: Colors.yellow.shade400,
                                            width: 50,
                                            //height: 20,
                                            //textColor: Colors.white,
                                          ),
                                          InsiteButton(
                                            title: Utils.getMaintenanceCount(widget
                                                            .assetData!
                                                            .maintenanceTotals)
                                                        .last
                                                        .count ==
                                                    0
                                                ? "-"
                                                : Utils.getMaintenanceCount(widget
                                                        .assetData!
                                                        .maintenanceTotals)
                                                    .last
                                                    .count
                                                    .toString(),
                                            bgColor: Colors.red.shade400,
                                            width: 50,
                                            // height: 20,
                                            //textColor: Colors.white,
                                          )
                                        ],
                                      ),

                                      // InsiteText(
                                      //   text: widget.assetData!.upcomingCount
                                      //       .toString(),
                                      // )
                                    ],
                                  ),
                                ),
                              ]),
                            ],
                          ),
                        ],
                      ),

                      onExpansionChanged: (value) {
                        //viewModel.onExpanded();
                      },
                      initiallyExpanded: false,
                      tilePadding: EdgeInsets.all(0),
                      // children: [
                      //   Table(
                      //     columnWidths: {
                      //       0: FlexColumnWidth(3),
                      //       1: FlexColumnWidth(3),
                      //     },
                      //     border: TableBorder.all(),
                      //     children: [
                      //       TableRow(children: [
                      //         InsiteTableRowItem(
                      //           title: "Current Hour Meter : ",
                      //           content: widget.assetData!.currentHourMeter!
                      //               .toStringAsFixed(0),
                      //         ),
                      //       ]),
                      //     ],
                      //   ),
                      //   viewModel.refreshing
                      //       ? Padding(
                      //           padding: const EdgeInsets.all(8.0),
                      //           child: InsiteProgressBar(),
                      //         )
                      //       : SizedBox(),
                      //   viewModel.services.isNotEmpty
                      //       ? Table(
                      //           columnWidths: {
                      //             0: FlexColumnWidth(1),
                      //             1: FlexColumnWidth(1),
                      //             2: FlexColumnWidth(1),
                      //             3: FlexColumnWidth(1),
                      //             4: FlexColumnWidth(1),
                      //             5: FlexColumnWidth(1),
                      //           },
                      //           border: TableBorder.all(),
                      //           children: [
                      //             TableRow(children: [
                      //               InsiteTextWithPadding(
                      //                 padding: EdgeInsets.all(8),
                      //                 text: "Service",
                      //                 size: 12,
                      //               ),
                      //               InsiteTextWithPadding(
                      //                 padding: EdgeInsets.all(8),
                      //                 text: "Service Status",
                      //                 size: 12,
                      //               ),
                      //               InsiteTextWithPadding(
                      //                 padding: EdgeInsets.all(8),
                      //                 text: "Service Interval",
                      //                 size: 12,
                      //               ),
                      //               InsiteTextWithPadding(
                      //                 padding: EdgeInsets.all(8),
                      //                 text: "Due At",
                      //                 size: 12,
                      //               ),
                      //               InsiteTextWithPadding(
                      //                 padding: EdgeInsets.all(8),
                      //                 text: "Due In/ Overdue By",
                      //                 size: 12,
                      //               ),
                      //               InsiteTextWithPadding(
                      //                 padding: EdgeInsets.all(8),
                      //                 text: "Due Date",
                      //                 size: 12,
                      //               ),
                      //               InsiteTextWithPadding(
                      //                 padding: EdgeInsets.all(8),
                      //                 text: "Service Type",
                      //                 size: 12,
                      //               ),
                      //             ]),
                      //           ],
                      //         )
                      //       : SizedBox(),
                      //   viewModel.services.isNotEmpty
                      //       ? Container(
                      //           height: 200,
                      //           child: Scrollbar(
                      //             isAlwaysShown: true,
                      //             child: SingleChildScrollView(
                      //               controller: viewModel.scrollController,
                      //               child: Column(
                      //                 children: [
                      //                   Table(
                      //                     columnWidths: {
                      //                       0: FlexColumnWidth(1),
                      //                       1: FlexColumnWidth(2),
                      //                       2: FlexColumnWidth(1),
                      //                       3: FlexColumnWidth(1),
                      //                       4: FlexColumnWidth(1),
                      //                       5: FlexColumnWidth(1),
                      //                     },
                      //                     border: TableBorder.all(),
                      //                     children: List.generate(
                      //                         viewModel.services.length, (index) {
                      //                       Services? services =
                      //                           viewModel.services[index];
                      //                       return TableRow(children: [
                      //                         // InsiteTextWithPadding(
                      //                         //   padding: EdgeInsets.all(8),
                      //                         //   text: services!.serviceName,
                      //                         //   size: 12,
                      //                         // ),
                      //                         InsiteRichText(
                      //                           content: services!.serviceName,
                      //                           onTap: () {
                      //                             // serviceName!.clear();

                      //                             widget.serviceCalBack!(
                      //                                 services.serviceId,
                      //                                 viewModel.assetDataValue!,
                      //                                 viewModel.services);
                      //                           },
                      //                           title: " ",
                      //                         ),
                      //                         InsiteButton(
                      //                           title: services
                      //                               .dueInfo!.serviceStatus,
                      //                           padding: EdgeInsets.all(8),
                      //                           margin: EdgeInsets.all(8),
                      //                           bgColor: Utils.getFaultColor(
                      //                               "fault.severityLabel"),
                      //                           height: 30,
                      //                           width: 40,
                      //                         ),
                      //                         InsiteTextWithPadding(
                      //                           padding: EdgeInsets.all(8),
                      //                           text: services.nextOccurrence!
                      //                               .toStringAsFixed(0),
                      //                           size: 12,
                      //                         ),
                      //                         InsiteTextWithPadding(
                      //                           padding: EdgeInsets.all(8),
                      //                           text: services.dueInfo!.dueAt!
                      //                               .toStringAsFixed(0),
                      //                           size: 12,
                      //                         ),
                      //                         InsiteTextWithPadding(
                      //                           padding: EdgeInsets.all(8),
                      //                           text: services.dueInfo!.dueBy!
                      //                               .abs()
                      //                               .toStringAsFixed(0),
                      //                           size: 12,
                      //                         ),
                      //                         InsiteTextWithPadding(
                      //                           padding: EdgeInsets.all(8),
                      //                           text: Utils
                      //                               .getLastReportedDateOneUTC(
                      //                                   services
                      //                                       .dueInfo!.dueDate),
                      //                           size: 12,
                      //                         ),
                      //                         InsiteTextWithPadding(
                      //                           padding: EdgeInsets.all(8),
                      //                           text: services.serviceType,
                      //                           size: 12,
                      //                         ),
                      //                       ]);
                      //                     }),
                      //                   ),
                      //                   viewModel.loadingMore
                      //                       ? Padding(
                      //                           padding: EdgeInsets.all(8),
                      //                           child: InsiteProgressBar(),
                      //                         )
                      //                       : SizedBox(),
                      //                 ],
                      //               ),
                      //             ),
                      //           ),
                      //         )
                      //       : SizedBox(),
                      // ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => MaintenanceItemDetailViewModel(widget.assetData),
    );
  }
}

class MaitenanceTotal {
  int? count;
  MAINTENANCETOTAL? total;
  MaitenanceTotal({this.count, this.total});
}
