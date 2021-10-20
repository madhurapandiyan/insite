import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class ReusableDropDown extends StatelessWidget {
  final String title;
  final String name;
  ReusableDropDown({this.title, this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 10,
        ),
        InsiteButton(
          height: 27,
          title: title,
          padding: EdgeInsets.all(4),
          bgColor: Theme.of(context).backgroundColor,
          fontSize: 11,
        ),
        SizedBox(
          width: 8,
        ),
        Expanded(
          flex: 1,
          child: new InsiteText(
            text: name,
            size: 10.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.all(5.0),
        //   child: Icon(
        //     Icons.arrow_drop_down,
        //     color: Colors.grey,
        //   ),
        // ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
