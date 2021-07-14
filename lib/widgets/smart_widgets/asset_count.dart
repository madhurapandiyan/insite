import 'package:flutter/material.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class AssetCountWidget extends StatelessWidget {
  final String count;
  final String title;
  const AssetCountWidget({this.count, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      margin: EdgeInsets.only(top: 8, left: 16, bottom: 8),
      child: Row(
        children: [
          InsiteText(
            text: count,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            size: 15,
          ),
          SizedBox(
            width: 10,
          ),
          InsiteText(
            text: title,
            color: Colors.white,
            size: 15,
            fontWeight: FontWeight.normal,
          )
        ],
      ),
    );
  }
}
