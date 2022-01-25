import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class AssetCardsLarge extends StatefulWidget {
  final String? icon;
  final String? headerText;
  final double? height;
  final List<AdminAssetsButtonType>? buttonTitle;
  final Function(AdminAssetsButtonType value)? onCallbackSelected;
  final bool showExapansionMenu;
  final double? cardHeight;
  final double? cardWidth;
  final Axis? scrollDirection;

  AssetCardsLarge(
      {this.icon,
      this.headerText,
      this.buttonTitle,
      this.showExapansionMenu = true,
      this.onCallbackSelected,
      this.height,
      this.cardHeight,
      this.cardWidth,
      this.scrollDirection});

  @override
  State<AssetCardsLarge> createState() => _AssetCardsLargeState();
}

class _AssetCardsLargeState extends State<AssetCardsLarge> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: widget.cardHeight,
        width: widget.cardWidth,
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
                    text: widget.headerText!.toUpperCase(),
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
              widget.icon!,
              color: Theme.of(context).iconTheme.color,
            ),
            SizedBox(
              height: widget.height,
            ),
            Flexible(
              child: ListView.builder(
                  itemCount: widget.buttonTitle!.length,
                  scrollDirection: widget.scrollDirection!,
                  itemBuilder: (builder, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: InsiteButton(
                          //width: MediaQuery.of(context).size.width * 0.004,
                          height: MediaQuery.of(context).size.height * 0.049,
                          margin: EdgeInsets.all(4),
                          title: Utils.getAdminModuleMenuTitle(
                              widget.buttonTitle![index]),
                          textColor: white,
                          fontSize: 10,
                          onTap: () {
                            AdminAssetsButtonType value =
                                widget.buttonTitle![index];
                            widget.onCallbackSelected!(value);
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
