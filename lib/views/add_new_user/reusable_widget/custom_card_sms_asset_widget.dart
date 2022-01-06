import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:intl/intl.dart';

class CustomCardSmsAssetWidget extends StatelessWidget {
  final String? serialNo;
  final String? date;
  final String? deviceId;
  final String? name;
  final String? language;
  final String? mobileNo;
  final String? model;

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
      // width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        children: [
          Table(
            border: TableBorder.all(width: 2, color: borderLineColor),
            columnWidths: {0: FlexColumnWidth(6), 1: FlexColumnWidth(5)},
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
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: InsiteText(
                        text: deviceId,
                        ),
                    )
                  ],
                ),
                Center(
                  child: InsiteTableRowItem(
                    title: "Model",
                    content: model,
                  ),
                )
              ]),
              TableRow(children: [
                Container(
                  height: 50,
                  padding: EdgeInsets.only(left: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InsiteText(
                        text: "Serial No",
                      ),
                      InsiteRichText(
                        style: TextStyle(
                            fontSize: 12,
                            color: tango,
                            fontWeight: FontWeight.bold),
                        content: serialNo,
                        textColor: tango,
                      )
                    ],
                  ),
                ),
                InsiteTableRowItem(
                  title: "Recipient's Mobile No",
                  content: mobileNo,
                )
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
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.all(3),
              padding: EdgeInsets.only(left: 5),
              //height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 1,
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: borderLineColor),
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(10))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InsiteText(
                    text: "Subscription Activation Date :",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InsiteTextOverFlow(
                    overflow: TextOverflow.ellipsis,
                    text: Utils.getLastReportedDateFilterData(
                        DateFormat("yyyy-MM-dd").parse(date!)),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
