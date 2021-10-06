import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';

class CustomListView extends StatefulWidget {
  final String text;

  final VoidCallback voidCallback;

  const CustomListView({this.text, this.voidCallback});

  @override
  _CustomListViewState createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset("assets/images/add_user_icon_one.png"),
        SizedBox(
          width: 8,
        ),
        Expanded(
            flex: 1,
            child: Text(
              widget.text,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: silver,
                  fontSize: 14,
                  fontStyle: FontStyle.normal),
            )),
        Padding(
          padding: const EdgeInsets.only(right: 30.0),
          child: IconButton(
              icon:  Icon(
                Icons.close,
                color: silver,
              ),
              onPressed: () {
                widget.voidCallback();
              }),
        ),
      ],
    );
  }
}
