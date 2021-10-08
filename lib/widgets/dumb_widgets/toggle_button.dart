import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';

import 'insite_text.dart';

class ToggleButton extends StatefulWidget {
  final String label1;
  final String label2;
  final Function optionSelected;
  const ToggleButton(
      {Key key,
      @required this.label1,
      @required this.label2,
      @required this.optionSelected})
      : super(key: key);

  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  bool isOptionOneSelected = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isOptionOneSelected = true;
                widget.optionSelected(isOptionOneSelected);
              });
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).textTheme.bodyText1.color),
                color: isOptionOneSelected
                    ? Theme.of(context).buttonColor
                    : Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(4),
                  topLeft: Radius.circular(4),
                ),
              ),
              padding: EdgeInsets.all(4),
              child: Center(
                child: InsiteText(
                  text: widget.label1.toUpperCase(),
                  color: isOptionOneSelected ? white : null,
                  size: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isOptionOneSelected = false;
                widget.optionSelected(isOptionOneSelected);
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: isOptionOneSelected
                    ? Theme.of(context).backgroundColor
                    : Theme.of(context).buttonColor,
                border: Border.all(
                    color: Theme.of(context).textTheme.bodyText1.color),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
              ),
              padding: EdgeInsets.all(4),
              child: Center(
                child: InsiteText(
                  text: widget.label2.toUpperCase(),
                  color: isOptionOneSelected ? null : white,
                  size: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
