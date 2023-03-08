import 'package:flutter/material.dart';
import 'package:insite/core/models/user_preference.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_dropdown_widget.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:logger/logger.dart';
import '../dumb_widgets/insite_text.dart';

class TimeSlots extends StatelessWidget {
  final UserPreference? userPreference;
  final List<String>? type;
  final bool? isSelected;
  final ValueChanged<String?>? startTimeChanged;
  final ValueChanged<String?>? typeChanged;
  final ValueChanged<String?>? endTimeChanged;
  final String? initialTypeValue;
  final String? initialStartValue;
  final String? initialEndValue;
  final Function(bool)? onSwitchChange;

  TimeSlots(
      {this.userPreference,
      this.type,
      this.startTimeChanged,
      this.endTimeChanged,
      this.initialTypeValue,
      this.initialEndValue,
      this.initialStartValue,
      this.typeChanged,
      this.isSelected,
      this.onSwitchChange});

  showTimePickerWidget(Function(String) callBack, BuildContext ctx) {
    showTimePicker(
            builder: (context, child) {
              return child!;
            },
            context: ctx,
            initialTime: TimeOfDay.now())
        .then((value) {
      final hours = value!.hour.toString().padLeft(2, '0');
      // Utils.switchTimeFormat(time: value,userPreference: userPreference);

      final minutes = value.minute.toString().padLeft(2, '0');

      var data = TimeOfDay(hour: value.hour, minute: value.minute).format(ctx);
       Logger().wtf(data);
       
      callBack(Utils.getTimeAbbre(
          hours: hours,
          minutes: minutes,
          userPreference: userPreference,
          selectedTime: data));

      // callBack(Utils.getTime(hours: hours,minutes: minutes,time: value,userPreference: userPreference));
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaquerry = MediaQuery.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InsiteButton(
          bgColor: Theme.of(context).cardColor,
          //width: 100,
          title: initialStartValue,
          onTap: () {
            showTimePickerWidget(startTimeChanged!, context);
          },
        ),
        InsiteButton(
          bgColor: Theme.of(context).cardColor,
          width: 100,
          title: initialEndValue,
          onTap: () {
            showTimePickerWidget(endTimeChanged!, context);
          },
        ),
        Container(
          width: mediaquerry.size.width * 0.4,
          height: mediaquerry.size.height * 0.05,
          decoration: BoxDecoration(
              border: Border.all(
                  width: 1,
                  color: Theme.of(context).textTheme.bodyText1!.color!),
              borderRadius: BorderRadius.circular(5)),
          child: CustomDropDownWidget(
            items: type,
            value: initialTypeValue,
            onChanged: (value) {
              typeChanged!(value);
            },
          ),
        )
      ],
    );
  }
}
