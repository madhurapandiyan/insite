import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';
import 'package:logger/logger.dart';

class CustomCardReportSummaryWidget extends StatelessWidget {
  final String deviceId;
  final String serialNo;
  final String name;
  final String mobileNo;
  final String language;
  final String date;
  final bool isSelected;
  final Function onSelected;
  //final bool isExpanded;
  CustomCardReportSummaryWidget(
      {this.deviceId,
      this.serialNo,
      this.name,
      this.date,
      this.isSelected,
      this.onSelected,
      this.language,
      this.mobileNo});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      // height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: tuna,
      ),
      child: Row(
        children: [
          Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.keyboard_arrow_down),
              IconButton(
                  onPressed: () {
                    onSelected();
                  },
                  icon: Icon(
                    Icons.check_box_outline_blank,
                    color: isSelected ? tango : white,
                  ))
            ],
          ),
          Expanded(
            child: InsiteExpansionTile(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Table(
                          border: TableBorder.all(width: 1, color: black),
                          children: [
                            TableRow(children: [
                              Container(
                                padding: EdgeInsets.only(left: 5),
                                height: 50,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InsiteText(
                                      size: 12,
                                      text: "Language :",
                                    ),
                                    InsiteText(
                                      size: 12,
                                      text: language,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 5),
                                height: 50,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InsiteText(
                                      size: 12,
                                      text: "Scheduled SMS Start Date",
                                    ),
                                    InsiteText(
                                      size: 12,
                                      text: date,
                                    ),
                                  ],
                                ),
                              ),
                            ])
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
              title: Expanded(
                  child: Table(
                border: TableBorder.all(width: 1, color: black),
                columnWidths: {0: FlexColumnWidth(5), 1: FlexColumnWidth(5)},
                children: [
                  TableRow(children: [
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      height: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InsiteText(
                            size: 12,
                            text: "Device ID :",
                          ),
                          InsiteText(
                            size: 12,
                            text: deviceId,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      height: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InsiteText(
                            size: 12,
                            text: "Recipient’s Name :",
                          ),
                          InsiteText(
                            size: 12,
                            text: name,
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
                            size: 12,
                            text: "Serial No. :",
                          ),
                          InsiteText(
                            size: 12,
                            text: serialNo,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      height: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InsiteText(
                            size: 12,
                            text: "Mobile Number : ",
                          ),
                          InsiteText(
                            size: 12,
                            text: mobileNo,
                          ),
                        ],
                      ),
                    ),
                  ]),
                ],
              )),
            ),
          ),
        ],
      ),
    );
  }
}
