import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/dialog.dart';
import 'package:insite/views/appbar/appbar_view_model.dart';
import 'package:insite/views/home/home_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_image.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:stacked/stacked.dart';

class InsiteAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ScreenType screenType;
  final double height;
  final bool isSearchSelected;
  final bool isFilterSelected;
  final VoidCallback onSearchTap;
  final VoidCallback onFilterTap;
  final bool shouldShowAccount;
  final bool shouldShowSearch;
  final bool shouldShowTitle;
  final bool shouldShowFilter;
  final bool shouldShowLogout;
  InsiteAppBar({
    this.screenType,
    this.onFilterTap,
    this.isSearchSelected,
    this.shouldShowAccount,
    this.isFilterSelected,
    this.shouldShowFilter,
    this.shouldShowTitle = false,
    this.shouldShowLogout,
    this.shouldShowSearch,
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
        return Column(
          children: [
            AppBar(
              backgroundColor: appbarcolor,
              titleSpacing: 0,
              leading: IconButton(
                  icon: SvgPicture.asset("assets/images/menubar.svg"),
                  onPressed: () {
                    viewModel.onHomePressed();
                  }),
              title: InsiteImage(
                height: 65,
                width: 65,
                path: "assets/images/hitachi.png",
              ),
              actions: [
                shouldShowAccount
                    ? IconButton(
                        icon: Icon(
                          Icons.account_circle_rounded,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          viewModel.onAccountPressed();
                        })
                    : SizedBox(),
                shouldShowFilter
                    ? Container(
                        color: isFilterSelected ? mediumgrey : appbarcolor,
                        child: IconButton(
                          icon: SvgPicture.asset(
                            "assets/images/filter.svg",
                            color: isFilterSelected ? white : black,
                          ),
                          onPressed: () {
                            onFilterTap();
                          },
                        ),
                      )
                    : SizedBox(),
                shouldShowSearch
                    ? Container(
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
                      )
                    : SizedBox(),
                shouldShowLogout
                    ? IconButton(
                        icon: Icon(
                          Icons.logout,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          showLogoutPrompt(viewModel, context);
                        })
                    : SizedBox(),
              ],
            ),
            shouldShowTitle
                ? Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: InsiteTextOverFlow(
                      text: viewModel.accountSelected != null &&
                              viewModel.accountSelected.DisplayName != null
                          ? viewModel.accountSelected.DisplayName
                          : "",
                      color: Colors.white,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.normal,
                      size: 12,
                    ),
                  )
                : SizedBox()
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
