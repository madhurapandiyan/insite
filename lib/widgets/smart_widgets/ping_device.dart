import 'package:flutter/material.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class PingDevice extends StatelessWidget {
  final AssetDetail? assetDetail;
  const PingDevice({
    Key? key,
    this.assetDetail,
    required this.onTap,
  }) : super(key: key);

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
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
                    // Icon(
                    //   Icons.keyboard_arrow_down,
                    //   color: white,
                    // ),
                    SizedBox(
                      width: 10,
                    ),
                    InsiteText(
                        text: 'Device Details'.toUpperCase(),
                        fontWeight: FontWeight.bold,
                        size: 15),
                  ],
                ),
                // Button be removed frp client side till now
                // InsiteButton(
                //   title: 'Ping Device'.toUpperCase(),
                //   onTap: onTap,
                //   bgColor: tango,
                //   textColor: white,
                // ),
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
                    content: assetDetail!.dealerName,
                  ),
                  InsiteTableRowItem(
                    title: "Device Type",
                    content: assetDetail!.devices![0].deviceType,
                  ),
                  InsiteTableRowItem(
                    title: "Serial No.",
                    content: assetDetail!.devices![0].deviceSerialNumber,
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
