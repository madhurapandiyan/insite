import 'package:flutter/material.dart';
import 'package:insite/core/models/fault.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/detail/tabs/health/fault_list_item_view_model.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';
import 'package:stacked/stacked.dart';
import 'insite_button.dart';
import 'insite_row_item_text.dart';
import 'insite_text.dart';

class HealthAssetListItem extends StatefulWidget {
  final Fault? fault;
  final VoidCallback? onCallback;
  final Key? key;
  const HealthAssetListItem({this.key, this.fault, this.onCallback})
      : super(key: key);

  @override
  _HealthAssetListItemState createState() => _HealthAssetListItemState();
}

class _HealthAssetListItemState extends State<HealthAssetListItem> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FaultListItemViewModel>.reactive(
      builder:
          (BuildContext context, FaultListItemViewModel viewModel, Widget? _) {
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
                    // childrenPadding: EdgeInsets.all(0),
                    title: Table(
                      border: TableBorder.all(),
                      columnWidths: {
                        0: FlexColumnWidth(3),
                        1: FlexColumnWidth(3),
                      },
                      children: [
                        TableRow(
                          children: [
                            InsiteTableRowItemWithImage(
                              title: Utils.getMakeTitle(widget
                                      .fault!.asset["details"]["makeCode"]) +
                                  "\n" +
                                  widget.fault!.asset["details"]["model"],
                              path: widget.fault!.asset["details"] != null &&
                                      widget.fault!.asset["details"]["model"] !=
                                          null
                                  ? Utils().imageData(
                                      widget.fault!.asset["details"]["model"])
                                  : "assets/images/EX210.png",
                            ),
                            InsiteTableRowItem(
                              title: "Date/Time",
                              content: widget.fault!.asset != null &&
                                      widget.fault!.asset["dynamic"] != null
                                  ? Utils.getLastReportedDateOneUTC(
                                      widget.fault!.asset["dynamic"]
                                          ["locationReportedTimeUTC"])
                                  : "-",
                            )
                          ],
                        ),
                        TableRow(children: [
                          InsiteRichText(
                            title: "Serial No. : ",
                            content: widget.fault!.asset["basic"] != null &&
                                    widget.fault!.asset["basic"]
                                            ["serialNumber"] !=
                                        null
                                ? widget.fault!.asset["basic"]["serialNumber"]
                                : "",
                            onTap: () {
                              widget.onCallback!();
                            },
                          ),
                          InsiteTableRowItemWithMultipleButton(
                              title: "Fault Total",
                              texts: widget.fault!.countData != null
                                  ? widget.fault!.countData
                                  : []),
                        ]),
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
                              title: "Last Reported Time : ",
                              content: widget.fault!.asset != null &&
                                      widget.fault!.asset["dynamic"] != null
                                  ? Utils.getLastReportedDateOneUTC(
                                      widget.fault!.asset["dynamic"]
                                          ["locationReportedTimeUTC"])
                                  : "-",
                            ),
                            InsiteTableRowItem(
                              title: "Location : ",
                              content: widget.fault!.asset != null &&
                                      widget.fault!.asset["dynamic"] != null
                                  ? (widget.fault!.asset["dynamic"]["location"])
                                  : "-",
                            ),
                          ]),
                          TableRow(children: [
                            InsiteTableRowItem(
                              title: "Current Hour Meter : ",
                              content: widget.fault!.asset != null &&
                                      widget.fault!.asset["dynamic"] != null
                                  ? (widget.fault!.asset["dynamic"]["hourMeter"]
                                      .toString())
                                  : "-",
                            ),
                            InsiteTableRowItem(
                              title: "",
                              content: "",
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
                      viewModel.faults.isNotEmpty
                          ? Table(
                              columnWidths: {
                                0: FlexColumnWidth(1),
                                1: FlexColumnWidth(1),
                                2: FlexColumnWidth(1),
                                3: FlexColumnWidth(1),
                              },
                              border: TableBorder.all(),
                              children: [
                                TableRow(children: [
                                  InsiteTextWithPadding(
                                    padding: EdgeInsets.all(8),
                                    text: "Date / time",
                                    size: 12,
                                  ),
                                  InsiteTextWithPadding(
                                    padding: EdgeInsets.all(8),
                                    text: "Severity",
                                    size: 12,
                                  ),
                                  InsiteTextWithPadding(
                                    padding: EdgeInsets.all(8),
                                    text: "Source",
                                    size: 12,
                                  ),
                                  InsiteTextWithPadding(
                                    padding: EdgeInsets.all(8),
                                    text: "Description",
                                    size: 12,
                                  ),
                                ]),
                              ],
                            )
                          : SizedBox(),
                      viewModel.faults.isNotEmpty
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
                                          1: FlexColumnWidth(1),
                                          2: FlexColumnWidth(1),
                                          3: FlexColumnWidth(1),
                                        },
                                        border: TableBorder.all(),
                                        children: List.generate(
                                            viewModel.faults.length, (index) {
                                          Fault fault = viewModel.faults[index];
                                          return TableRow(children: [
                                            InsiteTextWithPadding(
                                              padding: EdgeInsets.all(8),
                                              text: Utils
                                                  .getLastReportedDateOneUTC(
                                                      fault.faultOccuredUTC),
                                              size: 12,
                                            ),
                                            InsiteButton(
                                              title: fault.severityLabel,
                                              padding: EdgeInsets.all(8),
                                              margin: EdgeInsets.all(8),
                                              bgColor: Utils.getFaultColor(
                                                  fault.severityLabel),
                                              height: 30,
                                              width: 40,
                                            ),
                                            InsiteTextWithPadding(
                                              padding: EdgeInsets.all(8),
                                              text: fault.source,
                                              size: 12,
                                            ),
                                            InsiteTextWithPadding(
                                              padding: EdgeInsets.all(8),
                                              text: fault.description,
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
      viewModelBuilder: () => FaultListItemViewModel(widget.fault),
    );
  }
}
