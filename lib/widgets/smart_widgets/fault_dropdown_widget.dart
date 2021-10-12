import 'package:flutter/material.dart';

class FaultDropDown extends StatefulWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String> onChanged;
  FaultDropDown({this.items, this.value, this.onChanged});

  @override
  _FaultDropDownState createState() => _FaultDropDownState();
}

class _FaultDropDownState extends State<FaultDropDown> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * .06,
          decoration: BoxDecoration(
            border:
                Border.all(color: Theme.of(context).textTheme.bodyText1.color),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 6,
              ),
              Image.asset(
                "assets/images/fault_world.png",
                color: Theme.of(context).iconTheme.color,
              ),
              VerticalDivider(
                thickness: 1,
                color: Theme.of(context).dividerColor,
              ),
              SizedBox(
                width: 10,
              ),
              DropdownButton(
                  elevation: 16,
                  dropdownColor: Theme.of(context).backgroundColor,
                  value: widget.value,
                  onChanged: widget.onChanged,
                  items: widget.items
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1.color,
                            fontSize: 10.0,
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
        ),
        // Row(
        //   children: [
        //     SvgPicture.asset(
        //       "assets/images/arrowdown.svg",
        //       width: 10,
        //       height: 10,
        //     ),
        //     SizedBox(
        //       width: 10,
        //     )
        //   ],
        // ),
      ],
    );
  }
}
