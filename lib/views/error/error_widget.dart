import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';

class ErrorWidget extends StatelessWidget {
  final String title;
  final String description;
  final String actionTitle;
  final String path;
  final bool showAction;
  final Function(ErrorAction) onTap;
  const ErrorWidget(
      {this.path,
      this.title,
      this.actionTitle,
      this.description,
      this.showAction,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
          ),
          SizedBox(
            height: 40,
          ),
          showAction
              ? InsiteButton(
                  title: "Login",
                  onTap: () {
                    onTap(ErrorAction.LOGIN);
                  },
                  bgColor: tango,
                  textColor: Colors.white,
                  height: 48,
                  width: 100,
                )
              : SizedBox()
        ],
      )),
    );
  }
}

