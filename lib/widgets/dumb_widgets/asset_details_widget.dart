import 'package:flutter/material.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class AssetDetailWidgt extends StatelessWidget {
  final AssetDetail detail;
  const AssetDetailWidgt({this.detail});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Card(
        color: tuna,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: cardcolor)),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
              child: Row(
                children: [
                  Icon(Icons.keyboard_arrow_down, color: Colors.white),
                  SizedBox(
                    width: 20,
                  ),
                  InsiteText(
                    color: Colors.white,
                    size: 12,
                    text: "DETAILS",
                    fontWeight: FontWeight.bold,
                  )
                ],
              ),
            ),
            Container(
              child: Table(
                border: TableBorder.all(),
                children: [
                  TableRow(children: [
                    InsiteTableRowItem(
                      title: "Asset Id",
                      content: "-",
                    ),
                    InsiteTableRowItem(
                      title: "Asset Status",
                      content: detail.status,
                    ),
                    InsiteTableRowItem(
                      title: "Serial No.",
                      content: detail.assetSerialNumber,
                    )
                  ]),
                  TableRow(children: [
                    InsiteTableRowItem(
                      title: "Geofences",
                      content: "-",
                    ),
                    InsiteTableRowItem(
                      title: "Manufacturer",
                      content: detail.manufacturer,
                    ),
                    InsiteTableRowItem(
                      title: "Product Family",
                      content: detail.productFamily,
                    )
                  ]),
                  TableRow(children: [
                    InsiteTableRowItem(
                      title: "Model ",
                      content: detail.productFamily,
                    ),
                    InsiteTableRowItem(
                      title: "Hour Meter",
                      content: "-",
                    ),
                    InsiteTableRowItem(
                      title: "Year",
                      content:
                          detail.year != null ? detail.year.toString() : "-",
                    )
                  ]),
                  TableRow(children: [
                    InsiteTableRowItem(
                      title: "Last Reported time",
                      content: "-",
                    ),
                    InsiteTableRowItem(
                      title: "Groups",
                      content: "-",
                    ),
                    InsiteTableRowItem(
                      title: "",
                      content: "",
                    )
                  ]),
                  TableRow(children: [
                    InsiteTableRowItem(
                      title: "Service Plans",
                      content: "-",
                    ),
                    InsiteTableRowItem(
                      title: "Location",
                      content: "-",
                    ),
                    InsiteTableRowItem(
                      title: "",
                      content: "",
                    )
                  ])
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
