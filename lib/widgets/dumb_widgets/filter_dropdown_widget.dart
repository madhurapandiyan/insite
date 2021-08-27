import 'package:flutter/material.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';

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
  FilterData dropDownvalue;

  @override
  void initState() {
    _list = widget.data;
    _displayList = _list;
    dropDownvalue = _displayList[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.46,
      height: MediaQuery.of(context).size.height * 0.062,
      decoration: BoxDecoration(
        border: Border.all(color: white),
        borderRadius: BorderRadius.all(Radius.circular(8)),
        // color: cardcolor
      ),
      child: Row(
        children: [
          DropdownButton(
              elevation: 16,
              dropdownColor: cardcolor,
              value: dropDownvalue,
              onChanged: (FilterData value) {
                dropDownvalue = value;
                widget.onValueSelected(value.title);
                setState(() {});
              },
              items: _displayList
                  .map<DropdownMenuItem<FilterData>>((FilterData value) {
                return DropdownMenuItem<FilterData>(
                    value: value,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: InsiteButton(
                            height: 27,
                            title: value.count,
                            bgColor: cardcolor,
                            textColor: silver,
                            fontSize: 10,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            value.title.toLowerCase(),
                            style: TextStyle(
                                color: silver,
                                fontSize: 11.0,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal),
                          ),
                        ),
                      ],
                    ));
              }).toList(),
              underline: Container(
                  height: 1.0,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.transparent, width: 0.0))))),
        ],
      ),
    );
  }
}
