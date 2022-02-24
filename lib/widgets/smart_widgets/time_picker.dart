import 'package:flutter/material.dart';
import 'package:insite/widgets/smart_widgets/time_button_widget.dart';

class TimePickerWidget extends StatefulWidget {
  @override
  _TimePickerWidgetState createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  TimeOfDay? time;

  String getText() {
    if (time == null) {
      return 'Select Time';
    } else {
      final hours = time!.hour.toString().padLeft(2, '0');
      final minutes = time!.minute.toString().padLeft(2, '0');

      return '$hours:$minutes';
    }
  }

  @override
  Widget build(BuildContext context) => ButtonHeaderWidget(
        text: getText(),
        onClicked: () => pickTime(context),
      );

  Future pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 0, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: time ?? initialTime,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.white,
              onSurface: Colors.white,
            ),
            buttonTheme: ButtonThemeData(
              colorScheme: ColorScheme.dark(
                primary: Colors.white,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (newTime == null) return;
    time = newTime;

    setState(() => time = newTime);
  }
}
