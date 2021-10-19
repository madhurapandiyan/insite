import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';

class ManageCardWidget extends StatelessWidget {
  //const ManageCardWidget({ Key? key }) : super(key: key);

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
                SizedBox(
                  height: 20,
                ),
                Icon(Icons.arrow_drop_down,
                    color: Theme.of(context).iconTheme.color),
                SizedBox(
                  height: 20,
                ),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: Icon(
                      Icons.crop_square,
                      color: Colors.black,
                    )),
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
                    content: "Aditya Construction ",
                  ),
                  InsiteTableRowItem(
                    title: 'Frequency:',
                    content: "Daily",
                  ),
                  InsiteTableRowItem(
                    title: 'Format :',
                    content: "XLSX",
                  ),
                ]),
                TableRow(children: [
                  InsiteTableRowItem(
                    title: 'Report Type :',
                    content: "Multi Asset" + "\n" + "Utilization",
                  ),
                  InsiteTableRowItem(
                    title: 'Recipients',
                    content: "1",
                  ),
                  InsiteTableRowItem(
                    title: 'Assets',
                    content: "2650",
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
                      content: "HMR Report",
                    ),
                    InsiteTableRowItem(
                      title: "Date & Time :",
                      content: "01/02/20 10:34",
                    ),
                    InsiteTableRowItem(
                      title: "End Date :",
                      content: "01/06/2021",
                    )
                  ])
                ],
              ),
              Table(
                border: TableBorder(
                  verticalInside: BorderSide(color: borderLineColor, width: 1),
                  left: BorderSide(color: borderLineColor, width: 1),
                  bottom: BorderSide(color: borderLineColor, width: 1),
                ),
                children: [
                  TableRow(children: [
                    InsiteTableRowItem(
                      title: 'Content:',
                      content:
                          "Dear Sir, Please find" + "\n" + "the progressive..",
                    ),
                    InsiteTableRowItem(
                      title: "Created by :",
                      content: "Shriram" + "\n" + "VishwaKarma",
                    ),
                    InsiteTableRowItem(
                      title: "",
                      content: "",
                    )
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
