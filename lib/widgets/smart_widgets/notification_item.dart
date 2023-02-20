import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/core/models/main_notification.dart' as notification;
import 'package:insite/core/models/main_notification.dart';
import 'package:insite/core/models/user_preference.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/preference/model/time_zone.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';
import 'package:insite/core/models/main_notification.dart' as main_notification;
import 'package:logger/logger.dart';

class NotificationItem extends StatelessWidget {
  final NotificationRow? selectedNotification;

  final notification.Notification? notifications;
  final UserPreference? dateFormat;
  final UserPreferedData? timeZone;
  final VoidCallback? onCallback;
  final VoidCallback? showDetails;

  NotificationItem(
      {this.notifications,
      this.onCallback,
      this.showDetails,
      this.dateFormat,
      this.timeZone,
      this.selectedNotification});

  @override
  Widget build(BuildContext context) {
    final jsonValue = jsonDecode(
        selectedNotification!.selectednotifications!.notificationConfigJSON);
    var isResolved =
        selectedNotification?.selectednotifications?.resolvedStatus ==
            "Resolved";

    return GestureDetector(
      onTap: () {
        onCallback!();

        // Future.delayed(Duration(seconds: 1), () {
        //   showDetails!();
        // });
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(right: 10, left: 5),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  // SizedBox(
                  //   height: 50,
                  // ),

                  Icon(
                    selectedNotification!.isSelected
                        ? Icons.check_box_rounded
                        : Icons.check_box_outline_blank,
                    color: selectedNotification!.isSelected
                        ? Theme.of(context).buttonColor
                        : Theme.of(context).textTheme.bodyText1!.color,
                  ),

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
                  title: Theme(
                    data: ThemeData(
                        primarySwatch: Colors.grey,
                        buttonColor: isResolved
                            ? Colors.grey[300]
                            : Theme.of(context).buttonColor,
                        textTheme: TextTheme(
                            bodyText1: TextStyle(
                                color: isResolved
                                    ? black.withOpacity(0.2)
                                    : null))),
                    child: Table(
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
                  ),
                  childrenPadding: EdgeInsets.only(left: 8),
                  children: [
                    Theme(
                      data: ThemeData(
                          textTheme: TextTheme(
                              bodyText1: TextStyle(
                                  color: isResolved
                                      ? black.withOpacity(0.2)
                                      : null))),
                      child: Table(
                        border: TableBorder.all(),
                        children: [
                          TableRow(
                            children: [
                              InsiteTableRowItem(
                                title: "Date & Time",
                                content: notifications!.occurUTC != null
                                    ? Utils.getDateUTC(notifications!.occurUTC,
                                        dateFormat, timeZone)
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
                    ),
                    Theme(
                      data: ThemeData(
                          textTheme: TextTheme(
                              bodyText1: TextStyle(
                                  color: isResolved
                                      ? black.withOpacity(0.2)
                                      : null))),
                      child: Table(border: TableBorder.all(), children: [
                        TableRow(children: [
                          InsiteTableRowItem(
                            title: "Location",
                            content: Utils.getLocationDisplay(
                                    dateFormat?.locationDisplay)
                                ? notifications!.location
                                : "${notifications!.latitude}/${notifications!.longitude}",
                          ),
                        ]),
                      ]),
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
