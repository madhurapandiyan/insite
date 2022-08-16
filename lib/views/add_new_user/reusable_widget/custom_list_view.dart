import 'package:flutter/material.dart';
import 'package:insite/core/models/admin_manage_user.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:logger/logger.dart';

class CustomListView extends StatefulWidget {
  final ApplicationAccessData? applicationAccessData;
  final String? text;
  final VoidCallback? voidCallback;

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
        "custom list view app avatar ${widget.applicationAccessData!.application!.iconUrl}");
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
              color: white, borderRadius: BorderRadius.circular(8)),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Image.network(
                widget.applicationAccessData!.application!.iconUrl!,
                errorBuilder: (context, error, stackTrace) {
                  Logger().e(error);
                  return Image.asset("assets/images/add_user_icon_one.png",
                      width: 45, height: 45, fit: BoxFit.fitWidth);
                },
              )),
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
                widget.voidCallback!();
              }),
        ),
      ],
    );
  }
}
