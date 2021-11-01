import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class AssetSettingWidget extends StatelessWidget {
  final String headerText;
  final VoidCallback onButtonClicked;
  final String buttonText;
  const AssetSettingWidget(
      {this.headerText, this.onButtonClicked, this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.90,
        height: MediaQuery.of(context).size.height * 0.16,
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
            InsiteButton(
              width: MediaQuery.of(context).size.width * 0.71,
              height: MediaQuery.of(context).size.height * 0.05,
              title: buttonText.toUpperCase(),
              textColor: white,
              fontSize: 10,
              onTap: () {
                onButtonClicked();
              },
              margin: EdgeInsets.all(5),
            )
          ],
        ),
      ),
    );
  }
}
