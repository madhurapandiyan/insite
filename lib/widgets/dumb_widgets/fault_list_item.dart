import 'package:flutter/material.dart';
import 'package:insite/core/models/fault.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';
import 'package:logger/logger.dart';
import 'insite_row_item_text.dart';
import 'insite_text.dart';

class FaultListItem extends StatelessWidget {
  final Fault? fault;
 final Devices ? device;
  final VoidCallback? onCallback;
  const FaultListItem({this.fault, this.onCallback,this.device});

  @override
  Widget build(BuildContext context) {
   // Logger().v(fault!.details!.dealerCustomerName);
    return GestureDetector(
      onTap: () {
        onCallback!();
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: Row(
            children: [
              Container(
                //padding: EdgeInsets.all(2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // Icon(Icons.arrow_drop_down, color: Colors.white),
                    // SizedBox(
                    //   height: 20,
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
                      0: FlexColumnWidth(4),
                      1: FlexColumnWidth(3),
                    },
                    children: [
                      TableRow(
                        children: [
                          InsiteTableRowItemWithImage(
                            title: Utils.getMakeTitle(
                                    fault!.asset!.details!.makeCode!) +
                                "\n" +
                                fault!.asset!.details!.model!,
                            path: fault?.asset!.details != null &&
                                    fault?.asset!.details!.model != null
                                ? Utils().getImageWithAssetIconKey(
                                    model: fault!.asset!.details!.model,
                                    assetIconKey: fault!.asset!.details!.assetIcon
                                        )
                                : "assets/images/0.png",
                          ),
                          InsiteTableRowItem(
                            title: "Fault Reported Time :",
                            content: fault!.basic != null &&
                                    fault!.basic!.faultOccuredUTC != null
                                ? Utils.getLastReportedDateOneUTC(
                                    fault!.basic!.faultOccuredUTC)
                                : "-",
                          )
                        ],
                      ),
                      TableRow(children: [
                        InsiteRichText(
                          title: "Serial No. : ",
                          content: fault!.asset!.basic != null &&
                                  fault!.asset!.basic!.serialNumber != null
                              ? fault!.asset!.basic!.serialNumber
                              : "",
                          onTap: () {
                            onCallback!();
                          },
                        ),
                        Table(
                          border: TableBorder.all(),
                          columnWidths: {
                            0: FlexColumnWidth(3),
                            1: FlexColumnWidth(3),
                          },
                          children: [
                            TableRow(children: [
                              InsiteTableRowItemWithButton(
                                title: "Severity : ",
                                buttonColor:
                                    Utils.getFaultColor(fault!.basic!.severity),
                                content: fault!.basic != null &&
                                        fault!.basic!.severity != null
                                    ? Utils.getFaultLabel(
                                        fault!.basic!.severity!)
                                    : "",
                              ),
                            ])
                          ],
                        )
                      ]),
                    ],
                  ),
                  tilePadding: EdgeInsets.all(0),
                  children: [
                    Table(
                      columnWidths: {
                        0: FlexColumnWidth(4),
                        1: FlexColumnWidth(3),
                      },
                      border: TableBorder.all(),
                      children: [
                        TableRow(children: [
                          InsiteRichText(
                            title: "Description : ",
                            content: fault!.basic != null &&
                                    fault!.basic!.description != null
                                ? fault!.basic!.description
                                : "",
                            onTap: () {
                              onCallback!();
                            },
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color),
                          ),
                          InsiteRichText(
                            title: "Source : ",
                            content: fault!.basic != null &&
                                    fault!.basic!.source != null
                                ? fault!.basic!.source
                                : "",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color),
                            onTap: () {
                              onCallback!();
                            },
                          ),
                        ]),
                        TableRow(children: [
                          InsiteRichText(
                            title: "Location : ",
                            content: fault!.asset!.faultDynamic!.location != null &&
                                    fault!.asset!.faultDynamic!.location != null
                                ? fault!.asset!.faultDynamic!.location
                                : "",
                            onTap: () {
                              onCallback!();
                            },
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color),
                          ),
                          InsiteRichText(
                            title: "Location-LastReported : ",
                            content: fault!.basic != null &&
                                    fault!.basic!.faultOccuredUTC != null
                                ?  Utils.getLastReportedDateOneUTC(
                                    fault!.asset!.faultDynamic!.locationReportedTimeUTC)
                                : "",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color),
                            onTap: () {
                              onCallback!();
                            },
                          ),
                        ]),
                        TableRow(children: [
                          InsiteRichText(
                            title: "Registered Dealer : ",
                            content: fault!.asset!.details!.dealerName != null &&
                                   fault!.asset!.details!.dealerName != null
                                ? fault!.asset!.details!.dealerName
                                : "",
                            onTap: () {
                              onCallback!();
                            },
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color),
                          ),
                          InsiteRichText(
                            title: "Universal Customer : ",
                            content: fault!.asset!.details!.universalCustomerName != null &&
                                    fault!.asset!.details!.universalCustomerName!= null
                                ? fault!.asset!.details!.universalCustomerName
                                : "",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color),
                            onTap: () {
                              onCallback!();
                            },
                          ),
                        ]),
                         TableRow(children: [
                          InsiteRichText(
                            title: "Asset Status : ",
                            content: fault!.asset!.faultDynamic!=null?
                            fault!.asset!.faultDynamic!.status
                                : "",
                            onTap: () {
                              onCallback!();
                            },
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color),
                          ),
                          InsiteRichText(
                            title: "Occurence Count : ",
                            content: 
                                 fault!.details!.occurrences!=null?
                                 fault!.details!.occurrences.toString():"-",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color),
                            onTap: () {
                              onCallback!();
                            },
                          ),
                        ]),
                        TableRow(children: [
                          InsiteRichText(
                            title: "Current Hour Meter : ",
                            content: 
                              fault!.asset!.faultDynamic!.hourMeter!=null?
                              fault!.asset!.faultDynamic!.hourMeter!.toString():"",
                              
                            onTap: () {
                              onCallback!();
                            },
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color),
                          ),
                          InsiteRichText(
                            title: "model :",
                            content: fault!.asset!.details!.model != null &&
                                    fault!.asset!.details!.model != null
                                ? fault!.asset!.details!.model.toString()
                                : "",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color),
                            onTap: () {
                              onCallback!();
                            },
                          ),
                        ]),
                         TableRow(children: [
                          InsiteRichText(
                            title: "Fault Code Type : ",
                            content: 
                              fault!.basic!.faultType!=null?
                              fault!.basic!.faultType:"",
                              
                            onTap: () {
                              onCallback!();
                            },
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color),
                          ),
                          InsiteRichText(
                            title: "Dealer Code :",
                            content: fault!.asset!.details!.dealerCode!= null &&
                                   fault!.asset!.details!.dealerCode!= null
                                ? fault!.asset!.details!.dealerCode!
                                : "",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color),
                            onTap: () {
                              onCallback!();
                            },
                          ),
                        ]),
                         TableRow(children: [
                          InsiteRichText(
                            title: "Device Id : ",
                            content: 
                             device!.deviceSerialNumber,
                              
                            onTap: () {
                              onCallback!();
                            },
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color),
                          ),
                          InsiteRichText(
                            title: "Device Type:",
                            content: device!.deviceType,
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color),
                            onTap: () {
                              onCallback!();
                            },
                          ),
                        ]),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
