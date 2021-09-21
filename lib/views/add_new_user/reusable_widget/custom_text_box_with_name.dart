import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';

class CustomTextBoxWithName extends StatelessWidget {
  final String title;
  final String text;
  final TextEditingController controller;

  CustomTextBoxWithName({this.title, this.text, this.controller});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      TextField(
        controller: controller,
        cursorColor: black,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14,
          fontStyle: FontStyle.normal,
          color: textcolor,
        ),
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
      ),
      Positioned(
        right: 12,
        top: 12,
        child: Align(
          alignment: Alignment.topRight,
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.italic,
              fontSize: 14,
              color: textcolor,
            ),
          ),
        ),
      )
    ]);
  }
}
