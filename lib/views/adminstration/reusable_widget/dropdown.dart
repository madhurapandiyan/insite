import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class Dropdown extends StatefulWidget {
  List<String> maptype;
  String initialvalue;
  Function(String) changingvalue;

  Dropdown({this.maptype, this.initialvalue, this.changingvalue});

  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  @override
  Widget build(BuildContext context) {
    var mediaquerry = MediaQuery.of(context);
    return Container(
      // margin: EdgeInsets.only(left: 20, top: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Theme.of(context).cardColor,
      ),
      width: 118.23,
      height: mediaquerry.size.height * 0.05,
      padding: EdgeInsets.all(10),
      child: DropdownButton(
        dropdownColor: Theme.of(context).cardColor,
        icon: Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: Container(
            child: SvgPicture.asset(
              "assets/images/arrowdown.svg",
              width: 10,
              color: Theme.of(context).iconTheme.color,
              height: 10,
            ),
          ),
        ),
        isExpanded: true,
        hint: Text(
          widget.initialvalue,
          style: TextStyle(color: Theme.of(context).textTheme.bodyText1.color),
        ),
        items: widget.maptype
            .map((map) => DropdownMenuItem(
                  value: map,
                  child: InsiteText(
                    text: map,
                    size: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ))
            .toList(),
        value: widget.initialvalue,
        onChanged: (value) {
          setState(() {
            widget.initialvalue = value;
            widget.changingvalue(value);
          });
        },
        underline: Container(
            height: 1.0,
            decoration: BoxDecoration(
                border: Border(
                    bottom:
                        BorderSide(color: Colors.transparent, width: 0.0)))),
      ),
    );
  }
}
