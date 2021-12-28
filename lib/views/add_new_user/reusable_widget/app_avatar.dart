import 'package:flutter/material.dart';
import 'package:insite/core/models/admin_manage_user.dart';
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
          widget.isSelected!
              ? Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        width: 2, color: Theme.of(context).buttonColor),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: FadeInImage(
                      image: NetworkImage(
                          widget.accessData!.application!.iconUrl! + "app.png",
                          headers: {
                            "Authorization":
                                "Bearer 9a26dae0b4bb70e9165cf204a3cc4ae7",
                          }),
                      placeholder: AssetImage(
                        "assets/images/add_user_icon_one.png",
                      ),
                      imageErrorBuilder: (context, error, stackTrace) {
                        Logger().e(error);
                        return Image.asset(
                            "assets/images/add_user_icon_one.png",
                            width: 45,
                            height: 45,
                            fit: BoxFit.fitWidth);
                      },
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Container(
                  width: 40,
                  height: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: FadeInImage(
                      image: NetworkImage(
                        widget.accessData!.application!.iconUrl! + "app.png",
                      ),
                      placeholder:
                          AssetImage("assets/images/add_user_icon_one.png"),
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                            "assets/images/add_user_icon_one.png",
                            width: 40,
                            height: 40,
                            fit: BoxFit.fitWidth);
                      },
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
          SizedBox(
            width: 8,
          ),
        ],
      ),
    );
  }
}
