import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class CustomDropDownWidget extends StatelessWidget {
  final String value;
  final List<String> items;
  final bool istappable;

  final FocusNode onFocus;

  //final ValueChanged<String> onChanged;
  CustomDropDownWidget(
      {this.value, this.items, this.onChanged, this.istappable, this.onFocus});
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        focusNode: onFocus,
        isExpanded: true,
        dropdownColor: Theme.of(context).backgroundColor,
        icon: Icon(Icons.arrow_drop_down,
            color: Theme.of(context).textTheme.bodyText1.backgroundColor),
        value: value,
        // hint: InsiteText(
        //   text: "  Select",
        //   size: 14,
        //   fontWeight: FontWeight.w700,
        // ),
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: InsiteText(
              text: "  " + value,
              size: 14,
              fontWeight: FontWeight.w700,
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
