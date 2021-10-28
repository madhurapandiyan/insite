import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final String hint;
  final bool obsecure;
  const LoginTextField(
      {Key key,
      this.controller,
      this.validator,
      this.hint,
      this.obsecure = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        validator: validator,
        obscureText: obsecure,
        style: TextStyle(color: maptextcolor),
        cursorColor: maptextcolor,
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
                color: maptextcolor),
            contentPadding: EdgeInsets.only(left: 25),
            border: OutlineInputBorder(),
            errorBorder: OutlineInputBorder()));
  }
}
