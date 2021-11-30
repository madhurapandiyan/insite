import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class CustomTextBoxWithName extends StatelessWidget {
  final String title;
  final String text;
  final TextEditingController controller;
  final TextInputType textInputType;
  CustomTextBoxWithName(
      {this.title,
      this.text,
      this.controller,
      this.textInputType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      TextField(
        controller: controller,
        cursorColor: Theme.of(context).textTheme.bodyText1.color,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14,
          fontStyle: FontStyle.normal,
          color: Theme.of(context).textTheme.bodyText1.color,
        ),
        keyboardType: textInputType,
        decoration: InputDecoration(
            fillColor: black,
            hintText: title,
            contentPadding: EdgeInsets.only(left: 12, top: 8),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                    color: Theme.of(context).textTheme.bodyText1.color,
                    width: 1)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                    color: Theme.of(context).textTheme.bodyText1.color,
                    width: 1)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                    color: Theme.of(context).textTheme.bodyText1.color,
                    width: 1)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                    color: Theme.of(context).textTheme.bodyText1.color)),
            hintStyle: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              fontStyle: FontStyle.normal,
              color: Theme.of(context).textTheme.bodyText1.color,
            )),
      ),
      Positioned(
        right: 12,
        top: 12,
        child: Align(
          alignment: Alignment.topRight,
          child: InsiteText(
            text: text,
            fontWeight: FontWeight.w300,
            size: 14,
          ),
        ),
      )
    ]);
  }
}
