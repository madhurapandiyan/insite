import 'package:flutter/material.dart';
import 'package:insite/core/models/subscription_dashboard_details.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';

class PlantListItem extends StatelessWidget {
  final DetailResult? detailResult;
  final VoidCallback? onCallback;
  const PlantListItem({Key? key, this.detailResult, this.onCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        child: Row(
          children: [
            Container(
              //padding: EdgeInsets.all(8),
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
                child: Padding(
                  padding: const EdgeInsets.all(15),
              //   padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 15.0),
                 // padding: const EdgeInsets.only(right:15 ),
                  child: Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
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
                          InsiteRichText(
                            title: "Plant Name : ",
                            content:
                                detailResult!.name != null ? detailResult!.name : "",
                                 onTap: () {
                                   onCallback!();
                                 },
                          ),
                          InsiteTableRowItem(
                            title: "User Name : ",
                            content: detailResult!.userName != null
                                ? detailResult!.userName
                                : "",
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          InsiteTableRowItem(
                            title: "Plant Code : ",
                            content:
                                detailResult!.code != null ? detailResult!.code : "",
                          ),
                          InsiteTableRowItem(
                            title: "Plant Email Id : ",
                            content: detailResult!.email != null
                                ? detailResult!.email
                                : "",
                          ),
                        ],
                      ),
                    ],
                                ),
                                children: [],
                                tilePadding: EdgeInsets.all(0),
                              ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
