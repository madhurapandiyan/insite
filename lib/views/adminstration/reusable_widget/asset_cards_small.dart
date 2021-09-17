import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';

class AssetCardsSmall extends StatefulWidget {
  final String icon;
  final String headerText;
  final List<AdminAssetsButtonType> buttonTitle;
  final Function(AdminAssetsButtonType) onCallbackSelected;

  AssetCardsSmall(
      {this.icon, this.headerText, this.buttonTitle, this.onCallbackSelected});

  @override
  State<AssetCardsSmall> createState() => _AssetCardsSmallState();
}

class _AssetCardsSmallState extends State<AssetCardsSmall> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.43,
      height: MediaQuery.of(context).size.height * 0.28,
      decoration: BoxDecoration(
        boxShadow: [new BoxShadow(blurRadius: 1.0, color: tuna)],
        border: Border.all(width: 2.5, color: tuna),
        borderRadius: BorderRadius.circular(10),
        shape: BoxShape.rectangle,
      ),
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
              SvgPicture.asset("assets/images/arrowdown.svg"),
              SizedBox(
                width: 15,
              ),
              Text(
                widget.headerText.toUpperCase(),
                style: new TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Roboto',
                    color: textcolor,
                    fontStyle: FontStyle.normal,
                    fontSize: 14.0),
              ),
            ],
          ),
          Divider(
            thickness: 1,
            color: thunder,
          ),
          SizedBox(
            height: 8,
          ),
          SvgPicture.asset(widget.icon),
          SizedBox(
            height: 10,
          ),
          Flexible(
            child: ListView.builder(
                itemCount: 2,
                itemBuilder: (builder, index) {
                  return InsiteButton(
                    height: MediaQuery.of(context).size.height * 0.043,
                    bgColor: tango,
                    margin: EdgeInsets.all(5),
                    title: widget.buttonTitle[index].toString().split('.').last,
                    textColor: appbarcolor,
                    fontSize: 14,
                    onTap: () {
                      widget
                          .onCallbackSelected(AdminAssetsButtonType.ADDNEWUSER);
                      widget
                          .onCallbackSelected(AdminAssetsButtonType.MANAGEUSER);
                      widget.onCallbackSelected(
                          AdminAssetsButtonType.ADDNEWGROUPS);
                      widget.onCallbackSelected(
                          AdminAssetsButtonType.MANAGEGROUPS);
                      widget.onCallbackSelected(
                          AdminAssetsButtonType.ADDNEWGEOFENCES);
                      widget.onCallbackSelected(
                          AdminAssetsButtonType.MANAGEGEOFENCES);
                      widget.onCallbackSelected(
                          AdminAssetsButtonType.ADDNEWREPORT);
                      widget.onCallbackSelected(
                          AdminAssetsButtonType.MANAGEREPORTS);
                    },
                  );
                }),
          )
        ],
      ),
    );
  }
}
