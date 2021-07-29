import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/theme/colors.dart';

class FaultDropDown extends StatefulWidget {
  // const FaultDropDown({ Key? key }) : super(key: key);

  @override
  _FaultDropDownState createState() => _FaultDropDownState();
}

class _FaultDropDownState extends State<FaultDropDown> {
  String dropDownValue = '(2334) ALL ASSETS';
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: 6,
            ),
            Image.asset("assets/images/fault_world.png"),
            VerticalDivider(
              thickness: 1,
              color: silver,
            ),
            SizedBox(
              width: 10,
            ),
            DropdownButton(
                icon: Visibility(
                  visible: false,
                  child: Icon(Icons.arrow_downward),
                ),
                elevation: 16,
                dropdownColor: cardcolor,
                value: dropDownValue,
                onChanged: (String newValue) {
                  setState(() {
                    dropDownValue = newValue;
                  });
                },
                items: <String>[
                  '(2334) ALL ASSETS',
                  '(2335) ALL DATA',
                  '(2336) ALL DETAILS',
                  'Four'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                          color: silver,
                          fontSize: 11.0,
                          fontWeight: FontWeight.w700,
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
          ],
        ),
        Row(
          children: [
            Container(
              child: SvgPicture.asset(
                "assets/images/arrowdown.svg",
                width: 10,
                height: 10,
              ),
            )
          ],
        )
      ],
    );
  }
}
