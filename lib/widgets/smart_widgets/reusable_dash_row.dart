import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/core/models/subscription_dashboard.dart';

class InsiteDashRow extends StatelessWidget {
  const InsiteDashRow({Key key, this.name, this.count, this.filter})
      : super(key: key);
  final String name;
  final String count;
  final String filter;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 51,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InsiteText(
                  text: name,
                  fontWeight: FontWeight.w700,
                  size: 12.0,
                ),
                InsiteButton(
                  fontSize: 13,
                  width: 92,
                  height: 29,
                  textColor: white,
                  title: count,
                  onTap: () {},
                ),
              ],
            ),
            Divider(
              color: thunder,
              thickness: 0.5,
            )
          ],
        ),
      ),
    );
  }
}
