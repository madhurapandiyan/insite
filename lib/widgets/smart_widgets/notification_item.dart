import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/core/models/main_notification.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';
import 'package:logger/logger.dart';

class NotificationItem extends StatelessWidget {
  final Notifications? notifications;

  final VoidCallback? onCallback;
  final VoidCallback? showDetails;

  const NotificationItem(
      {this.notifications, this.onCallback, this.showDetails});

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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Icon(Icons.arrow_drop_down, color: Colors.white),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: notifications!.isSelected!
                              ? Theme.of(context).buttonColor
                              : Theme.of(context).backgroundColor,
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: Icon(
                        Icons.crop_square,
                        color: notifications!.isSelected!
                            ? Theme.of(context).buttonColor
                            : Colors.black,
                      )),
                ],
              ),
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
                          path: "assets/images/EX210.png",
                        ),
                        InsiteTableRowItem(
                          title: "Make",
                          content: notifications!.makeCode,
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
                          content: jsonValue["HourMeter"].toStringAsFixed(2),
                        ),
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
                                ? Utils.getLastReportedDateOneUTC(
                                    notifications!.occurUTC)
                                : "",
                          ),
                          InsiteTableRowItem(
                            title: "Odometer",
                            content: jsonValue["Odometer"].toString(),
                          ),
                        ],
                      ),
                      TableRow(children: [
                        InsiteTableRowItem(
                          title: "Location",
                          content: notifications!.location,
                        ),
                        InsiteTableRowItem(
                          title: "Value/ Occurence",
                          content: jsonValue["OccurrenceCount"].toString(),
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
    );
  }
}
