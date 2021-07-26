import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class PageHeader extends StatelessWidget {
  final int count;
  final int total;
  final bool isDashboard;
  const PageHeader({this.count, this.total, this.isDashboard});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // border: Border.all(width: 1, color: Colors.black),
          color: cardcolor,
          borderRadius: BorderRadius.all(Radius.circular(4))),
      margin: EdgeInsets.only(top: 16, left: 20, right: 20),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          InsiteText(
            text: isDashboard ? "$total assets" : "$count of $total assets",
            fontWeight: FontWeight.bold,
            color: Colors.white,
            size: 15,
          ),
        ],
      ),
    );
  }
}
