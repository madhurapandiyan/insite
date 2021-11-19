import 'package:flutter/material.dart';

class CustomDatePicker extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback voidCallback;
  const CustomDatePicker({this.controller, this.voidCallback});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w900,
          color: Theme.of(context).textTheme.bodyText1.color),
      decoration: InputDecoration(
        hintText: "  MM/DD/YYYY",
        hintStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).textTheme.bodyText1.color),
        suffixIcon: IconButton(
            padding: EdgeInsets.only(bottom: 3.0),
            icon: Icon(
              Icons.today,
              color: Theme.of(context).iconTheme.color,
              size: 14,
            ),
            onPressed: () {
              voidCallback();
            }),
        border: InputBorder.none,
      ),
      readOnly: true,
    );
  }
}
