import 'package:flutter/material.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';

class FilterDropDownWidget extends StatefulWidget {
  final List<FilterData> data;
  final Function(FilterData) onValueSelected;

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
        border: Border.all(color: Theme.of(context).textTheme.bodyText1.color),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: DropdownButton(
          elevation: 16,
          dropdownColor: Theme.of(context).backgroundColor,
          value: dropDownvalue,
          icon: Icon(
            Icons.arrow_drop_down,
            color: Theme.of(context).iconTheme.color,
          ),
          onChanged: (FilterData value) {
            dropDownvalue = value;
            widget.onValueSelected(value);
            setState(() {});
          },
          // selectedItemBuilder: (context) {},
          items: _displayList
              .map<DropdownMenuItem<FilterData>>((FilterData value) {
            return DropdownMenuItem<FilterData>(
                value: value,
                child: Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                      child: InsiteButton(
                        width: 50,
                        title: value.count,
                        padding: EdgeInsets.all(4),
                        bgColor: Theme.of(context).backgroundColor,
                        fontSize: 10,
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      value.title,
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1.color,
                          fontSize: 10.0,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal),
                    ),
                  ],
                ));
          }).toList(),
          underline: Container(
              height: 1.0,
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Colors.transparent, width: 0.0))))),
    );
  }
}
