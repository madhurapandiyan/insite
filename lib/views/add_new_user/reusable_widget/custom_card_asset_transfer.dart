import 'package:flutter/material.dart';
import 'package:insite/core/models/add_asset_transfer.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class CustomCardMultipeAssetTransfer extends StatelessWidget {
  CustomCardMultipeAssetTransfer({Key? key, this.transfer}) : super(key: key);
  final Transfer? transfer;

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
                        title: transfer!.deviceId,
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
                                text: transfer!.machineModel,
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
                          content: transfer!.machineSlNo,
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
                          text: "Dealer Name",
                        ),
                        InsiteTextOverFlow(
                          text: transfer!.dealerName,
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
                          text: "Dealer Code",
                        ),
                        InsiteTextOverFlow(
                          overflow: TextOverflow.ellipsis,
                          text: transfer!.dealerCode,
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
                          text: "Dealer Email",
                        ),
                        InsiteTextOverFlow(
                          text: transfer!.dealerEmailID,
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
                          text: "Dealer Mobile No",
                        ),
                        InsiteTextOverFlow(
                          overflow: TextOverflow.ellipsis,
                          text: transfer!.dealerMobile,
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
                          text: "Dealer SMS Language",
                        ),
                        InsiteTextOverFlow(
                          text: transfer!.dealerLanguage,
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
                          text: "Customer Name",
                        ),
                        InsiteTextOverFlow(
                          overflow: TextOverflow.ellipsis,
                          text: transfer!.customerName,
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
                          text: "Customer Code",
                        ),
                        InsiteTextOverFlow(
                          text: transfer!.customerCode,
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
                          text: "Customer Email Id",
                        ),
                        InsiteTextOverFlow(
                          overflow: TextOverflow.ellipsis,
                          text: transfer!.customerEmailID,
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
                          text: "Customer Mobile No.",
                        ),
                        InsiteTextOverFlow(
                          text: transfer!.customerMobile,
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
                          text: "Customer SMS Language",
                        ),
                        InsiteTextOverFlow(
                          overflow: TextOverflow.ellipsis,
                          text: transfer!.customerLanguage,
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
                          text: "Primary Industry",
                        ),
                        InsiteTextOverFlow(
                          text: transfer!.primaryIndustry,
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
                          text: "Secondary Industry",
                        ),
                        InsiteTextOverFlow(
                          overflow: TextOverflow.ellipsis,
                          text: transfer!.secondaryIndustry,
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
                          text: "Commisioning Date",
                        ),
                        InsiteTextOverFlow(
                          text: transfer!.commissioningDate,
                        )
                      ],
                    ),
                  )
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
