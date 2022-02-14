import 'package:flutter/material.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class NotificationTypeCheckBox extends StatelessWidget {
  final String? title;

  const NotificationTypeCheckBox({this.title});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              decoration: BoxDecoration(
                  // color: notifications!.isSelected!
                  //     ? Theme.of(context).buttonColor
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              child: Icon(
                Icons.crop_square,
                // color: notifications!.isSelected!
                //     ? Theme.of(context).buttonColor
                color: Colors.black,
              )),
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
