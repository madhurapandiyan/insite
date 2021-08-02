import 'package:flutter/material.dart';
import 'package:insite/core/models/fault.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';

import 'insite_row_item_text.dart';
import 'insite_text.dart';

class FaultListItem extends StatelessWidget {
  final Fault fault;
  final VoidCallback onCallback;
  const FaultListItem({this.fault, this.onCallback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                          title: "Asset ID :",
                          path: "assets/images/EX210.png",
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
                                content: "Tata Hitachi",
                              ),
                              InsiteTableRowItem(
                                title: "Model :",
                                content: "EX200LCSU..",
                              ),
                            ])
                          ],
                        )
                      ],
                    ),
                    TableRow(children: [
                      InsiteRichText(
                        title: "Serial No. :",
                        content: "SP20-56343",
                        onTap: () {},
                      ),
                      InsiteTableRowItemWithButton(
                        title: "Fault Total",
                        content: "123",
                      ),
                    ]),
                  ],
                ),
                tilePadding: EdgeInsets.all(0),
                children: [
                  Table(
                    border: TableBorder.all(),
                    children: [
                      TableRow(children: [
                        InsiteTableRowItem(
                          title: "Source :",
                          content: "System Master Control",
                        ),
                      ]),
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
