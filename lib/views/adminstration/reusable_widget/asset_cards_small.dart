import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class AssetCardsSmall extends StatefulWidget {
  final String icon;
  final String headerText;
  final double height;
  final bool showExapansionMenu;
  final List<AdminAssetsButtonType> buttonTitle;
  final Function(AdminAssetsButtonType value) onCallbackSelected;

  AssetCardsSmall(
      {this.icon,
      this.headerText,
      this.showExapansionMenu = true,
      this.buttonTitle,
      this.onCallbackSelected,
      this.height});

  @override
  State<AssetCardsSmall> createState() => _AssetCardsSmallState();
}

class _AssetCardsSmallState extends State<AssetCardsSmall> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.43,
        height: MediaQuery.of(context).size.height * 0.25,
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                widget.showExapansionMenu
                    ? SizedBox(
                        width: 10,
                      )
                    : SizedBox(),
                widget.showExapansionMenu
                    ? SvgPicture.asset(
                        "assets/images/arrowdown.svg",
                        color: Theme.of(context).iconTheme.color,
                      )
                    : SizedBox(),
                SizedBox(
                  width: 15,
                ),
                InsiteText(
                    text: widget.headerText.toUpperCase(),
                    fontWeight: FontWeight.w700,
                    size: 12.0),
              ],
            ),
            Divider(
              thickness: 1,
              color: thunder,
            ),
            SizedBox(
              height: 8,
            ),
            SvgPicture.asset(
              widget.icon,
              height: 24,
              width: 24,
              color: Theme.of(context).iconTheme.color,
            ),
            SizedBox(
              height: widget.height,
            ),
            Flexible(
              child: ListView.builder(
                  itemCount: widget.buttonTitle.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (builder, index) {
                    return InsiteButton(
                        height: MediaQuery.of(context).size.height * 0.043,
                        margin: EdgeInsets.all(4),
                        title: Utils.getAdminModuleMenuTitle(
                            widget.buttonTitle[index]),
                        textColor: white,
                        fontSize: 10,
                        onTap: () {
                          AdminAssetsButtonType value =
                              widget.buttonTitle[index];
                          widget.onCallbackSelected(value);
                        });
                  }),
            )
          ],
        ),
      ),
    );
  }
}
