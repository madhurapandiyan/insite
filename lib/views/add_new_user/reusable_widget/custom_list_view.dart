import 'package:flutter/material.dart';
import 'package:insite/core/models/admin_manage_user.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
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
  void initState() {
    super.initState();
    Logger().i(
        "custom list view app avatar ${widget.applicationAccessData.application.iconUrl}");
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: FadeInImage(
            width: 36,
            height: 36,
            image: NetworkImage(
                widget.applicationAccessData.application.iconUrl + "app.png",
                headers: {
                  "Authorization": "Bearer 9a26dae0b4bb70e9165cf204a3cc4ae7",
                }),
            placeholder: AssetImage(
              "assets/images/add_user_icon_one.png",
            ),
            imageErrorBuilder: (context, error, stackTrace) {
              Logger().e(error);
              return Image.asset("assets/images/add_user_icon_one.png",
                  width: 36, height: 36, fit: BoxFit.none);
            },
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Expanded(
            flex: 1,
            child: InsiteText(
              text: widget.text,
              fontWeight: FontWeight.w700,
              size: 14,
            )),
        Padding(
          padding: const EdgeInsets.only(right: 30.0),
          child: IconButton(
              icon: Icon(
                Icons.close,
                color: Theme.of(context).iconTheme.color,
              ),
              onPressed: () {
                widget.voidCallback();
              }),
        ),
      ],
    );
  }
}
