import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';

class HealthListItem extends StatelessWidget {
  const HealthListItem();

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      color: cardcolor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: cardcolor)),
      child: Row(
        children: [
          Expanded(
              child: InsiteExpansionTile(
            title: Table(
              border: TableBorder.all(),
              columnWidths: {
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(2),
                3: FlexColumnWidth(2)
              },
              children: [
                TableRow(children: [
                  Column(children: [
                    Icon(Icons.arrow_drop_down, color: Colors.white),
                  ]),
                  InsiteTableRowItem(
                    title: 'Description :',
                    content: 'Air Filter clogged',
                  ),
                  InsiteTableRowItem(
                    title: 'Location :',
                    content: 'Thalaserry IN..',
                  ),
                  InsiteTableRowItem(
                    title: 'Hour Meter :',
                    content: '4865',
                  ),
                ]),
                TableRow(children: [
                  Column(
                    children: [Icon(Icons.crop_square, color: Colors.black)],
                  ),
                  InsiteTableRowItem(
                    title: 'Source :',
                    content: 'Air Intake assembly',
                  ),
                  InsiteTableRowItem(
                    title: 'Reported Date :',
                    content: '1/06/21 17:52',
                  ),
                  Column(
                    children: [
                      Text(
                        "Severity",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: textcolor),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      InsiteButton(
                        width: 70,
                        height: 30,
                        bgColor: burntSienna,
                        title: 'High',
                        textColor: textcolor,
                      )
                    ],
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
