import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';

class CustomCardReportSummaryWidget extends StatelessWidget {
  final String deviceId;
  final String serialNo;
  final String name;
  final String mobileNo;
  final String language;
  final String date;
  final bool isSelected;
  final Function onSelected;
  //final bool isExpanded;
  CustomCardReportSummaryWidget(
      {this.deviceId,
      this.serialNo,
      this.name,
      this.date,
      this.isSelected,
      this.onSelected,
      this.language,
      this.mobileNo});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        // height: MediaQuery.of(context).size.height * 0.25,
        // width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Icon(Icons.keyboard_arrow_down),
                IconButton(
                    onPressed: () {
                      onSelected();
                    },
                    icon: Container(
                      color: isSelected ? Theme.of(context).buttonColor : null,
                      child: Icon(
                        Icons.check_box_outline_blank,
                      ),
                    ))
              ],
            ),
            Expanded(
              child: InsiteExpansionTile(
                childrenPadding:
                    EdgeInsets.only(right: 15, left: 15, bottom: 15),
                children: [
                  Table(
                    border: TableBorder.all(width: 2, color: borderLineColor),
                    children: [
                      TableRow(children: [
                        InsiteTableRowItem(
                          title: "Language",
                          content: language,
                        ),
                        InsiteTableRowItem(
                          title: "Scheduled SMS Start Date",
                          content: Utils.getLastReportedDateFilterData(
                              DateTime.parse(date)),
                        )
                      ])
                    ],
                  )
                ],
                title: Table(
                  border: TableBorder.all(width: 2, color: borderLineColor),
                  columnWidths: {0: FlexColumnWidth(2), 1: FlexColumnWidth(2)},
                  children: [
                    TableRow(children: [
                      InsiteTableRowItem(
                        title: "Device ID :",
                        content: deviceId,
                      ),
                      InsiteTableRowItem(
                        title: "Recipient’s Name :",
                        content: name,
                      ),
                    ]),
                    TableRow(children: [
                      InsiteTableRowItem(
                        title: "Serial No. :",
                        content: serialNo,
                      ),
                      InsiteTableRowItem(
                        title: "Mobile Number : ",
                        content: mobileNo,
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
