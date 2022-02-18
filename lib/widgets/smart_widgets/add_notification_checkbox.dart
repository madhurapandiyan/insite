import 'package:flutter/material.dart';
import 'package:insite/core/models/notification_type.dart';

import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class NotificationTypeCheckBox extends StatelessWidget {
  final String? title;
  final NotificationTypes? notifications;
  final VoidCallback? onTap;

  const NotificationTypeCheckBox({this.title, this.notifications, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: onTap,
              child: Container(
                  decoration: BoxDecoration(
                      color: notifications!.isSelected!
                          ? Theme.of(context).buttonColor
                          : Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: Icon(Icons.crop_square,
                      color: notifications!.isSelected!
                          ? Theme.of(context).buttonColor
                          : Colors.black))),
          SizedBox(
            width: 10,
          ),
          InsiteText(
            text: title,
            size: 14,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
      SizedBox(
        height: 10,
      ),
    ]);
  }
}
