import 'package:flutter/material.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/theme/colors.dart';

class FilterDropDownWidget extends StatefulWidget {
  final List<FilterData> data;
  final Function(String) onValueSelected;

  FilterDropDownWidget({this.data, this.onValueSelected});

  @override
  _FilterDropDownWidgetState createState() => _FilterDropDownWidgetState();
}

class _FilterDropDownWidgetState extends State<FilterDropDownWidget> {
  List<FilterData> _list = [];
  List<FilterData> _displayList = [];
  String dropDownvalue;

  @override
  void initState() {
    super.initState();
    _list = widget.data;
    _displayList = _list;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * .06,
          decoration: BoxDecoration(
            border: Border.all(color: white),
            borderRadius: BorderRadius.all(Radius.circular(8)),
            // color: cardcolor
          ),
          child: Row(
            children: [
              SizedBox(
                width: 6,
              ),
              Icon(
                Icons.settings,
                color: white,
              ),
              VerticalDivider(
                thickness: 1,
                color: silver,
              ),
              SizedBox(
                width: 10,
              ),
              DropdownButton(
                  hint: Text(
                    "Select",
                    style: TextStyle(
                        color: silver,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal),
                  ),
                  elevation: 16,
                  dropdownColor: cardcolor,
                  value: dropDownvalue,
                  onChanged: (value) {
                    dropDownvalue = value;
                    widget.onValueSelected(value);
                    setState(() {});
                  },
                  items: _displayList
                      .map<DropdownMenuItem<String>>((FilterData value) {
                    return DropdownMenuItem<String>(
                      value: value.title,
                      child: Text(
                        value.count + " " + value.title,
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
        ),
      ],
    );
  }
}
