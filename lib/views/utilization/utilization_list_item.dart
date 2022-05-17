import 'package:flutter/material.dart';
import 'package:insite/core/models/utilization.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';
import 'package:logger/logger.dart';

class UtilizationListItem extends StatelessWidget {
  final AssetResult? utilizationData;
  final bool? isShowingInDetailPage;
  final VoidCallback? onCallback;
  UtilizationListItem(
      {this.utilizationData, this.isShowingInDetailPage, this.onCallback});

  @override
  Widget build(BuildContext context) {
    return isShowingInDetailPage!
        ? GestureDetector(
            onTap: () {
              onCallback!();
            },
            child: Card(
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
                              InsiteTableRowItemWithIcon(
                                iconPath: Utils().getImageWithAssetIconKey(
                                    utilizationData!.assetIcon),
                                title: utilizationData!.lastReportedTime != null
                                    ? Utils.getLastReportedDateTwo(
                                        utilizationData!.lastReportedTime)
                                    : "-",
                              ),
                              InsiteTableRowItem(
                                title: "Last Reported Time ",
                                content:
                                    utilizationData!.lastReportedTime != null
                                        ? Utils.getLastReportedDateOne(
                                            utilizationData!.lastReportedTime)
                                        : "-",
                              ),
                              InsiteTableRowItem(
                                title: "Runtime",
                                // content: utilizationData
                                //             .targetRuntimePerformance !=
                                //         null
                                //     ? (utilizationData
                                //                     .targetRuntimePerformance *
                                //                 100)
                                //             .toStringAsFixed(2) +
                                //         " %"
                                //     : "",
                                content: utilizationData!.runtimeHours != null
                                    ? utilizationData!.runtimeHours!
                                        .toStringAsFixed(1)
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
                                        title: "Meter (hr)",
                                        content: utilizationData!
                                                    .lastRuntimeHourMeter !=
                                                null
                                            ? utilizationData!
                                                .lastRuntimeHourMeter!
                                                .toStringAsFixed(1)
                                            : "-",
                                      ),
                                      InsiteTableRowItem(
                                        title: "Daily (hr)",
                                        content:
                                            utilizationData!.runtimeHours !=
                                                    null
                                                ? utilizationData!.runtimeHours!
                                                    .toStringAsFixed(1)
                                                : "-",
                                      ),
                                    ]),
                                    TableRow(children: [
                                      InsiteTableRowItem(
                                        title: "Target (hr)",
                                        content: utilizationData!
                                                    .targetRuntime !=
                                                null
                                            ? utilizationData!.targetRuntime!
                                                .toStringAsFixed(1)
                                            : "-",
                                      ),
                                      InsiteTableRowItem(
                                        title: "Performance",
                                        content: utilizationData!
                                                    .targetRuntimePerformance !=
                                                null
                                            ? (utilizationData!
                                                            .targetRuntimePerformance! *
                                                        100)
                                                    .toStringAsFixed(2) +
                                                " %"
                                            : "",
                                      ),
                                    ]),
                                    TableRow(
                                      children: [
                                        InsiteTableRowItem(
                                          title: "Lifetime Fuel (Litres)",
                                          content: "-",
                                        ),
                                        InsiteTableRowItem(
                                          title: "Fuel Burned (Litres)",
                                          content: utilizationData!
                                                      .runtimeFuelConsumedLiters !=
                                                  null
                                              ? utilizationData!
                                                  .runtimeFuelConsumedLiters!
                                                  .toStringAsFixed(1)
                                              : "-",
                                        ),
                                      ],
                                    ),
                                    TableRow(children: [
                                      InsiteTableRowItem(
                                        title: "Burn Rate (Litres/hr)",
                                        content: utilizationData!
                                                    .runtimeFuelConsumptionRate !=
                                                null
                                            ? utilizationData!
                                                .runtimeFuelConsumptionRate!
                                                .toStringAsFixed(2)
                                            : "-",
                                      ),
                                      InsiteTableRowItem(
                                        title: "",
                                        content: "",
                                      ),
                                    ])
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
                                        title: "Meter (hr)",
                                        content: utilizationData!
                                                    .lastIdleHourMeter !=
                                                null
                                            ? utilizationData!
                                                .lastIdleHourMeter!
                                                .toStringAsFixed(1)
                                            : "",
                                      ),
                                      InsiteTableRowItem(
                                        title: "Daily (hr)",
                                        content:
                                            utilizationData!.idleHours != null
                                                ? utilizationData!.idleHours!
                                                : "-",
                                      ),
                                    ],
                                  ),
                                  TableRow(children: [
                                    InsiteTableRowItem(
                                      title: "Target (hr)",
                                      content:
                                          utilizationData!.targetIdle != null
                                              ? utilizationData!.targetIdle!
                                                  .toStringAsFixed(1)
                                              : "-",
                                    ),
                                    InsiteTableRowItem(
                                      title: "Performance",
                                      content: utilizationData!
                                                  .targetIdlePerformance !=
                                              null
                                          ? (utilizationData!
                                                          .targetIdlePerformance! *
                                                      100)
                                                  .toStringAsFixed(2) +
                                              " %"
                                          : "-",
                                    ),
                                  ]),
                                  TableRow(
                                    children: [
                                      InsiteTableRowItem(
                                        title: "Lifetime Fuel (Litres)",
                                        content: utilizationData
                                                ?.lastIdleFuelConsumptionLitersMeter ??
                                            "-",
                                      ),
                                      InsiteTableRowItem(
                                        title: "Fuel Burned (Litres)",
                                        content: utilizationData!
                                                    .idleFuelConsumedLiters !=
                                                null
                                            ? utilizationData!
                                                .idleFuelConsumedLiters!
                                                .toStringAsFixed(1)
                                            : "-",
                                      ),
                                    ],
                                  ),
                                  TableRow(children: [
                                    InsiteTableRowItem(
                                      title: "Burn Rate (Litres/hr)",
                                      content: utilizationData!
                                                  .idleFuelConsumptionRate !=
                                              null
                                          ? utilizationData!
                                              .idleFuelConsumptionRate!
                                              .toStringAsFixed(2)
                                          : "-",
                                    ),
                                    InsiteTableRowItem(
                                      title: "",
                                      content: "",
                                    ),
                                  ])
                                ],
                              ),
                            ]),
                            TableRow(
                              children: [
                                InsiteTableRowItem(
                                  title: "Working",
                                  content: utilizationData!.workingHours != null
                                      ? utilizationData!.workingHours!
                                          .toStringAsFixed(1)
                                      : "-",
                                ),
                                InsiteTableRowItem(
                                  title: "Daily (hr)",
                                  content: utilizationData!.workingHours != null
                                      ? utilizationData!.workingHours!
                                          .toStringAsFixed(1)
                                      : "-",
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
              onCallback!();
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
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
                          //     child:
                          //         Icon(Icons.crop_square, color: Colors.black)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: InsiteExpansionTile(
                        title: Table(
                          border: TableBorder(
                              bottom: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Color(0xFF000000),
                                  width: 1),
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
                              left: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Color(0xFF000000),
                                  width: 1),
                              right: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Color(0xFF000000),
                                  width: 1)),
                          columnWidths: {
                            0: FlexColumnWidth(5),
                            1: FlexColumnWidth(3),
                          },
                          children: [
                            TableRow(
                              children: [
                                InsiteTableRowItemWithImage(
                                  title: utilizationData!.manufacturer != null
                                      ? utilizationData!.manufacturer
                                      : "" + "\n" + utilizationData!.model! !=
                                              null
                                          ? utilizationData!.model
                                          : "",
                                  path: utilizationData == null
                                      ? "assets/images/EX210.png"
                                      : Utils()
                                          .imageData(utilizationData!.model!),
                                ),
                                InsiteTableRowItem(
                                  title: "Runtime Hours",
                                  content: utilizationData?.runtimeHours
                                              .toString() ==
                                          "null"
                                      ? "-"
                                      : utilizationData?.runtimeHours
                                          .toString(),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                InsiteRichText(
                                  title: "Serial No. ",
                                  content: utilizationData!.assetSerialNumber,
                                  onTap: () {
                                    onCallback!();
                                  },
                                ),
                                InsiteTableRowItem(
                                  title: "Working Time Hours",
                                  content: utilizationData?.workingHours
                                              .toString() ==
                                          "null"
                                      ? "-"
                                      : utilizationData?.workingHours
                                          .toString(),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                InsiteTableRowItem(
                                  title: "Last Utiization Report",
                                  content:
                                      utilizationData!.lastReportedTime != null
                                          ? Utils.getLastReportedDateOne(
                                              utilizationData!.lastReportedTime)
                                          : '-',
                                ),
                                InsiteTableRowItem(
                                  title: "Idle Hours",
                                  content: utilizationData?.idleHours
                                              .toString() ==
                                          "null"
                                      ? "-"
                                      : utilizationData!.idleHours.toString(),
                                ),
                              ],
                            ),
                          ],
                        ),
                        tilePadding: EdgeInsets.all(0),
                        children: [
                          Column(
                            children: [
                              Table(
                                border: TableBorder(
                                    bottom: BorderSide(
                                        style: BorderStyle.solid,
                                        color: Color(0xFF000000),
                                        width: 1),
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
                                    left: BorderSide(
                                        style: BorderStyle.solid,
                                        color: Color(0xFF000000),
                                        width: 1),
                                    right: BorderSide(
                                        style: BorderStyle.solid,
                                        color: Color(0xFF000000),
                                        width: 1)),
                                columnWidths: {
                                  0: FlexColumnWidth(1),
                                  1: FlexColumnWidth(3),
                                },
                                children: [
                                  TableRow(
                                    children: [
                                      InsiteTableRowItem(
                                        title: "Runtime Target",
                                        content:
                                            utilizationData!.targetRuntime !=
                                                    null
                                                ? utilizationData!.targetRuntime
                                                    .toString()
                                                : "-",
                                      ),
                                      Table(
                                        border: TableBorder(
                                            bottom: BorderSide.none,
                                            top: BorderSide(
                                                style: BorderStyle.solid,
                                                color: Color(0xFF000000),
                                                width: 1),
                                            left: BorderSide(
                                                style: BorderStyle.solid,
                                                color: Color(0xFF000000),
                                                width: 1),
                                            right: BorderSide.none),
                                        children: [
                                          TableRow(children: [
                                            InsiteTableRowItem(
                                              title: "Daily (hr)",
                                              content: utilizationData!
                                                          .runtimeHours !=
                                                      null
                                                  ? utilizationData!
                                                      .runtimeHours
                                                      .toString()
                                                  : "-",
                                            ),
                                            // InsiteTableRowItem(
                                            //   title: "Target",
                                            //   content:
                                            //       utilizationData.targetRuntime !=
                                            //               null
                                            //           ? utilizationData.targetRuntime
                                            //               .toString()
                                            //           : "-",
                                            // ),
                                            InsiteTableRowItem(
                                              title: "Performance",
                                              content: utilizationData!
                                                          .targetRuntimePerformance !=
                                                      null
                                                  ? (utilizationData!
                                                                  .targetRuntimePerformance! *
                                                              100)
                                                          .toStringAsFixed(2) +
                                                      " %"
                                                  : "",
                                            ),
                                            InsiteTableRowItem(
                                              title: "Fuel Burned (Litres)",
                                              content: utilizationData!
                                                          .runtimeFuelConsumedLiters !=
                                                      null
                                                  ? utilizationData!
                                                      .runtimeFuelConsumedLiters!
                                                      .toStringAsFixed(1)
                                                  : "-",
                                            )
                                          ]),
                                        ],
                                      ),
                                    ],
                                  ),
                                  TableRow(children: [
                                    InsiteTableRowItem(
                                      title: "Idle Target",
                                      content:
                                          utilizationData!.targetIdle != null
                                              ? utilizationData!.targetIdle
                                                  .toString()
                                              : "-",
                                    ),
                                    Table(
                                      border: TableBorder(
                                          bottom: BorderSide.none,
                                          top: BorderSide(
                                              style: BorderStyle.solid,
                                              color: Color(0xFF000000),
                                              width: 1),
                                          left: BorderSide(
                                              style: BorderStyle.solid,
                                              color: Color(0xFF000000),
                                              width: 1),
                                          right: BorderSide.none),
                                      columnWidths: {
                                        0: FlexColumnWidth(1),
                                        1: FlexColumnWidth(3),
                                      },
                                      children: [
                                        TableRow(
                                          children: [
                                            InsiteTableRowItem(
                                              title: "Daily (hr)",
                                              content: utilizationData!
                                                          .idleHours !=
                                                      null
                                                  ? utilizationData!.idleHours
                                                      .toString()
                                                  : "-",
                                            ),
                                            InsiteTableRowItem(
                                              title: "Performance",
                                              content: utilizationData!
                                                          .targetIdlePerformance !=
                                                      null
                                                  ? (utilizationData!
                                                                  .targetIdlePerformance! *
                                                              100)
                                                          .toStringAsFixed(2) +
                                                      " %"
                                                  : "",
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ]),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          )
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
