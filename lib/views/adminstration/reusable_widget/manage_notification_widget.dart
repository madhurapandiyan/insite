import 'package:flutter/material.dart';
import 'package:insite/core/models/manage_notifications.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class ManageNotificationWidget extends StatelessWidget {
  final ConfiguredAlerts? alerts;

  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  ManageNotificationWidget({this.alerts, this.onDelete, this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: InsiteText(
                  text: alerts?.notificationTitle?.toUpperCase(),
                  size: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    color: Theme.of(context).buttonColor,
                    onPressed: onEdit,
                    icon: Icon(
                      Icons.edit,
                      //color: Theme.of(context).textTheme.bodyText1!.color!,
                    ),
                  ),
                  IconButton(
                    color: Theme.of(context).buttonColor,
                    onPressed: onDelete,
                    icon: Icon(
                      Icons.delete,
                      //color: Theme.of(context).textTheme.bodyText1!.color!,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          InsiteText(
            text: Utils.getNotificationCondition(alerts),
            // "${alerts?.operands?.first.operandName}" +
            //     "  " +
            //     "${alerts?.operands?.first.condition}",
            size: 15,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              alerts?.numberOfAssets != 0 && alerts?.numberOfAssetGroups == 0
                  ? InsiteText(
                      text: "${alerts?.numberOfAssets} " +
                          "${alerts?.numberOfAssets == 1 ? "Asset" : "Assets"}",
                      size: 15,
                      fontWeight: FontWeight.bold,
                    )
                  : alerts?.numberOfAssetGroups != 0
                      ? InsiteText(
                          text: "${alerts?.numberOfAssetGroups} " +
                              "${alerts?.numberOfAssetGroups == 1 ? "Group" : "Groups"}",
                          size: 15,
                          fontWeight: FontWeight.bold,
                        )
                      : InsiteText(
                          text: "${alerts?.numberOfGeofences} " +
                              "${alerts?.numberOfGeofences == 1 ? "Geofence" : "Geofences"}",
                          size: 15,
                          fontWeight: FontWeight.bold,
                        ),
              InsiteText(
                text: alerts?.createdDate != null
                    ? Utils.getLastReportedDateOneUTC(alerts?.createdDate)
                    : "",
                size: 15,
                fontWeight: FontWeight.bold,
              ),
            ],
          )
        ],
      ),
    );
  }
}
