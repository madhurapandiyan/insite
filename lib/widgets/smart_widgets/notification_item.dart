import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/core/models/main_notification.dart' as notification;
import 'package:insite/core/models/user_preference.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/preference/model/time_zone.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';
import 'package:insite/core/models/main_notification.dart' as main_notification;
import 'package:logger/logger.dart';

class NotificationItem extends StatelessWidget {
  final notification.Notification? notifications;
  final UserPreference?dateFormat;
  final UserPreferedData?timeZone;
  final VoidCallback? onCallback;
  final VoidCallback? showDetails;

  const NotificationItem(
      {this.notifications, this.onCallback, this.showDetails, this.dateFormat, this.timeZone});

  @override
  Widget build(BuildContext context) {
    final jsonValue = jsonDecode(notifications!.notificationConfigJSON);


    return GestureDetector(
      onTap: () {
        onCallback!();
        Future.delayed(Duration(seconds: 1), () {
          showDetails!();
        });
      },
      child: Card(

        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  // SizedBox(
                  //   height: 50,
                  // ),
                  Container(
                    //padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Container(
                        //     decoration: BoxDecoration(
                        //         color: notifications!.isSelected!
                        //             ? Theme.of(context).buttonColor
                        //             : Theme.of(context).backgroundColor,
                        //         borderRadius:
                        //             BorderRadius.all(Radius.circular(4))),
                        //     child: Icon(
                        //       Icons.crop_square,
                        //       color: notifications!.isSelected!
                        //           ? Theme.of(context).buttonColor
                        //           : Colors.black,
                        //     )),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: InsiteExpansionTile(
                  tilePadding: EdgeInsets.only(left: 8),
                  title: Table(
                    border: TableBorder.all(),
                    columnWidths: {
                      0: FlexColumnWidth(6),
                      1: FlexColumnWidth(5),
                      2: FlexColumnWidth(4),
                    },
                    children: [
                      TableRow(
                        children: [
                          InsiteTableRowItemWithImage(
                            title: "Asset ID",
                            path: Utils().getImageWithAssetIconKey(
                                model: notifications?.model,
                                assetIconKey: notifications?.iconKey),
                          ),
                          InsiteTableRowItem(
                            title: "Name",
                            content: notifications!.notificationTitle,
                          ),
                          InsiteTableRowItem(
                            title: "Model",
                            content: notifications!.model,
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          InsiteRichText(
                            title: "Serial No. ",
                            content: notifications!.serialNumber,
                            onTap: () {
                              showDetails!();
                            },
                          ),
                          InsiteTableRowItem(
                            title: "Notification Type",
                            content: notifications!.notificationSubType,
                          ),
                          InsiteTableRowItem(
                              title: "Hour Mtr.",
                              content: jsonValue["HourMeter"] != null
                                  ? jsonValue["HourMeter"].toStringAsFixed(2)
                                  : "-"),
                        ],
                      ),
                    ],
                  ),
                  childrenPadding: EdgeInsets.only(left: 8),
                  children: [
                    Table(
                      border: TableBorder.all(),
                      children: [
                        TableRow(
                          children: [
                            InsiteTableRowItem(
                              title: "Date & Time",
                              content: notifications!.occurUTC != null
                                  ? Utils.getDateUTC(
                                      notifications!.occurUTC,dateFormat,timeZone)
                                  : "",
                            ),
                            // InsiteTableRowItem(
                            //   title: "Odometer",
                            //   content: jsonValue["Odometer"].toString(),
                            // ),
                            // InsiteTableRowItem(
                            //   title: "Value/ Occurrence",
                            //   content: jsonValue["OccurrenceCount"].toString(),
                            // ),
                          ],
                        ),
                      ],
                    ),
                    Table(border: TableBorder.all(), children: [
                      TableRow(children: [
                        InsiteTableRowItem(
                          title: "Location",
                          content: Utils.getLocationDisplay(dateFormat?.locationDisplay)?
                           notifications!.location:"${notifications!.latitude}/${notifications!.longitude}",
                        ),
                      ]),
                    ])
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