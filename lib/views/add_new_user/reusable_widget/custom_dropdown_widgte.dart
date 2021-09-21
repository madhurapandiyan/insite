import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/theme/colors.dart';

class CustomDropDownWidget extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String> onChanged;
  CustomDropDownWidget({this.value, this.items, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DropdownButton(
            icon: Visibility(visible: false, child: Icon(Icons.arrow_downward)),
            dropdownColor: thunder,
            value: value,
            hint: Text(
              "Select",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
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
                      fontWeight: FontWeight.w900,
                      color: appbarcolor,
                      fontStyle: FontStyle.normal),
                ),
              );
            }).toList(),
            underline: Container(
                height: 1.0,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Colors.transparent, width: 0.0))))),
        Positioned(
          top: 12,
          right: 8,
          child: Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              child: SvgPicture.asset(
                "assets/images/arrowdown.svg",
                width: 10,
                height: 10,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
