import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/add_new_user/model_class/dropdown_model_class.dart';

class DropDownWidget extends StatelessWidget {
  final DropDownModelClass value;
  final List<DropDownModelClass> items;
  final ValueChanged<DropDownModelClass> onChanged;

  DropDownWidget({Key key, this.value, this.items, this.onChanged});

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
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Roboto',
                  color: appbarcolor,
                  fontStyle: FontStyle.normal),
            ),
            onChanged: onChanged,
            items: items.map<DropdownMenuItem<DropDownModelClass>>(
                (DropDownModelClass value) {
              return DropdownMenuItem<DropDownModelClass>(
                value: value,
                child: Text(
                  value.value,
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
                        bottom: BorderSide(
                            color: Colors.transparent, width: 0.0))))),
        Positioned(
          top: 12,
          right: 20,
          child: Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(
              "assets/images/arrowdown.svg",
              width: 10,
              height: 10,
            ),
          ),
        ),
      ],
    );
  }
}
