import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:insite/core/models/utilization.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';
import 'package:logger/logger.dart';

class SingleAssetUsageTwo extends StatefulWidget {
  final AssetResult? utilizationData;
  const SingleAssetUsageTwo({this.utilizationData});

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
                Icon(Icons.arrow_drop_down,
                    color: Theme.of(context).iconTheme.color),
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
                        content: widget.utilizationData!.lastReportedTime != null
                            ? Utils.getLastReportedDateTwo(
                                widget.utilizationData!.lastReportedTime)
                            : "",
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
                      title: "Backhoe Idle",
                      content: "-",
                    ),
                    InsiteTableRowItem(
                      title: "Backhoe Working",
                      content: "-",
                    ),
                    InsiteTableRowItem(
                      title: "Backhoe Runtime",
                      content: "-",
                    ),
                  ]),
                  TableRow(children: [
                    InsiteTableRowItem(
                      title: "Loader Idle",
                      content: "-",
                    ),
                    InsiteTableRowItem(
                      title: "Loader Working",
                      content: "-",
                    ),
                    InsiteTableRowItem(
                      title: "Loader Runtime",
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
