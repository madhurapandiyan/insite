import 'package:flutter/material.dart';
import 'package:insite/core/models/admin_manage_user.dart';
import 'package:insite/theme/colors.dart';
import 'package:logger/logger.dart';

class AppAvatar extends StatefulWidget {
  final ApplicationAccessData? accessData;
  final Function()? onSelect;
  final bool? isSelected;

  AppAvatar({this.isSelected, this.accessData, this.onSelect});

  @override
  _AppAvatarState createState() => _AppAvatarState();
}

class _AppAvatarState extends State<AppAvatar> {
  @override
  void initState() {
    super.initState();
    Logger().i("app avatar ${widget.accessData!.application!.iconUrl}");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.accessData!.isPermissionSelected!) {
          widget.onSelect!();
        }
      },
      child: Row(
        children: [
          Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                  color: widget.isSelected!
                      ? Theme.of(context).buttonColor.withOpacity(0.5)
                      : white,
                  borderRadius: BorderRadius.circular(8)),
              child: Image.network(
                widget.accessData!.application!.iconUrl!,
                errorBuilder: (context, error, stackTrace) {
                  Logger().e(error);
                  return Image.asset("assets/images/add_user_icon_one.png",
                      width: 45, height: 45, fit: BoxFit.fitWidth);
                },
              )),
          SizedBox(
            width: 8,
          ),
        ],
      ),
    );
  }
}
