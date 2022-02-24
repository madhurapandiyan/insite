import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class NotificationWidget extends StatelessWidget {
  final String? headerText;
  final bool? showExapansionMenu;
  final Function(AdminAssetsButtonType value)? onAddButtonClicked;
  final Function(AdminAssetsButtonType value)? onManageButtonClicked;

  final String? icon;

  const NotificationWidget(
      {this.headerText,
      this.icon,
      this.showExapansionMenu,
      this.onManageButtonClicked,
      this.onAddButtonClicked});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.90,
        height: MediaQuery.of(context).size.height * 0.23,
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
                showExapansionMenu!
                    ? SvgPicture.asset(
                        "assets/images/arrowdown.svg",
                        color: Theme.of(context).iconTheme.color,
                      )
                    : SizedBox(),
                SizedBox(
                  width: 15,
                ),
                InsiteText(
                    text: headerText!.toUpperCase(),
                    fontWeight: FontWeight.w700,
                    size: 14.0),
              ],
            ),
            Divider(
              thickness: 1,
              color: Theme.of(context).dividerColor,
            ),
            SizedBox(
              height: 8,
            ),
            SvgPicture.asset(
              icon!,
              height: 24,
              width: 24,
              color: Theme.of(context).iconTheme.color,
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InsiteButton(
                  width: MediaQuery.of(context).size.width * 0.40,
                  height: MediaQuery.of(context).size.height * 0.06,
                  onTap: () {
                    AdminAssetsButtonType value =
                        AdminAssetsButtonType.values[24];
                    onAddButtonClicked!(value);
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
                    AdminAssetsButtonType value =
                        AdminAssetsButtonType.values[25];
                    onAddButtonClicked!(value);
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
