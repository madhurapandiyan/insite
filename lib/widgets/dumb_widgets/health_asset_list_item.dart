import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';
import 'insite_row_item_text.dart';
import 'insite_text.dart';

class HealthAssetListItem extends StatelessWidget {
  const HealthAssetListItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
                    columnWidths: {
                      0: FlexColumnWidth(3),
                      1: FlexColumnWidth(3),
                    },
                    border: TableBorder.all(),
                    children: [
                      TableRow(children: [
                        InsiteTableRowItem(
                          title: "Source :",
                          content: "System Master Control",
                        ),
                        InsiteTableRowItem(
                          title: "Source :",
                          content: "System Master Control",
                        ),
                      ]),
                      TableRow(children: [
                        InsiteTableRowItem(
                          title: "Source :",
                          content: "System Master Control",
                        ),
                        InsiteTableRowItem(
                          title: "Source :",
                          content: "System Master Control",
                        ),
                      ]),
                    ],
                  ),
                  Table(
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
                  ),
                  Table(
                    columnWidths: {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(1),
                      3: FlexColumnWidth(1),
                    },
                    border: TableBorder.all(),
                    children: List.generate(
                        4,
                        (index) => TableRow(children: [
                              InsiteTextWithPadding(
                                padding: EdgeInsets.all(8),
                                text: "1/06/21 17:52",
                                color: Colors.white,
                                size: 12,
                              ),
                              InsiteButton(
                                title: "High",
                                padding: EdgeInsets.all(8),
                                bgColor: buttonColorFive,
                                height: 30,
                                width: 40,
                              ),
                              InsiteTextWithPadding(
                                padding: EdgeInsets.all(8),
                                text: "Engine",
                                color: Colors.white,
                                size: 12,
                              ),
                              InsiteTextWithPadding(
                                padding: EdgeInsets.all(8),
                                text: "Engine over heat",
                                color: Colors.white,
                                size: 12,
                              ),
                            ])),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
