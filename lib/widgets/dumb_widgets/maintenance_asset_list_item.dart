import 'package:flutter/material.dart';
import 'package:insite/core/models/fault.dart';
import 'package:insite/core/models/maintenance_asset.dart';
import 'package:insite/core/models/maintenance_list_services.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/detail/maintenance_detail_view_model.dart';
import 'package:insite/views/detail/tabs/health/fault_list_item_view_model.dart';
import 'package:insite/views/maintenance/asset/asset_view_model.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';
import 'package:stacked/stacked.dart';
import 'insite_button.dart';
import 'insite_row_item_text.dart';
import 'insite_text.dart';

class MaintenanceAssetListItem extends StatefulWidget {
  final AssetCentricData? assetData;
  final VoidCallback? onCallback;
  final Key? key;
  const MaintenanceAssetListItem({this.assetData, this.key, this.onCallback})
      : super(key: key);

  @override
  _MaintenanceAssetListItemState createState() =>
      _MaintenanceAssetListItemState();
}

class _MaintenanceAssetListItemState extends State<MaintenanceAssetListItem> {
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
                      //         borderRadius:
                      //             BorderRadius.all(Radius.circular(4))),
                      //     child: Icon(Icons.crop_square, color: Colors.black)),
                    ],
                  ),
                ),
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
                                  title: Utils.getMakeTitle(
                                      "Asset ID" + "\n" + "-"),
                                  path: "assets/images/EX210.png",
                                ),
                                InsiteTableRowItem(
                                  title: "Make :",
                                  content: widget.assetData!.makeCode,
                                ),
                                InsiteTableRowItem(
                                  title: "Model :",
                                  content: widget.assetData!.model,
                                )
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InsiteTableRowItemWithButton(
                                    title: "Maintenance Totals: ",
                                    buttonColor: Utils.getFaultColor(widget
                                        .assetData!.dueInfo!.serviceStatus),
                                    content: widget.assetData!.dueInfo != null
                                        ? Utils.getFaultLabel(widget
                                            .assetData!.overDueCount
                                            .toString())
                                        : "",
                                  ),
                                  // InsiteButton(
                                  //   title: Utils.getFaultLabel(widget
                                  //       .assetData!.upcomingCount
                                  //       .toString()),
                                  //   bgColor: Colors.black,
                                  //   width: 20,
                                  //   height: 20,
                                  //   textColor: Colors.white,
                                  // )
                                  InsiteText(
                                    text: widget.assetData!.upcomingCount
                                        .toString(),
                                  )
                                ],
                              ),
                            ]),
                          ],
                        ),
                      ],
                    ),

                    onExpansionChanged: (value) {
                      viewModel.onExpanded();
                    },
                    initiallyExpanded: false,
                    tilePadding: EdgeInsets.all(0),
                    children: [
                      Table(
                        columnWidths: {
                          0: FlexColumnWidth(3),
                          1: FlexColumnWidth(3),
                        },
                        border: TableBorder.all(),
                        children: [
                          TableRow(children: [
                            InsiteTableRowItem(
                              title: "Current Hour Meter : ",
                              content: widget.assetData!.currentHourMeter!
                                  .toStringAsFixed(0),
                            ),
                          ]),
                        ],
                      ),
                      viewModel.refreshing
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InsiteProgressBar(),
                            )
                          : SizedBox(),
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
                                            InsiteTextWithPadding(
                                              padding: EdgeInsets.all(8),
                                              text: services!.serviceName,
                                              size: 12,
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
      viewModelBuilder: () => MaintenanceItemDetailViewModel(widget.assetData),
    );
  }
}
