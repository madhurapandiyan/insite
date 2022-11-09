import 'package:flutter/material.dart';
import 'package:insite/core/flavor/flavor.dart';
import 'package:insite/core/models/admin_manage_user.dart';
import 'package:insite/theme/colors.dart';
import 'package:logger/logger.dart';

class AppAvatar extends StatefulWidget {
  final ApplicationAccessData? accessData;
  final Function()? onSelect;
  final bool? isSelected;
  int? index;

  AppAvatar({this.isSelected, this.accessData, this.onSelect,this.index});

  @override
  _AppAvatarState createState() => _AppAvatarState();
}

class _AppAvatarState extends State<AppAvatar> {
  List<String>? applicationPermissionaccessIcon = [
    "assets/images/ic_fleet.png",
    "assets/images/health_icon.png",
    "assets/images/ic_admin-setting-icon.png"
  ];
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
              child: AppConfig.instance!.productFlavor == "worksiq"
                  ? Image.asset(
                      applicationPermissionaccessIcon![widget.index!],
                      width: 30,
                      height: 30,
                    )
                  : Image.network(
                      widget.accessData!.application!.iconUrl!,
                      errorBuilder: (context, error, stackTrace) {
                        Logger().e(error);
                        return Image.asset(
                            "assets/images/add_user_icon_one.png",
                            width: 45,
                            height: 45,
                            fit: BoxFit.fitWidth);
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
