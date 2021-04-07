import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'insite_text.dart';

class InsiteTableRow extends StatelessWidget {
  final String title;
  final String content;
  const InsiteTableRow({this.title, this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InsiteText(
            text: title,
            color: athenGrey,
            fontWeight: FontWeight.bold,
          ),
          InsiteText(
            text: content,
            fontWeight: FontWeight.normal,
            color: textcolor,
          )
        ],
      ),
    );
  }
}
