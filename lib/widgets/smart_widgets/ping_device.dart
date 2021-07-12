import 'package:flutter/material.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';

class PingDevice extends StatelessWidget {
  final AssetDetail assetDetail;
  const PingDevice({
    Key key,
    this.assetDetail,
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
                          fontSize: 15),
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
                    content: assetDetail.dealerName,
                  ),
                  InsiteTableRowItem(
                    title: "Device Type",
                    content: assetDetail.devices[0].deviceType,
                  ),
                  InsiteTableRowItem(
                    title: "Serial No.",
                    content: assetDetail.devices[0].deviceSerialNumber,
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
