import 'package:flutter/material.dart';
import 'package:insite/core/models/utilization.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';

class UtilizationListItem extends StatelessWidget {
  final AssetResult utilizationData;
  final bool isShowingInDetailPage;
  final VoidCallback onCallback;
  UtilizationListItem(
      {this.utilizationData, this.isShowingInDetailPage, this.onCallback});

  @override
  Widget build(BuildContext context) {
    return isShowingInDetailPage
        ? GestureDetector(
            onTap: () {
              onCallback();
            },
            child: Card(
              color: cardcolor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: cardcolor)),
              child: Row(
                children: [
                  Expanded(
                    child: InsiteExpansionTile(
                      title: Table(
                        border: TableBorder.symmetric(
                            outside: BorderSide.none,
                            inside: BorderSide(
                                style: BorderStyle.solid,
                                color: Color(0xFF000000),
                                width: 1)),
                        columnWidths: {
                          0: FlexColumnWidth(4),
                          1: FlexColumnWidth(3),
                          2: FlexColumnWidth(3),
                        },
                        children: [
                          TableRow(
                            children: [
                              InsiteTableRowIcon(
                                iconPath: "-",
                                title: "16/02/2021",
                              ),
                              InsiteTableRowItem(
                                title: "Last Reported Time ",
                                content:
                                    utilizationData.lastReportedTime != null
                                        ? Utils.getLastReportedDateOne(
                                            utilizationData.lastReportedTime)
                                        : "",
                              ),
                              InsiteTableRowItem(
                                title: "Runtime performance",
                                content: utilizationData
                                            .targetRuntimePerformance !=
                                        null
                                    ? utilizationData.targetRuntimePerformance
                                        .toString()
                                    : "-",
                              ),
                            ],
                          ),
                        ],
                      ),
                      tilePadding: EdgeInsets.all(0),
                      childrenPadding: EdgeInsets.all(0),
                      children: [
                        Table(
                          border: TableBorder(
                              bottom: BorderSide.none,
                              verticalInside: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Color(0xFF000000),
                                  width: 1),
                              top: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Color(0xFF000000),
                                  width: 1),
                              horizontalInside: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Color(0xFF000000),
                                  width: 1),
                              left: BorderSide.none,
                              right: BorderSide.none),
                          columnWidths: {
                            0: FlexColumnWidth(1),
                            1: FlexColumnWidth(3),
                          },
                          children: [
                            TableRow(
                              children: [
                                InsiteTableRowItem(
                                  title: "RunTime",
                                  content: "-",
                                ),
                                Table(
                                  border: TableBorder.all(),
                                  children: [
                                    TableRow(children: [
                                      InsiteTableRowItem(
                                        title: "Meter",
                                        content: utilizationData
                                                    .lastRuntimeHourMeter !=
                                                null
                                            ? utilizationData
                                                .lastRuntimeHourMeter
                                                .roundToDouble()
                                                .toString()
                                            : "",
                                      ),
                                      InsiteTableRowItem(
                                        title: "Daily",
                                        content: utilizationData.runtimeHours
                                            .toString(),
                                      ),
                                      InsiteTableRowItem(
                                        title: "Target",
                                        content: utilizationData.targetRuntime
                                            .toString(),
                                      ),
                                      InsiteTableRowItem(
                                        title: "Performance",
                                        content: utilizationData
                                                    .targetRuntimePerformance !=
                                                null
                                            ? (utilizationData
                                                        .targetRuntimePerformance /
                                                    100)
                                                .toString()
                                            : "",
                                      ),
                                    ]),
                                    TableRow(
                                      children: [
                                        InsiteTableRowItem(
                                          title: "Lifetime Fuel",
                                          content: "-",
                                        ),
                                        InsiteTableRowItem(
                                          title: "Fuel Burned",
                                          content: utilizationData.idleHours
                                              .toString(),
                                        ),
                                        InsiteTableRowItem(
                                          title: "Burned Rate",
                                          content: utilizationData.idleHours
                                              .toString(),
                                        ),
                                        InsiteTableRowItem(
                                          title: "",
                                          content: "",
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            TableRow(children: [
                              InsiteTableRowItem(
                                title: "Idle",
                                content: "-",
                              ),
                              Table(
                                border: TableBorder.all(),
                                children: [
                                  TableRow(
                                    children: [
                                      InsiteTableRowItem(
                                        title: "Meter",
                                        content: utilizationData
                                                    .lastIdleHourMeter !=
                                                null
                                            ? utilizationData.lastIdleHourMeter
                                                .roundToDouble()
                                                .toString()
                                            : "",
                                      ),
                                      InsiteTableRowItem(
                                        title: "Daily",
                                        content: utilizationData.idleHours
                                            .toString(),
                                      ),
                                      InsiteTableRowItem(
                                        title: "Target",
                                        content: utilizationData.targetIdle
                                            .toString(),
                                      ),
                                      InsiteTableRowItem(
                                        title: "Idle%",
                                        content: utilizationData
                                                    .targetIdlePerformance !=
                                                null
                                            ? (utilizationData
                                                        .targetIdlePerformance /
                                                    100)
                                                .toString()
                                            : "",
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ]),
                            TableRow(
                              children: [
                                InsiteTableRowItem(
                                  title: "Working",
                                  content: "-",
                                ),
                                InsiteTableRowItem(
                                  title: "Daily",
                                  content: "-",
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : GestureDetector(
            onTap: () {
              onCallback();
            },
            child: Card(
              color: cardcolor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: cardcolor)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        //         borderRadius:
                        //             BorderRadius.all(Radius.circular(4))),
                        //     child:
                        //         Icon(Icons.crop_square, color: Colors.black)),
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
                              InsiteTableRowWithImage(
                                title: utilizationData.manufacturer,
                                path: utilizationData == null
                                    ? "assets/images/EX210.png"
                                    : Utils().imageData(utilizationData.model),
                              ),
                              InsiteTableRowItem(
                                title: "Runime Hours",
                                content:
                                    utilizationData.runtimeHours.toString(),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              InsiteRichText(
                                title: "Serial No. ",
                                content: utilizationData.assetSerialNumber,
                              ),
                              InsiteTableRowItem(
                                title: "Working Time Hours",
                                content:
                                    utilizationData.workingHours.toString(),
                              ),
                            ],
                          ),
                        ],
                      ),
                      tilePadding: EdgeInsets.all(0),
                      children: [
                        Table(
                          border: TableBorder.all(),
                          columnWidths: {
                            0: FlexColumnWidth(6),
                            1: FlexColumnWidth(3),
                          },
                          children: [
                            TableRow(
                              children: [
                                InsiteTableRowItem(
                                  title: "Last Utiization Report",
                                  content: "-",
                                ),
                                InsiteTableRowItem(
                                  title: "Idle Hours",
                                  content: utilizationData.idleHours.toString(),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
