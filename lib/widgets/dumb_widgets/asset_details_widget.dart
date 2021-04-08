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
                    InsiteTableRow(
                      title: "Asset Id",
                      content: "-",
                    ),
                    InsiteTableRow(
                      title: "Asset Status",
                      content: detail.status,
                    ),
                    InsiteTableRow(
                      title: "Serial No.",
                      content: detail.assetSerialNumber,
                    )
                  ]),
                  TableRow(children: [
                    InsiteTableRow(
                      title: "Geofences",
                      content: "-",
                    ),
                    InsiteTableRow(
                      title: "Manufacturer",
                      content: detail.manufacturer,
                    ),
                    InsiteTableRow(
                      title: "Product Family",
                      content: detail.productFamily,
                    )
                  ]),
                  TableRow(children: [
                    InsiteTableRow(
                      title: "Model ",
                      content: detail.productFamily,
                    ),
                    InsiteTableRow(
                      title: "Hour Meter",
                      content: "-",
                    ),
                    InsiteTableRow(
                      title: "Year",
                      content:
                          detail.year != null ? detail.year.toString() : "-",
                    )
                  ]),
                  TableRow(children: [
                    InsiteTableRow(
                      title: "Last Reported time",
                      content: "-",
                    ),
                    InsiteTableRow(
                      title: "Groups",
                      content: "-",
                    ),
                    InsiteTableRow(
                      title: "",
                      content: "",
                    )
                  ]),
                  TableRow(children: [
                    InsiteTableRow(
                      title: "Service Plans",
                      content: "-",
                    ),
                    InsiteTableRow(
                      title: "Location",
                      content: "-",
                    ),
                    InsiteTableRow(
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
