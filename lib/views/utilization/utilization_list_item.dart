import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/core/models/utilization.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class UtilizationListItem extends StatelessWidget {
  final AssetResult data;
  final bool isShowingInDetailPage;
  final VoidCallback onCallback;
  UtilizationListItem({this.data, this.isShowingInDetailPage, this.onCallback});

  @override
  Widget build(BuildContext context) {
    return isShowingInDetailPage
        ? Container(
            width: 387,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0),
                  bottomLeft: const Radius.circular(10.0),
                  bottomRight: const Radius.circular(10.0)),
              boxShadow: [
                new BoxShadow(
                  blurRadius: 1.0,
                  color: cardcolor,
                ),
              ],
              border: Border.all(color: cardcolor),
              shape: BoxShape.rectangle,
            ),
            child: Column(
              children: [
                IntrinsicHeight(
                  child: new Row(
                    children: [
                      SvgPicture.asset("assets/images/arrowdown.svg"),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        data.date != null ? data.date : "",
                        style: new TextStyle(
                            fontSize: 12.0,
                            color: textcolor,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Roboto',
                            decoration: TextDecoration.none),
                      ),
                      VerticalDivider(
                        thickness: 2.0,
                        color: black,
                      ),
                      Stack(
                        children: [
                          new Column(
                            children: [
                              SizedBox(
                                height: 8.0,
                              ),
                              new Text(
                                "LastReportedTime",
                                style: new TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w700,
                                    color: textcolor),
                              ),
                              Row(
                                children: [
                                  new Text(
                                    data.lastReportedTime.toString(),
                                    style: new TextStyle(
                                        fontSize: 12.0,
                                        color: textcolor,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Roboto',
                                        decoration: TextDecoration.none),
                                  ),
                                  // new Text(data.date,
                                  //     style: new TextStyle(
                                  //         fontSize: 12.0,
                                  //         color: textcolor,
                                  //         fontStyle: FontStyle.normal,
                                  //         fontWeight: FontWeight.w400,
                                  //         fontFamily: 'Roboto',
                                  //         decoration: TextDecoration.none))
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      VerticalDivider(
                        thickness: 2.0,
                        color: black,
                      ),
                      Flexible(
                        child: Stack(
                          children: [
                            new Column(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: new Text(
                                    "Runtimeperformance",
                                    style: new TextStyle(
                                        decoration: TextDecoration.none,
                                        fontSize: 12.0,
                                        fontFamily: 'Roboto',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w700,
                                        color: textcolor),
                                  ),
                                ),
                                new Text(
                                  data.targetRuntimePerformance.toString(),
                                  style: new TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: textcolor,
                                      fontStyle: FontStyle.normal,
                                      fontFamily: 'Roboto',
                                      decoration: TextDecoration.none),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        : GestureDetector(
            onTap: () {
              onCallback();
            },
            child: Card(
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
                        Icon(Icons.arrow_drop_down, color: Colors.white),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            child:
                                Icon(Icons.crop_square, color: Colors.black)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ExpansionTile(
                      trailing: SizedBox(
                        width: 0,
                        height: 0,
                      ),
                      title: Table(
                        border: TableBorder.all(),
                        columnWidths: {
                          0: FlexColumnWidth(6),
                          1: FlexColumnWidth(3),
                        },
                        children: [
                          TableRow(
                            children: [
                              InsiteTableRowWithImage(
                                title: data.manufacturer,
                                path: "-",
                              ),
                              InsiteTableRowItem(
                                title: "Runime Hours",
                                content: data.runtimeHours.toString(),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              InsiteRichText(
                                title: "Serial No. ",
                                content: data.assetSerialNumber,
                              ),
                              InsiteTableRowItem(
                                title: "Working Time Hours",
                                content: data.workingHours.toString(),
                              ),
                            ],
                          ),
                        ],
                      ),
                      tilePadding: EdgeInsets.all(0),
                      children: [
                        Table(
                          border: TableBorder.all(),
                          columnWidths: {
                            0: FlexColumnWidth(6),
                            1: FlexColumnWidth(3),
                          },
                          children: [
                            TableRow(
                              children: [
                                InsiteTableRowItem(
                                  title: "Last Utiization Report",
                                  content: "-",
                                ),
                                InsiteTableRowItem(
                                  title: "Idle Hours",
                                  content: data.idleHours.toString(),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
