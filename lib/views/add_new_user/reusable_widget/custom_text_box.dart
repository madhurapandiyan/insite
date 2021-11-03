import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';

class CustomTextBox extends StatelessWidget {
  final String title;
  final FocusNode focusNode;
  final TextEditingController controller;

  const CustomTextBox({this.title, this.controller,this.focusNode});

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      autofocus: false,
      controller: controller,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 14,
        fontStyle: FontStyle.normal,
        color: Theme.of(context).textTheme.bodyText1.color,
      ),
      cursorColor: addUserBgColor,
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
                color: Theme.of(context).textTheme.bodyText1.color,
              )),
          hintStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            fontStyle: FontStyle.normal,
            color: Theme.of(context).textTheme.bodyText1.color,
          )),
    );
  }
}
