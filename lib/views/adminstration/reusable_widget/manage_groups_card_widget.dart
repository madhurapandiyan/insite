import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';

class ManageGroupCardWidget extends StatelessWidget {
  //const ManageGroupCardWidget({ Key? key }) : super(key: key);

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
                    title: 'Name',
                    content: "Aditya Construction",
                  ),
                  InsiteTableRowItem(
                    title: '# of Assets',
                    content: "5",
                  ),
                  InsiteTableRowItem(
                    title: 'Created by :',
                    content: "Hanamanth" + "\n" + "Kutogi",
                  ),
                ]),
                TableRow(children: [
                  InsiteTableRowItem(
                    title: 'Description :',
                    content: "Belgaum-Adithy" + "\n" + "Construction",
                  ),
                  InsiteTableRowItem(
                    title: 'Created:',
                    content: "01/02/20" + "\n" + "10.34",
                  ),
                  InsiteTableRowItem(
                    title: "",
                    content: "",
                  )
                ])
              ],
            ),
            tilePadding: EdgeInsets.all(0),
            childrenPadding: EdgeInsets.all(0),
          ))
        ],
      ),
    );
  }
}
