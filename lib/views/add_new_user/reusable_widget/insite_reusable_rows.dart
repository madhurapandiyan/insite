import 'package:flutter/material.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class InsitePopupRow extends StatelessWidget {
  const InsitePopupRow({this.title, this.value});
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InsiteText(
          text: title,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(
          height: 5,
        ),
        InsiteText(
          text: value,
        ),
      ],
    );
  }
}
