import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class AssetCardsLarge extends StatefulWidget {
  final String icon;
  final String headerText;
  final double height;
  final List<AdminAssetsButtonType> buttonTitle;
  final Function(AdminAssetsButtonType value) onCallbackSelected;

  AssetCardsLarge(
      {this.icon,
      this.headerText,
      this.buttonTitle,
      this.onCallbackSelected,
      this.height});

  @override
  State<AssetCardsLarge> createState() => _AssetCardsLargeState();
}

class _AssetCardsLargeState extends State<AssetCardsLarge> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.45,
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
                    text: widget.headerText.toUpperCase(),
                    fontWeight: FontWeight.w700,
                    size: 14.0),
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
              color: Theme.of(context).iconTheme.color,
            ),
            SizedBox(
              height: widget.height,
            ),
            Flexible(
              child: ListView.builder(
                  itemCount: widget.buttonTitle.length,
                  itemBuilder: (builder, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: InsiteButton(
                        //width: MediaQuery.of(context).size.width * 0.004,
                          height: MediaQuery.of(context).size.height * 0.049,
                          margin: EdgeInsets.all(4),
                          title: Utils.getAdminModuleMenuTitle(
                              widget.buttonTitle[index]),
                          textColor: white,
                          fontSize: 10,
                          onTap: () {
                            AdminAssetsButtonType value =
                                widget.buttonTitle[index];
                            widget.onCallbackSelected(value);
                          }),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
