import 'package:flutter/material.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class UtilGraphDropdownWidget extends StatefulWidget {
  final Function graphType;
  const UtilGraphDropdownWidget({Key? key, required this.graphType})
      : super(key: key);

  @override
  _UtilGraphDropdownWidgetState createState() =>
      _UtilGraphDropdownWidgetState();
}

class _UtilGraphDropdownWidgetState extends State<UtilGraphDropdownWidget> {
  String? dropdownValue = 'Idle % / Working %';
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: dropdownValue,
      dropdownColor: Theme.of(context).backgroundColor,
      icon: Icon(Icons.keyboard_arrow_down,
          color: Theme.of(context).iconTheme.color),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),
      underline: Container(
        height: 0,
      ),
      onChanged: (String? newValue) {
        dropdownValue = newValue;
        if (dropdownValue!.contains('Runtime Hours'))
          widget.graphType(UtilizationGraphType.RUNTIMEHOURS);

        if (dropdownValue!.contains('Distance Traveled (Kilometers)'))
          widget.graphType(UtilizationGraphType.DISTANCETRAVELLED);

        if (dropdownValue!.contains('Idle % / Working %'))
          widget.graphType(UtilizationGraphType.IDLEORWORKING);

        if (dropdownValue!.contains('Cumulative'))
          widget.graphType(UtilizationGraphType.CUMULATIVE);

        if (dropdownValue!.contains('Total Hours'))
          widget.graphType(UtilizationGraphType.TOTALHOURS);

        if (dropdownValue!.contains('Total Fuel Burned (Liters)'))
          widget.graphType(UtilizationGraphType.TOTALFUELBURNED);

        if (dropdownValue!.contains('Idle % Trend'))
          widget.graphType(UtilizationGraphType.IDLETREND);

        if (dropdownValue!.contains('Fuel Burn Rate Trend'))
          widget.graphType(UtilizationGraphType.FUELBURNRATETREND);
      },
      items: <String>[
        'Idle % / Working %',
        'Runtime Hours',
        'Distance Traveled (Kilometers)',
        'Cumulative',
        'Total Hours',
        'Total Fuel Burned (Liters)',
        'Idle % Trend',
        'Fuel Burn Rate Trend'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InsiteText(
                text: value,
                fontWeight: FontWeight.normal,
                size: 14,
              ),
              // Icon(
              //   Icons.check,
              //   color: white,
              // )
            ],
          ),
        );
      }).toList(),
    );
  }
}
