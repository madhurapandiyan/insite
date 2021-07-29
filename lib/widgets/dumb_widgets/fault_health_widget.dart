import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';

class FaultWidget extends StatefulWidget {
 final String containerText;
  final String level;
  final String buttonText;
  final Color buttonColor;

  FaultWidget(
      {this.containerText,  this.level, this.buttonText, this.buttonColor});


  @override
  _FaultWidgetState createState() => _FaultWidgetState();
}

class _FaultWidgetState extends State<FaultWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InsiteButton(
          textColor: silver,
          bgColor: darkGrey,
          title: widget.containerText,
          width: 51,
          height: 27,
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          flex: 1,
          child: Text(
            widget.level,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: 'Roboto',
                color: textcolor,
                fontStyle: FontStyle.normal,
                fontSize: 14.0),
          ),
        ),
        InsiteButton(
          bgColor: widget.buttonColor,
          title: widget.buttonText,
          textColor: darkGrey,
          width: 61,
          height: 28,
        )
      ],
    );
  }
}
