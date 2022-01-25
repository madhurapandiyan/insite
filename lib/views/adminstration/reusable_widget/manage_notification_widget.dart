import 'package:flutter/material.dart';
import 'package:insite/core/models/manage_notifications.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class ManageNotificationWidget extends StatelessWidget {
  final ConfiguredAlerts? alerts;

  ManageNotificationWidget({this.alerts});

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
                  text: alerts!.notificationTitle!.toUpperCase(),
                  size: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.edit,
                      color: Theme.of(context).textTheme.bodyText1!.color!,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).textTheme.bodyText1!.color!,
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
            text: alerts!.notificationType,
            size: 15,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InsiteText(
                text: "${alerts!.alertGroupID} Group",
                size: 15,
                fontWeight: FontWeight.bold,
              ),
              InsiteText(
                text: alerts!.createdDate != null
                    ? Utils.getLastReportedDateOneUTC(alerts!.createdDate)
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
