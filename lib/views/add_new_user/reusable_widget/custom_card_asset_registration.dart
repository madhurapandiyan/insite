import 'package:flutter/material.dart';
import 'package:insite/core/models/add_asset_registration.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class CustoCardMultipleAssetWidget extends StatelessWidget {
  final AssetValues assetValue;

  CustoCardMultipleAssetWidget({
    this.assetValue,
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
                        title: assetValue.deviceId,
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
                                text: assetValue.machineModel,
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
                          content: assetValue.machineSlNo,
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
                          text: assetValue.hMR.toString(),
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
                          text: assetValue.hMRDate,
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
                          text: assetValue.plantName,
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
                          text: assetValue.plantCode,
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
                          text: assetValue.plantEmailID,
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
                          text: assetValue.dealerName,
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
                          text: assetValue.dealerCode,
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
                          text: assetValue.dealerEmailID,
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
                          text: assetValue.customerName,
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
                          text: assetValue.customerCode,
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
                          text: assetValue.customerEmailID,
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
