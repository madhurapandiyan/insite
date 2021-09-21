import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';

class CustomTextBox extends StatelessWidget {
  final String title;
  final TextEditingController controller;

  const CustomTextBox({this.title, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 14,
        fontStyle: FontStyle.normal,
        color: textcolor,
      ),
      cursorColor: addUserBgColor,
      decoration: InputDecoration(
          fillColor: black,
          hintText: title,
          contentPadding: EdgeInsets.only(left: 12, top: 8),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: black, width: 1)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: black, width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: black, width: 1)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: black)),
          hintStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            fontStyle: FontStyle.normal,
            color: textcolor,
          )),
    );
  }
}
