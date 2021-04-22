import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/dialog.dart';
import 'package:insite/views/appbar/appbar_view_model.dart';
import 'package:insite/views/home/home_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_image.dart';
import 'package:stacked/stacked.dart';

class InsiteAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ScreenType screenType;
  final double height;
  final bool isSearchSelected;
  final VoidCallback onSearchTap;
  InsiteAppBar({
    this.screenType,
    this.isSearchSelected,
    this.onSearchTap,
    this.height,
  });
  @override
  Size get preferredSize => Size.fromHeight(height);

  var searchBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(16.0)),
    borderSide: BorderSide(
      color: Colors.transparent,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppbarViewModel>.reactive(
      viewModelBuilder: () => AppbarViewModel(),
      builder: (BuildContext context, AppbarViewModel viewModel, Widget _) {
        return AppBar(
          backgroundColor: appbarcolor,
          leading: IconButton(
              icon: SvgPicture.asset("assets/images/menubar.svg"),
              onPressed: () {
                print("button is tapped");
                viewModel.onHomePressed();
              }),
          title: InsiteImage(
            height: 65,
            width: 65,
            path: "assets/images/hitachi.png",
          ),
          actions: [
            // new IconButton(
            //   icon: SvgPicture.asset("assets/images/filter.svg"),
            //   onPressed: () => print("button is tapped"),
            // ),
            // new IconButton(
            //   icon: SvgPicture.asset("assets/images/searchs.svg"),
            //   onPressed: () => print("button is tapped"),
            // ),
            screenType != ScreenType.ACCOUNT
                ? IconButton(
                    icon: Icon(
                      Icons.account_circle_rounded,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      viewModel.onAccountPressed();
                    })
                : SizedBox(),
            IconButton(
                icon: Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                onPressed: () {
                  showLogoutPrompt(viewModel, context);
                  // onLogoutPressed();
                }),
            Container(
              color: isSearchSelected ? mediumgrey : appbarcolor,
              child: IconButton(
                icon: SvgPicture.asset(
                  "assets/images/searchs.svg",
                  color: isSearchSelected ? white : black,
                ),
                onPressed: () {
                  onSearchTap();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void showLogoutPrompt(AppbarViewModel viewModel, BuildContext context) async {
    bool value = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    "Logout",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    "Are you sure you want to logout?",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ButtonBar(children: [
                  TextButton(
                    child: Text(
                      "NO",
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () async {
                      Navigator.pop(context, false);
                    },
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  TextButton(
                    child: Text(
                      'YES',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () async {
                      Navigator.pop(context, true);
                    },
                  ),
                ]),
              ],
            ),
          ),
        );
      },
    );
    if (value != null && value) {
      ProgressDialog.show(context);
      viewModel.logout();
    }
  }
}
