import 'package:flutter/material.dart';
import 'package:insite/core/models/manage_report_response.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';
import 'package:logger/logger.dart';

class ManageReportCardWidget extends StatelessWidget {
  final ScheduledReportsRow? scheduledReportsRow;
  final VoidCallback? voidCallback;

  ManageReportCardWidget({this.scheduledReportsRow, this.voidCallback});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // SizedBox(
                //   height: 20,
                // ),
                // Icon(Icons.arrow_drop_down,
                //     color: Theme.of(context).iconTheme.color),
                // SizedBox(
                //   height: 20,
                // ),
                GestureDetector(
                  onTap: () {
                    voidCallback!();
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: scheduledReportsRow!.isSelected!
                              ? Theme.of(context).buttonColor
                              : Theme.of(context).backgroundColor,
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: Icon(
                        Icons.crop_square,
                        color: scheduledReportsRow!.isSelected!
                            ? Theme.of(context).buttonColor
                            : Colors.black,
                      )),
                ),
              ],
            ),
          ),
          Expanded(
              child: InsiteExpansionTile(
            title: Table(
              border: TableBorder.all(width: 1, color: borderLineColor),
              columnWidths: {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1)
              },
              children: [
                TableRow(children: [
                  InsiteTableRowItem(
                    title: 'Report Name :',
                    content:
                        scheduledReportsRow!.scheduledReports!.reportTitle !=
                                null
                            ? scheduledReportsRow!.scheduledReports!.reportTitle
                            : "-",
                  ),
                  InsiteTableRowItem(
                      title: 'Frequency:',
                      content:
                          scheduledReportsRow!.scheduledReports!.reportPeriod !=
                                  null
                              ? scheduledReportsRow!
                                          .scheduledReports!.reportPeriod ==
                                      1
                                  ? "Daily"
                                  : scheduledReportsRow!
                                              .scheduledReports!.reportPeriod ==
                                          2
                                      ? "Weekly"
                                      : scheduledReportsRow!.scheduledReports!
                                                  .reportPeriod ==
                                              3
                                          ? "Monthly"
                                          : "-"
                              : "-"),
                  InsiteTableRowItem(
                      title: 'Format :',
                      content:
                          scheduledReportsRow!.scheduledReports!.reportFormat !=
                                  null
                              ? scheduledReportsRow!
                                          .scheduledReports!.reportFormat ==
                                      1
                                  ? "CSV"
                                  : scheduledReportsRow!
                                              .scheduledReports!.reportFormat ==
                                          2
                                      ? "XLSX"
                                      : scheduledReportsRow!.scheduledReports!
                                                  .reportFormat ==
                                              3
                                          ? "PDF"
                                          : "XLS"
                              : "-"),
                ]),
                TableRow(children: [
                  InsiteTableRowItem(
                    title: 'Report Type :',
                    content:
                        scheduledReportsRow!.scheduledReports!.reportType !=
                                null
                            ? scheduledReportsRow!.scheduledReports!.reportType
                            : "-",
                  ),
                  InsiteTableRowItem(
                      title: 'Recipients',
                      content: scheduledReportsRow!
                                  .scheduledReports!.emailRecipients !=
                              null
                          ? scheduledReportsRow!
                              .scheduledReports!.emailRecipients!.length
                              .toString()
                          : "-"),
                  InsiteTableRowItem(
                    title: 'Assets',
                    content: scheduledReportsRow!.scheduledReports!.assets !=
                            null
                        ? scheduledReportsRow!.scheduledReports!.assets!.length
                            .toString()
                        : "-",
                  ),
                ])
              ],
            ),
            tilePadding: EdgeInsets.all(0),
            childrenPadding: EdgeInsets.all(0),
            children: [
              Table(
                border: TableBorder(
                  verticalInside: BorderSide(color: borderLineColor, width: 1),
                  left: BorderSide(color: borderLineColor, width: 1),
                  bottom: BorderSide(color: borderLineColor, width: 1),
                ),
                children: [
                  TableRow(children: [
                    InsiteTableRowItem(
                      title: 'Subject:',
                      content: scheduledReportsRow!.scheduledReports!.assets !=
                              null
                          ? scheduledReportsRow!.scheduledReports!.emailSubject
                          : "-",
                    ),
                    InsiteTableRowItem(
                      title: "Date & Time :",
                      content: scheduledReportsRow!
                                  .scheduledReports!.reportCreationDate !=
                              null
                          ? Utils.getDateInFormatReportCardDate(
                              scheduledReportsRow!
                                  .scheduledReports!.reportCreationDate)
                          : "-",
                    ),
                    InsiteTableRowItem(
                      title: "End Date :",
                      content: scheduledReportsRow!
                                  .scheduledReports!.scheduleEndDate !=
                              null
                          ? Utils.getDateInFormatddMMyyyy(scheduledReportsRow!
                              .scheduledReports!.scheduleEndDate)
                          : "-",
                    )
                  ])
                ],
              ),
              Table(
                  columnWidths: {0: FlexColumnWidth(20)},
                border: TableBorder(
                 // verticalInside: BorderSide(color: borderLineColor, width: 1),
                  left: BorderSide(color: borderLineColor, width: 1),
                  bottom: BorderSide(color: borderLineColor, width: 1),
                ),
                children: [
                  TableRow(children: [
                    InsiteTableRowItem(
                      title: "Created by :",
                      content:
                          scheduledReportsRow!.scheduledReports!.createdBy !=
                                  null
                              ? scheduledReportsRow!.scheduledReports!.createdBy
                              : "-",
                    ),
                    SizedBox(),
                    SizedBox()
                  ])
                ],
              ),
              Table(
                columnWidths: {0: FlexColumnWidth(20)},
                border: TableBorder(
                  // verticalInside: BorderSide(color: borderLineColor, width: 1),
                  left: BorderSide(color: borderLineColor, width: 1),
                  //bottom: BorderSide(color: borderLineColor, width: 1),
                ),
                children: [
                  TableRow(children: [
                    InsiteTableRowItem(
                      title: 'Content:',
                      content: scheduledReportsRow!
                                  .scheduledReports!.emailContent !=
                              null
                          ? scheduledReportsRow!.scheduledReports!.emailContent!
                          : "-",
                    ),
                    SizedBox(),
                    SizedBox()
                  ])
                ],
              ),
            ],
          ))
        ],
      ),
    );
  }
}
