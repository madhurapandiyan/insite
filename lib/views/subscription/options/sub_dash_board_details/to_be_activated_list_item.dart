import 'package:flutter/material.dart';
import 'package:insite/core/models/subscription_dashboard_details.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';

class ToBeActivatedListItem extends StatelessWidget {
  final DetailResult? detailResult;
  final VoidCallback? onCallback;
  const ToBeActivatedListItem({Key? key, this.detailResult, this.onCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // SizedBox(
                  // height: 20,
                  // ),
                  // Icon(Icons.arrow_drop_down, color: Colors.white),
                  // SizedBox(
                  // height: 20,
                  // ),
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
                  0: FlexColumnWidth(5),
                  1: FlexColumnWidth(3),
                },
                children: [
                  TableRow(
                    children: [
                      InsiteTableRowItemWithImage(
                        title: detailResult!.gpsDeviceId != null
                            ? "Device ID : " + "\n" + detailResult!.gpsDeviceId!
                            : "Device ID : " + "\n",
                        path: detailResult == null || detailResult!.model == null
                            ? "assets/images/EX210.png"
                            : detailResult!.model != null
                                ? Utils().imageData(detailResult!.model!)
                                : "",
                      ),
                      InsiteTableRowItem(
                        title: "Network Provider : ",
                        content: detailResult!.networkProvider != null
                            ? detailResult!.networkProvider
                            : "",
                      ),
                    ],
                  ),
                ],
              ),
              children: [],
              tilePadding: EdgeInsets.all(0),
            ))
          ],
        ),
      ),
    );
  }
}
