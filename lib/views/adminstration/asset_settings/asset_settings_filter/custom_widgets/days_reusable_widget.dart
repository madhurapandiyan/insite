import 'package:flutter/material.dart';
import 'package:insite/views/adminstration/asset_settings/asset_settings_filter/custom_widgets/increment_decrement_reusable_widget.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class DaysReusableWidget extends StatefulWidget {
  final String days;
  final String value;
  final Function(String) onRuntimeValueChanged;
  final Function(String) onIdleValueChanged;
  final String countRuntimeValue;
  final String countIdleValue;
  final double percentageData;

  const DaysReusableWidget(
      {this.days,
      this.value,
      this.onRuntimeValueChanged,
      this.onIdleValueChanged,
      this.countRuntimeValue,
      this.countIdleValue,
      this.percentageData});

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
                width: MediaQuery.of(context).size.width * 0.20,
                height: MediaQuery.of(context).size.height * 0.06,
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
                child: IncrementDecrementwidget(
                  onValueChange: (String value) {
                    widget.onRuntimeValueChanged(value);
                  },
                  countValue: widget.countRuntimeValue,
                )),
            SizedBox(
              width: 48,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.20,
              height: MediaQuery.of(context).size.height * 0.06,
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
              child: IncrementDecrementwidget(
                onValueChange: (String value) {
                  widget.onIdleValueChanged(value);
                },
                countValue: widget.countIdleValue,
              ),
            ),
            SizedBox(
              width: 14,
            ),
            Container(
              width: 60,
              child: InsiteText(
                text: widget.value + " " + "${widget.percentageData}%",
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
