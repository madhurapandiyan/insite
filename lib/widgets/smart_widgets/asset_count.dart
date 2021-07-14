import 'package:flutter/material.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class AssetCountWidget extends StatelessWidget {
  final String count;
  final String title;
  const AssetCountWidget({this.count, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          InsiteText(
            text: count,
            fontWeight: FontWeight.bold,
            size: 15,
          ),
          InsiteText(
            text: title,
            size: 15,
            fontWeight: FontWeight.normal,
          )
        ],
      ),
    );
  }
}
