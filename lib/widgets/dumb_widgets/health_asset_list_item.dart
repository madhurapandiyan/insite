import 'package:flutter/material.dart';
import 'package:insite/core/models/fault.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/detail/tabs/health/fault_list_item_view_model.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';
import 'package:stacked/stacked.dart';
import 'insite_button.dart';
import 'insite_row_item_text.dart';
import 'insite_text.dart';

class HealthAssetListItem extends StatefulWidget {
  final Fault fault;
  final VoidCallback onCallback;
  const HealthAssetListItem({this.fault, this.onCallback});

  @override
  _HealthAssetListItemState createState() => _HealthAssetListItemState();
}

class _HealthAssetListItemState extends State<HealthAssetListItem> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FaultListItemViewModel>.reactive(
      builder:
          (BuildContext context, FaultListItemViewModel viewModel, Widget _) {
        return GestureDetector(
          onTap: () {
            widget.onCallback();
          },
          child: Card(
            color: cardcolor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: cardcolor)),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Icon(Icons.arrow_drop_down, color: Colors.white),
                      SizedBox(
                        height: 20,
                      ),
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
                        0: FlexColumnWidth(3),
                        1: FlexColumnWidth(3),
                      },
                      children: [
                        TableRow(
                          children: [
                            InsiteTableRowItemWithImage(
                              title: "Asset ID :" + "\n" + "-",
                              path: widget.fault.asset["details"] != null &&
                                      widget.fault.asset["details"]["model"] !=
                                          null
                                  ? Utils().imageData(
                                      widget.fault.asset["details"]["model"])
                                  : "assets/images/EX210.png",
                            ),
                            Table(
                              border: TableBorder.all(),
                              columnWidths: {
                                0: FlexColumnWidth(3),
                                1: FlexColumnWidth(3),
                              },
                              children: [
                                TableRow(children: [
                                  InsiteTableRowItem(
                                    title: "Make :",
                                    content:
                                        widget.fault.asset["details"] != null &&
                                                widget.fault.asset["details"]
                                                        ["makeCode"] !=
                                                    null
                                            ? widget.fault.asset["details"]
                                                ["makeCode"]
                                            : "-",
                                  ),
                                  InsiteTableRowItem(
                                    title: "Model :",
                                    content: widget.fault.asset["details"] !=
                                                null &&
                                            widget.fault.asset["details"]
                                                    ["model"] !=
                                                null
                                        ? widget.fault.asset["details"]["model"]
                                        : "-",
                                  ),
                                ])
                              ],
                            )
                          ],
                        ),
                        TableRow(children: [
                          InsiteRichText(
                            title: "Serial No. : ",
                            content: widget.fault.asset["basic"] != null &&
                                    widget.fault.asset["basic"]
                                            ["serialNumber"] !=
                                        null
                                ? widget.fault.asset["basic"]["serialNumber"]
                                : "",
                            onTap: () {
                              widget.onCallback();
                            },
                          ),
                          InsiteTableRowItemWithMultipleButton(
                              title: "Fault Total",
                              texts: widget.fault.countData != null
                                  ? widget.fault.countData
                                  : []),
                        ]),
                      ],
                    ),
                    onExpansionChanged: (value) {
                      viewModel.onExpanded();
                    },
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
                              content: widget.fault.asset != null &&
                                      widget.fault.asset["dynamic"] != null
                                  ? Utils.getLastReportedDateOne(
                                      widget.fault.asset["dynamic"]
                                          ["locationReportedTimeUTC"])
                                  : "-",
                            ),
                            InsiteTableRowItem(
                              title: "Location : ",
                              content: widget.fault.asset != null &&
                                      widget.fault.asset["dynamic"] != null
                                  ? (widget.fault.asset["dynamic"]["location"])
                                  : "-",
                            ),
                          ]),
                          TableRow(children: [
                            InsiteTableRowItem(
                              title: "Current Hour Meter : ",
                              content: widget.fault.asset != null &&
                                      widget.fault.asset["dynamic"] != null
                                  ? (widget.fault.asset["dynamic"]["hourMeter"]
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
                              child: CircularProgressIndicator(),
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
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                  InsiteTextWithPadding(
                                    padding: EdgeInsets.all(8),
                                    text: "Severity",
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                  InsiteTextWithPadding(
                                    padding: EdgeInsets.all(8),
                                    text: "Source",
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                  InsiteTextWithPadding(
                                    padding: EdgeInsets.all(8),
                                    text: "Description",
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ]),
                              ],
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
                              children: List.generate(viewModel.faults.length,
                                  (index) {
                                Fault fault = viewModel.faults[index];
                                return TableRow(children: [
                                  InsiteTextWithPadding(
                                    padding: EdgeInsets.all(8),
                                    text: Utils.getLastReportedDateOne(
                                        fault.faultOccuredUTC),
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                  InsiteButton(
                                    title: fault.severityLabel,
                                    padding: EdgeInsets.all(8),
                                    margin: EdgeInsets.all(8),
                                    bgColor: buttonColorFive,
                                    height: 30,
                                    width: 40,
                                  ),
                                  InsiteTextWithPadding(
                                    padding: EdgeInsets.all(8),
                                    text: fault.source,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                  InsiteTextWithPadding(
                                    padding: EdgeInsets.all(8),
                                    text: fault.description,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ]);
                              }),
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
