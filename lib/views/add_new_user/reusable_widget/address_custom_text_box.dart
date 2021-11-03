import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';

class AddressCustomTextBox extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final FocusNode focusNode;

  AddressCustomTextBox({this.controller, this.title, this.focusNode});

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      autofocus: false,
      maxLines: 5,
      controller: controller,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 14,
        fontStyle: FontStyle.normal,
        color: Theme.of(context).textTheme.bodyText1.color,
      ),
      cursorColor: black,
      decoration: InputDecoration(
          fillColor: black,
          hintText: title,
          contentPadding: EdgeInsets.only(left: 15, top: 20),
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
            color: Theme.of(context).textTheme.bodyText1.color,
          )),
    );
  }
}
