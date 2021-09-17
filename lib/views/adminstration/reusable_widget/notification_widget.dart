import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';

class NotificationWidget extends StatelessWidget {
  final String headerText;

  final VoidCallback onButtonClicked;

  const NotificationWidget({this.headerText, this.onButtonClicked});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.90,
      height: MediaQuery.of(context).size.height * 0.14,
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
                headerText.toUpperCase(),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InsiteButton(
                width: MediaQuery.of(context).size.width * 0.40,
                height: MediaQuery.of(context).size.height * 0.06,
                bgColor: tango,
                onTap: () {
                  onButtonClicked();
                },
                title: "add".toUpperCase() +
                    "\n" +
                    "new notifications".toUpperCase(),
                textColor: appbarcolor,
                fontSize: 14,
              ),
              InsiteButton(
                width: MediaQuery.of(context).size.width * 0.40,
                height: MediaQuery.of(context).size.height * 0.06,
                bgColor: tango,
                onTap: () {
                  onButtonClicked();
                },
                title: "manage".toUpperCase() +
                    "\n" +
                    "notifications".toUpperCase(),
                textColor: appbarcolor,
                fontSize: 14,
              )
            ],
          )
        ],
      ),
    );
  }
}
