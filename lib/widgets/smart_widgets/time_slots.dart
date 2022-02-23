import 'package:flutter/material.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_dropdown_widget.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/smart_widgets/time_picker.dart';
import 'package:logger/logger.dart';

class TimeSlots extends StatelessWidget {
  final List<String>? type;

  final ValueChanged<String?>? startTimeChanged;
  final ValueChanged<String?>? typeChanged;
  final ValueChanged<String?>? endTimeChanged;
  final String? initialTypeValue;
  final String? initialStartValue;
  final String? initialEndValue;

  TimeSlots(
      {this.type,
      this.startTimeChanged,
      this.endTimeChanged,
      this.initialTypeValue,
      this.initialEndValue,
      this.initialStartValue,
      this.typeChanged});

  showTimePickerWidget(Function(String) callBack, BuildContext ctx) {
    showTimePicker(
       
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
            context: ctx,
            initialTime: TimeOfDay.now())
        .then((value) {
                final hours = value!.hour.toString().padLeft(2, '0');
      final minutes = value.minute.toString().padLeft(2, '0');
      callBack('$hours:$minutes');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        height: 150,
        width: double.infinity,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).textTheme.bodyText1!.color!,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: CustomDropDownWidget(
                value: initialTypeValue,
                items: type,
                enableHint: true,
                onChanged: typeChanged,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            initialTypeValue == type![1]
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InsiteButton(
                        width: 100,
                        height: 50,
                        title: initialStartValue,
                        onTap: () {
                          showTimePickerWidget(startTimeChanged!, context);
                        },
                      ),
                      InsiteButton(
                        width: 100,
                        height: 50,
                        title: initialEndValue,
                        onTap: () {
                          showTimePickerWidget(endTimeChanged!, context);
                        },
                      ),
                    ],
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
