import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

import 'insite_progressbar.dart';

class LoadMore extends StatelessWidget {
  const LoadMore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      child: InsiteProgressBar(),
    );
  }
}

class LoadMoreText extends StatelessWidget {
  final VoidCallback? onClick;
  const LoadMoreText({this.onClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick!();
      },
      child: Container(
        height: 48,
        child: InsiteText(
          color: Theme.of(context).buttonColor,
          fontWeight: FontWeight.bold,
          text: "LOAD MORE",
        ),
      ),
    );
  }
}
