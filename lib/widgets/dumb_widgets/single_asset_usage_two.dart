import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';
import 'package:logger/logger.dart';

class SingleAssetUsageTwo extends StatefulWidget {
  // const SingleAssetUsage({ Key? key }) : super(key: key);

  @override
  _SingleAssetUsageState createState() => _SingleAssetUsageState();
}

class _SingleAssetUsageState extends State<SingleAssetUsageTwo> {
  @override
  void initState() {
    super.initState();
    Logger().d("SingleAssetUsageTwo");
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  0: FlexColumnWidth(3),
                  1: FlexColumnWidth(3),
                  2: FlexColumnWidth(3)
                },
                children: [
                  TableRow(
                    children: [
                      InsiteTableRowItem(
                        title: "Date : ",
                        content: "16/02/2021",
                      ),
                      InsiteTableRowItem(
                        title: "",
                        content: "",
                      ),
                      InsiteTableRowItem(
                        title: "",
                        content: "",
                      ),
                    ],
                  ),
                  TableRow(children: [
                    InsiteTableRowItem(
                      title: "Economy",
                      content: "-",
                    ),
                    InsiteTableRowItem(
                      title: "Travel",
                      content: "-",
                    ),
                    InsiteTableRowItem(
                      title: "Auto Idle",
                      content: "-",
                    ),
                  ]),
                  TableRow(children: [
                    InsiteTableRowItem(
                      title: "Economy",
                      content: "-",
                    ),
                    InsiteTableRowItem(
                      title: "Travel",
                      content: "-",
                    ),
                    InsiteTableRowItem(
                      title: "Auto Idle",
                      content: "-",
                    ),
                  ])
                ],
              ),
              tilePadding: EdgeInsets.all(6),
              childrenPadding: EdgeInsets.all(0),
            ),
          ),
        ],
      ),
    );
  }
}
