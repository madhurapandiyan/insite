import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class NotificationWidget extends StatelessWidget {
  final String headerText;

  final VoidCallback onButtonClicked;

  const NotificationWidget({this.headerText, this.onButtonClicked});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.90,
        height: MediaQuery.of(context).size.height * 0.14,
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                SvgPicture.asset(
                  "assets/images/arrowdown.svg",
                  color: Theme.of(context).iconTheme.color,
                ),
                SizedBox(
                  width: 15,
                ),
                InsiteText(
                    text: headerText.toUpperCase(),
                    fontWeight: FontWeight.w700,
                    size: 14.0),
              ],
            ),
            Divider(
              thickness: 1,
              color: Theme.of(context).dividerColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InsiteButton(
                  width: MediaQuery.of(context).size.width * 0.40,
                  height: MediaQuery.of(context).size.height * 0.06,
                  onTap: () {
                    onButtonClicked();
                  },
                  title: "add".toUpperCase() +
                      "\n" +
                      "new notifications".toUpperCase(),
                  textColor: white,
                  fontSize: 10,
                ),
                InsiteButton(
                  width: MediaQuery.of(context).size.width * 0.40,
                  height: MediaQuery.of(context).size.height * 0.06,
                  onTap: () {
                    onButtonClicked();
                  },
                  title: "manage".toUpperCase() +
                      "\n" +
                      "notifications".toUpperCase(),
                  textColor: appbarcolor,
                  fontSize: 10,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
