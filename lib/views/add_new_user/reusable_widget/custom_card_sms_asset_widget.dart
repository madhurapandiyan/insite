import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:intl/intl.dart';

class CustomCardSmsAssetWidget extends StatelessWidget {
  final String serialNo;
  final String date;
  final String deviceId;
  final String name;
  final String language;
  final String mobileNo;
  final String model;

  CustomCardSmsAssetWidget(
      {this.deviceId,
      this.date,
      this.language,
      this.mobileNo,
      this.model,
      this.name,
      this.serialNo});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width * 0.79,
      child: Column(
        children: [
          Table(
            border: TableBorder.all(width: 1, color: black),
            columnWidths: {0: FlexColumnWidth(5), 1: FlexColumnWidth(5)},
            children: [
              TableRow(children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InsiteTableRowItemWithImage(
                      path: "assets/images/EX210.png",
                      title: "Device ID ",
                    ),
                    InsiteRichText(
                      title: deviceId,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 5),
                        height: 50,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              child: InsiteText(
                                text: "Make",
                              ),
                            ),
                            FittedBox(
                              child: InsiteText(
                                text: "Tata Hitachi",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10))),
                        height: 80,
                        //width: 60,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InsiteText(
                              text: "Model",
                            ),
                            InsiteTextOverFlow(
                              overflow: TextOverflow.ellipsis,
                              text: model,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ]),
              TableRow(children: [
                Container(
                  height: 50,
                  padding: EdgeInsets.only(left: 3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InsiteText(
                        overflow: TextOverflow.ellipsis,
                        text: "Serial No",
                      ),
                      InsiteRichText(
                        textColor: tango,
                        title: serialNo,
                      )
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.only(left: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InsiteText(
                        text: "Recipient’s Mobile No",
                      ),
                      InsiteTextOverFlow(
                        text: mobileNo,
                      ),
                    ],
                  ),
                ),
              ]),
              TableRow(children: [
                Container(
                  padding: EdgeInsets.only(left: 5),
                  height: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InsiteText(
                        text: "Recipient’s Name",
                      ),
                      InsiteTextOverFlow(
                        overflow: TextOverflow.ellipsis,
                        text: name,
                      )
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.only(left: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InsiteText(
                        text: "Language",
                      ),
                      InsiteTextOverFlow(
                        text: language,
                      )
                    ],
                  ),
                )
              ]),
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 5),
            height: MediaQuery.of(context).size.height * 0.09,
            width: MediaQuery.of(context).size.width * 0.79,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: black),
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(10))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InsiteText(
                  text: "Subscription Activation Date :",
                ),
                SizedBox(height: 10,),
                InsiteTextOverFlow(
                  overflow: TextOverflow.ellipsis,
                  text: DateFormat("yyyy-MM-dd").parse(date).toString(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
