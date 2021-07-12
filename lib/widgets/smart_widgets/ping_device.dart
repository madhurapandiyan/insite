import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';

class PingDevice extends StatelessWidget {
  const PingDevice({
    Key key,
    @required this.onTap,
  }) : super(key: key);

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
     // width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.26,
      decoration: BoxDecoration(
        color: tuna,
        border: Border.all(color: black, width: 0.0),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Details'.toUpperCase(),
                      style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ],
                ),
                InsiteButton(
                  title: 'Ping Device'.toUpperCase(),
                  onTap: onTap,
                  bgColor: tango,
                  textColor: white,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(children: [
                  InsiteTableRowItem(
                    title: "Registered Dealer",
                    content: "Dharwad - Training Dept",
                  ),
                  InsiteTableRowItem(
                    title: "Device Type",
                    content: "TAP76",
                  ),
                  InsiteTableRowItem(
                    title: "Serial No.",
                    content: "NG498917",
                  ),
                ])
              ],
            ),
          ],
        ),
      ),
    );
  }
}
