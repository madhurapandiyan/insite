import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';

class ManageUserCardWidget extends StatelessWidget {
  //const ManageUserCardWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
              border: TableBorder.all(width: 2, color: borderLineColor),
              columnWidths: {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1)
              },
              children: [
                TableRow(children: [
                  InsiteTableRowItem(
                    title: 'Name :',
                    content: "SudhaKar Rao",
                  ),
                  InsiteTableRowItem(
                    title: 'User Type:',
                    content: "regular",
                  ),
                  InsiteTableRowItem(
                    title: 'Job Type :',
                    content: "Employee",
                  ),
                ]),
                TableRow(children: [
                  InsiteTableRowItem(
                    title: 'Email ID :',
                    content: "sudhakar.rao @ tatahitachi.co .in",
                  ),
                  InsiteTableRowItem(
                    title: 'Job Title:',
                    content: "Equipment Management",
                  ),
                  Column()
                ])
              ],
            ),
            tilePadding: EdgeInsets.all(0),
            childrenPadding: EdgeInsets.all(0),
            children: [
              Table(
                border: TableBorder(
                  verticalInside: BorderSide(color: borderLineColor, width: 2),
                  left: BorderSide(color: borderLineColor, width: 2),
                  bottom: BorderSide(color: borderLineColor, width: 2),
                ),
                children: [
                  TableRow(children: [
                    InsiteTableRowItem(
                      title: 'Phone Number:',
                      content: "+91 7502347734",
                    ),
                    InsiteTableRowItem(
                      title: "Address",
                      content: "Equipment Management",
                    ),
                  ])
                ],
              ),
              Table(
                border: TableBorder(
                  verticalInside: BorderSide(color: borderLineColor, width: 2),
                  left: BorderSide(color: borderLineColor, width: 2),
                  bottom: BorderSide(color: borderLineColor, width: 2),
                ),
                children: [
                  TableRow(children: [
                    InsiteTableRowItem(
                      title: 'Created:',
                      content: "17/05/21  11.52",
                    ),
                    InsiteTableRowItem(
                      title: "Created by :",
                      content: "Insite.care@tatahitachi.co.in",
                    )
                  ])
                ],
              ),
              Table(
                 border: TableBorder(
                  verticalInside: BorderSide(color: borderLineColor, width: 2),
                  left: BorderSide(color: borderLineColor, width: 2),
                  bottom: BorderSide(color: borderLineColor, width: 2),
                ),
                
                children: [
                  TableRow(
                    children: [
                      InsiteTableRowItem(
                        title: "Last Login :",
                        content: "01/06/21   14:52",
                      ),
                      InsiteTableRowItem(
                        title: "VL Administrartor :",
                        content: "Administrartor",
                      )
                    ]
                  )
                ],
              ),
              Table(
                 border: TableBorder(
                  verticalInside: BorderSide(color: borderLineColor, width: 2),
                  left: BorderSide(color: borderLineColor, width: 2),
                  bottom: BorderSide(color: borderLineColor, width: 2),
                ),
                children: [
                  TableRow(
                    children: [
                      InsiteTableRowItem(
                        title: "VL Unified Fleet :",
                        content: "Administrartor",
                      ),
                      InsiteTableRowItem(
                        title: "VL Unified Service :",
                        content: "Administrartor",
                      )
                    ]
                  )
                ],
              ),
              Table(
                 border: TableBorder(
                  verticalInside: BorderSide(color: borderLineColor, width: 2),
                  left: BorderSide(color: borderLineColor, width: 2),
                  bottom: BorderSide(color: borderLineColor, width: 2),
                ),
                children: [
                  TableRow(
                    children: [
                      InsiteTableRowItem(
                        title: "Unified API :",
                        content: "-",
                      ),
                      InsiteTableRowItem(
                        title: "VL 3D Productivity Manage :",
                        content: "-",
                      )
                    ]
                  )
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
