import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class CustoCardMultipleAssetWidget extends StatelessWidget {
  final String deviceId;
  final String model;
  final String serial;
  final String hRM;
  final String hrmDate;
  final String plantName;
  final String plantCode;
  final String plantEmail;
  final String dealerName;
  final String dealerCode;
  final String dealerEmail;
  final String customerName;
  final String customerCode;
  final String customerEmail;

  CustoCardMultipleAssetWidget({
    this.customerCode,
    this.customerEmail,
    this.customerName,
    this.dealerCode,
    this.dealerEmail,
    this.dealerName,
    this.deviceId,
    this.hRM,
    this.hrmDate,
    this.model,
    this.plantCode,
    this.plantEmail,
    this.plantName,
    this.serial,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width * 0.7,
      child: SingleChildScrollView(
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
                          height: 100,
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
                          content: serial,
                          textColor: tango,
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
                          text: "HRM",
                        ),
                        InsiteTextOverFlow(
                          text: hRM,
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
                          text: "HRM Date",
                        ),
                        InsiteTextOverFlow(
                          overflow: TextOverflow.ellipsis,
                          text: hrmDate,
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
                          text: "Plant Name",
                        ),
                        InsiteTextOverFlow(
                          text: plantName,
                        )
                      ],
                    ),
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
                          text: "Plant Code",
                        ),
                        InsiteTextOverFlow(
                          overflow: TextOverflow.ellipsis,
                          text: plantCode,
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
                          text: "Plant Email ID",
                        ),
                        InsiteTextOverFlow(
                          text: plantEmail,
                        )
                      ],
                    ),
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
                          text: "Dealer Name",
                        ),
                        InsiteTextOverFlow(
                          overflow: TextOverflow.ellipsis,
                          text: dealerName,
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
                          text: "Dealer Code",
                        ),
                        InsiteTextOverFlow(
                          text: dealerCode,
                        )
                      ],
                    ),
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
                          text: "Dealer Email Id",
                        ),
                        InsiteTextOverFlow(
                          overflow: TextOverflow.ellipsis,
                          text: dealerEmail,
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
                          text: "Customer Name",
                        ),
                        InsiteTextOverFlow(
                          text: customerName,
                        )
                      ],
                    ),
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
                          text: "Customer Code",
                        ),
                        InsiteTextOverFlow(
                          overflow: TextOverflow.ellipsis,
                          text: customerCode,
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
                          text: "Customer Email Id",
                        ),
                        InsiteTextOverFlow(
                          text: customerEmail,
                        )
                      ],
                    ),
                  )
                ]),
              ],
            ),
            // Container(
            //   padding: EdgeInsets.only(left: 5),
            //   height: MediaQuery.of(context).size.height * 0.07,
            //   width: MediaQuery.of(context).size.width * 0.79,
            //   decoration: BoxDecoration(
            //       border: Border.all(width: 1, color: black),
            //       borderRadius:
            //           BorderRadius.only(bottomRight: Radius.circular(10))),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       InsiteText(
            //         text: "Subscription Activation Date :",
            //       ),
            //       SizedBox(
            //         height: 10,
            //       ),
            //       InsiteTextOverFlow(
            //         overflow: TextOverflow.ellipsis,
            //         text: date,
            //       )
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
