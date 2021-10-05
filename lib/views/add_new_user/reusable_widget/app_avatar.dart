import 'package:flutter/material.dart';
import 'package:insite/core/models/admin_manage_user.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/add_new_user/add_new_user_view.dart';

class AppAvatar extends StatefulWidget {
  final ApplicationAccess applicationAccess;
  final Function(bool value) isSelected;
  final bool isDataRemoved;
  final bool isBtnSelected;

  AppAvatar({this.isSelected, this.applicationAccess, this.isDataRemoved,this.isBtnSelected});

  @override
  _AppAvatarState createState() => _AppAvatarState();
}

class _AppAvatarState extends State<AppAvatar> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isSelected = !widget.isBtnSelected;
        isDataRemoved=false;
        print("isSelected:$isSelected");
        print("isDataRemoved:$isDataRemoved");
        

        widget.isSelected(isSelected);
        setState(() {});
      },
      child: Row(
        children: [
          isSelected && !isDataRemoved
              ? Container(
                  width: 43,
                  height: 43,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 2, color: textcolor),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: FadeInImage(
                      image: NetworkImage(
                          widget.applicationAccess.applicationIconUrl),
                      placeholder:
                          AssetImage("assets/images/add_user_icon_one.png"),
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                            "assets/images/add_user_icon_one.png",
                            fit: BoxFit.fitWidth);
                      },
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : ClipRRect(
                
                
                  borderRadius: BorderRadius.circular(30.0),
                  child: FadeInImage(
                    image: NetworkImage(
                        widget.applicationAccess.applicationIconUrl),
                    placeholder:
                        AssetImage("assets/images/add_user_icon_one.png"),
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset("assets/images/add_user_icon_one.png",
                          fit: BoxFit.fitWidth);
                    },
                    fit: BoxFit.cover,
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
