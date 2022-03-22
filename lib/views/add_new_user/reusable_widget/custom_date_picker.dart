import 'package:flutter/material.dart';

class CustomDatePicker extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback? voidCallback;
  final String? initialText;
  const CustomDatePicker(
      {this.controller, this.voidCallback, this.initialText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w900,
          color: Theme.of(context).textTheme.bodyText1!.color),
      decoration: InputDecoration(
        hintText: initialText == null ? "DD/MM/YYYY" : initialText,
        hintStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: Theme.of(context).textTheme.bodyText1!.color),
        suffixIcon: IconButton(
            padding: EdgeInsets.only(bottom: 3.0),
            icon: Icon(
              Icons.calendar_today,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () {
              voidCallback!();
            }),
        border: InputBorder.none,
      ),
      readOnly: true,
    );
  }
}
