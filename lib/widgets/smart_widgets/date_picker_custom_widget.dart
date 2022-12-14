import 'package:flutter/material.dart';
import 'package:insite/core/models/user_preference.dart';
import 'package:insite/utils/helper_methods.dart';

class CustomDatePicker extends StatelessWidget {
  final UserPreference? userPreference;
  final TextEditingController? controller;
  final VoidCallback? voidCallback;
  const CustomDatePicker({this.controller, this.voidCallback,this.userPreference});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w900,
          color: Theme.of(context).textTheme.bodyText1!.color),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
        hintText:  Utils.getDateFormat(userPreference?.dateFormat)?.toUpperCase(),
        hintStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).textTheme.bodyText1!.color),
        suffixIcon: IconButton(
          padding: EdgeInsets.zero,
            icon: Icon(
              Icons.today,
              color: Theme.of(context).iconTheme.color,
              size: 14,
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
