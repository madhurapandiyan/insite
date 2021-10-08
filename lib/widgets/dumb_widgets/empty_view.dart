import 'package:flutter/material.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class EmptyView extends StatelessWidget {
  final String title;
  final Color bg;
  const EmptyView({this.title, this.bg});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bg != null ? bg : Theme.of(context).backgroundColor,
      alignment: Alignment.center,
      child: Center(
          child: InsiteTextAlign(
              text: title,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.bold,
              size: 18)),
    );
  }
}
