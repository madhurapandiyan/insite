import 'package:flutter/material.dart';
import 'package:insite/views/adminstration/asset_settings/asset_settings_filter/custom_widgets/increment_decrement_reusable_widget.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class TargetReusableWidget extends StatefulWidget {
  final String? days;
  final Function(String)? onValueCycleChange;
  final Function(String)? onValueVolumeChange;
  final Function(String)? onValuePayLoadChange;
  final double? fullWeekCountCycleValue;
  final double? fullWeekVolumeCycleValue;
  final double? fullWeekPayLoadCycleValue;
  const TargetReusableWidget(
      {this.days,
      this.onValueCycleChange,
      this.onValueVolumeChange,
      this.onValuePayLoadChange,
      this.fullWeekCountCycleValue,
      this.fullWeekVolumeCycleValue,
      this.fullWeekPayLoadCycleValue});

  @override
  _TargetReusableWidgetState createState() => _TargetReusableWidgetState();
}

class _TargetReusableWidgetState extends State<TargetReusableWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Container(
              width: 30,
              child: InsiteText(
                text: widget.days,
                size: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              width: 18,
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
                      color: Theme.of(context).textTheme.bodyText1!.color!)),
              child: IncrementDecrementwidget(
                onValueChange: (String value) {
                  widget.onValueCycleChange!(value);
                },
                countValue: widget.fullWeekCountCycleValue,
              ),
            ),
            SizedBox(
              width: 20,
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
                      color: Theme.of(context).textTheme.bodyText1!.color!)),
              child: IncrementDecrementwidget(
                countValue: widget.fullWeekVolumeCycleValue,
                onValueChange: (String value) {
                  widget.onValueVolumeChange!(value);
                },
              ),
            ),
            SizedBox(
              width: 20,
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
                      color: Theme.of(context).textTheme.bodyText1!.color!)),
              child: IncrementDecrementwidget(
                onValueChange: (String value) {
                  widget.onValuePayLoadChange!(value);
                },
                countValue: widget.fullWeekPayLoadCycleValue,
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
