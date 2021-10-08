import 'package:flutter/material.dart';
import 'package:insite/core/models/admin_manage_user.dart';
import 'package:insite/theme/colors.dart';
import 'package:logger/logger.dart';

class CustomListView extends StatefulWidget {
  final ApplicationAccessData applicationAccessData;

  final String text;

  final VoidCallback voidCallback;

  const CustomListView(
      {this.text, this.voidCallback, this.applicationAccessData});

  @override
  _CustomListViewState createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: FadeInImage(
            image: NetworkImage(
                widget.applicationAccessData.application.iconUrl + "active.png",
                headers: {
                  "Authorization": "Bearer 9a26dae0b4bb70e9165cf204a3cc4ae7",
                }),
            placeholder: AssetImage(
              widget.applicationAccessData.application.iconUrl + "active.png",
            ),
            imageErrorBuilder: (context, error, stackTrace) {
              Logger().e(error);
              return Image.asset("assets/images/add_user_icon_one.png",
                  fit: BoxFit.fitWidth);
            },
            fit: BoxFit.cover,
          ),
        ),
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
              icon: Icon(
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
