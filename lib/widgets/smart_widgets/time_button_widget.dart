import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';

class ButtonHeaderWidget extends StatelessWidget {
  final String? text;
  final VoidCallback? onClicked;

  const ButtonHeaderWidget({
    this.text,
    this.onClicked,
  });

  @override
  Widget build(BuildContext context) => HeaderWidget(
        child: ButtonWidget(
          text: text!,
          onClicked: onClicked!,
        ),
      );
}

class ButtonWidget extends StatelessWidget {
  final String? text;
  final VoidCallback? onClicked;

  const ButtonWidget({
    this.text,
    this.onClicked,
  });

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(40),
          primary: backgroundColor3,
        ),
        child: FittedBox(
          child: Text(
            text!,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        onPressed: onClicked,
      );
}

class HeaderWidget extends StatelessWidget {
  final Widget? child;

  const HeaderWidget({
    this.child,
  });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          child!,
        ],
      );
}
