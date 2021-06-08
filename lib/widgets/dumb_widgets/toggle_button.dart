import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';

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
      width: 130,
      height: 30,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isOptionOneSelected = true;
                  widget.optionSelected(isOptionOneSelected);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isOptionOneSelected ? tango : cardcolor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(4),
                    topLeft: Radius.circular(4),
                  ),
                ),
                child: Center(
                  child: Text(
                    'List'.toUpperCase(),
                    style: TextStyle(
                      color: white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isOptionOneSelected = false;
                  widget.optionSelected(isOptionOneSelected);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isOptionOneSelected ? cardcolor : tango,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(4),
                    topRight: Radius.circular(4),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Graph'.toUpperCase(),
                    style: TextStyle(
                      color: white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
