import 'package:flutter/material.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_dropdown_widget.dart';
import 'package:insite/widgets/smart_widgets/time_picker.dart';

class TimeSlots extends StatelessWidget {
  final List<String>? type;
  final List<String>? startTime;
  final List<String>? endTime;
  final ValueChanged<String?>? startTimeChanged;
  final ValueChanged<String?>? typeChanged;
  final ValueChanged<String?>? endTimeChanged;
  final String? initialTypeValue;
  final String? initialStartValue;
  final String? initialEndValue;

  TimeSlots(
      {this.type,
      this.endTime,
      this.startTime,
      this.startTimeChanged,
      this.endTimeChanged,
      this.initialTypeValue,
      this.initialEndValue,
      this.initialStartValue,
      this.typeChanged});

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).textTheme.bodyText1!.color!,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: TimePickerWidget()),
                Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).textTheme.bodyText1!.color!,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: TimePickerWidget()),
              ],
            )
          ],
        ),
      ),
    );
  }
}
