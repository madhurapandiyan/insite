import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';

class CustomDropDownWidget extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String> onChanged;
  CustomDropDownWidget({this.value, this.items, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        isExpanded: true,
        icon: Icon(Icons.arrow_drop_down, color: Colors.white),
        dropdownColor: thunder,
        value: value,
        hint: Text(
          "Select",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              fontFamily: 'Roboto',
              color: appbarcolor,
              fontStyle: FontStyle.normal),
        ),
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Roboto',
                  color: appbarcolor,
                  fontStyle: FontStyle.normal),
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
