import 'package:flutter/material.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class DaysReusableWidget extends StatefulWidget {
  final String days;
  final String value;

  const DaysReusableWidget({this.days, this.value});

  @override
  _DaysReusableWidgetState createState() => _DaysReusableWidgetState();
}

class _DaysReusableWidgetState extends State<DaysReusableWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 18,
            ),
            Container(
              width: 40,
              child: InsiteText(
                text: widget.days,
                size: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.height * 0.04,
              decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  border: Border.all(
                      color: Theme.of(context).textTheme.bodyText1.color)),
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: TextField(
                    decoration: InputDecoration(border: InputBorder.none)),
              ),
            ),
            SizedBox(
              width: 48,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.height * 0.04,
              decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  border: Border.all(
                      color: Theme.of(context).textTheme.bodyText1.color)),
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
            ),
            SizedBox(
              width: 14,
            ),
            Container(
              width: 40,
              child: InsiteText(
                text: widget.value + " " + "(0)%",
                fontWeight: FontWeight.w700,
                size: 14,
              ),
            ),
          ],
        ),
      
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
