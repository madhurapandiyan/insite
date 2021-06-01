import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';

class SearchBox extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onTextChanged;
  final String hint;
  const SearchBox({this.hint, this.controller, this.onTextChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: (vale) {
        // onTextChanged(vale);
      },
      style: TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      decoration: InputDecoration(
          fillColor: black,
          hintText: hint,
          contentPadding: EdgeInsets.all(16),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.white, width: 1)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.white, width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.white, width: 1)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.white)),
          hintStyle: TextStyle(color: Colors.white)),
    );
  }
}
