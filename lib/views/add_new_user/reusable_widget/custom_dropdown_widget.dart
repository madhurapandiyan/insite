import 'package:flutter/material.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class CustomDropDownWidget extends StatelessWidget {
  final String? value;
  final List<String?>? items;
  final bool? istappable;
  final FocusNode? onFocus;
  final bool enableHint;
  final bool textColorChange;
  final Function? onTap;
  final String? selectedValue;

  //final ValueChanged<String> onChanged;
  CustomDropDownWidget(
      {this.value,
      this.items,
      this.onChanged,
      this.istappable,
      this.onFocus,
      this.isEnabled = true,
      this.textColorChange = false,
      this.enableHint = true,
      this.onTap,
      this.selectedValue});
  final Function(String?)? onChanged;
  //CustomDropDownWidget({this.value, this.items, this.onChanged});
  bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
//onChanged: onChanged,
        onTap: () {
          if (onTap == null) {
            return null;
          } else {
            onTap!();
          }
        },
        focusNode: onFocus,
        isExpanded: true,
        dropdownColor: Theme.of(context).backgroundColor,
        icon: Icon(Icons.arrow_drop_down,
            color: Theme.of(context).textTheme.bodyText1!.backgroundColor),
        value: value,
        onChanged: istappable == null || istappable == true ? onChanged : null,
        hint: enableHint
            ? InsiteText(
                text: selectedValue != null ? selectedValue : "Select",
                size: 14,
                fontWeight: FontWeight.w700,
                color: textColorChange
                    ? Colors.grey
                    : Theme.of(context).textTheme.bodyText1!.color!,
              )
            : SizedBox(),
        items: items!.map<DropdownMenuItem<String>>((String? value) {
          return DropdownMenuItem<String>(
            value: value,
            child: FittedBox(
              child: InsiteText(
                text: "  " + value!,
                size: 14,
                fontWeight: FontWeight.w700,
                // Theme.of(context).backgroundColor
                color: textColorChange
                    ? Colors.grey
                    : Theme.of(context).textTheme.bodyText1!.color!,
              ),
            ),
          );
        }).toList(),
        underline: Container(
            height: 1.0,
            decoration: BoxDecoration(
                border: Border(
                    bottom:
                        BorderSide(color: Colors.transparent, width: 0.0)))));
  }
}
