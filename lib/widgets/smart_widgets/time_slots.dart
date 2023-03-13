import 'package:flutter/material.dart';
import 'package:insite/core/models/user_preference.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_dropdown_widget.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:logger/logger.dart';
import '../dumb_widgets/insite_text.dart';

class TimeSlots extends StatelessWidget {
  TimeOfDay? endValue;
  TimeOfDay? initialvalue;
  final UserPreference? userPreference;
  final List<String>? type;
  final bool? isSelected;
  final Function(String?, TimeOfDay?)? startTimeChanged;
  final Function(String?)? typeChanged;
  final Function(String?, TimeOfDay?)? endTimeChanged;
  final String? initialTypeValue;
  final String? initialStartValue;
  final String? initialEndValue;
  final Function(bool)? onSwitchChange;

  TimeSlots(
      {this.endValue,
      this.initialvalue,
      this.userPreference,
      this.type,
      this.startTimeChanged,
      this.endTimeChanged,
      this.initialTypeValue,
      this.initialEndValue,
      this.initialStartValue,
      this.typeChanged,
      this.isSelected,
      this.onSwitchChange});

  showTimePickerWidget(Function(String, TimeOfDay) callBack, BuildContext ctx,
      TimeOfDay initialTime) {
    showTimePicker(
            builder: (context, child) {
              return child!;
            },
            context: ctx,
            initialTime: initialTime)
        .then((value) {
      Logger().v("value:$value");
      final hours =
          // value!.hour.toString().padLeft(2, '0');
          Utils.switchTimeFormat(time: value, userPreference: userPreference);

      final minutes = value!.minute.toString().padLeft(2, '0');

      var data = TimeOfDay(hour: value.hour, minute: value.minute).format(ctx);
      Logger().wtf(data);

      // callBack(Utils.getTimeAbbre(
      //     hours: hours,
      //     minutes: minutes,
      //     userPreference: userPreference,
      //     selectedTime: data));

      // callBack(Utils.getTime(hours: hours,minutes: minutes,time: value,userPreference: userPreference));
      callBack('$hours:$minutes', value);
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
            Logger().d(initialvalue);
            showTimePickerWidget(startTimeChanged!, context, initialvalue!);
          },
        ),
        InsiteButton(
          bgColor: Theme.of(context).cardColor,
          width: 100,
          title: initialEndValue,
          onTap: () {
            Logger().d(endValue);
            showTimePickerWidget(endTimeChanged!, context, endValue!);
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
