import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class PageHeader extends StatelessWidget {
  final int count;
  final int total;
  final bool isDashboard;
  final ScreenType screenType;
  final EdgeInsets margin;
  final EdgeInsets padding;
  const PageHeader(
      {this.count,
      this.total,
      this.isDashboard,
      this.margin,
      this.padding,
      this.screenType});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // border: Border.all(width: 1, color: Colors.black),
          color: Theme.of(context).backgroundColor,
          border:
              Border.all(color: Theme.of(context).textTheme.bodyText1.color),
          borderRadius: BorderRadius.all(Radius.circular(4))),
      margin: margin != null
          ? margin
          : EdgeInsets.only(top: 16, left: 20, right: 20),
      padding: padding != null ? padding : EdgeInsets.all(8),
      child: Row(
        children: [
          InsiteText(
            text: screenType == ScreenType.HEALTH
                ? isDashboard
                    ? "$total faults"
                    : "$count of $total faults"
                : isDashboard
                    ? "$total assets"
                    : "$count of $total assets",
            fontWeight: FontWeight.bold,
            size: 15,
          ),
        ],
      ),
    );
  }
}
