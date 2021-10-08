import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/core/insite_data_provider.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/dialog.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/appbar/appbar_view_model.dart';
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
  final VoidCallback onRefineTap;
  final bool shouldShowAccount;
  final bool shouldShowSearch;
  final bool shouldShowTitle;
  final bool shouldShowFilter;
  final bool shouldShowRefine;
  final bool isRefineSelected;
  final bool shouldShowLogout;
  InsiteAppBar({
    this.screenType,
    this.onFilterTap,
    this.isSearchSelected,
    this.onRefineTap,
    this.shouldShowAccount,
    this.isFilterSelected,
    this.isRefineSelected = false,
    this.shouldShowFilter,
    this.shouldShowRefine = false,
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
    final count = InsiteInheritedDataProvider.of(context) != null
        ? InsiteInheritedDataProvider.of(context).count
        : 0;
    return ViewModelBuilder<AppbarViewModel>.reactive(
      viewModelBuilder: () => AppbarViewModel(screenType),
      builder: (BuildContext context, AppbarViewModel viewModel, Widget _) {
        return Column(
          children: [
            AppBar(
              backgroundColor: appbarcolor,
              titleSpacing: 0,
              leading: IconButton(
                  icon: SvgPicture.asset("assets/images/menubar.svg",
                      color: Theme.of(context).buttonColor),
                  onPressed: () {
                    viewModel.onHomePressed();
                  }),
              title: Row(
                children: [
                  InsiteImage(
                    height: 65,
                    width: 65,
                    path: "assets/images/ic_eol_launcher.png",
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  InsiteTextOverFlow(
                    text: Utils.getPageTitle(screenType),
                    color: Theme.of(context).buttonColor,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.bold,
                    size: 16,
                  )
                ],
              ),
              actions: [
                shouldShowAccount
                    ? IconButton(
                        icon: Icon(
                          Icons.account_circle_rounded,
                          color: Theme.of(context).buttonColor,
                        ),
                        onPressed: () {
                          viewModel.onAccountPressed();
                        })
                    : SizedBox(),
                shouldShowRefine
                    ? Container(
                        color: isRefineSelected
                            ? Theme.of(context).buttonColor
                            : appbarcolor,
                        child: count != null && count > 0
                            ? IconButton(
                                icon: Icon(
                                  Icons.filter_list,
                                  color: isRefineSelected
                                      ? white
                                      : Theme.of(context).buttonColor,
                                ),
                                onPressed: () {
                                  onRefineTap();
                                },
                              )
                            : IconButton(
                                icon: Icon(
                                  Icons.filter_list,
                                  color: isRefineSelected
                                      ? white
                                      : Theme.of(context).buttonColor,
                                ),
                                onPressed: () {
                                  onRefineTap();
                                },
                              ),
                      )
                    : SizedBox(),
                shouldShowFilter
                    ? Container(
                        color: isFilterSelected
                            ? Theme.of(context).buttonColor
                            : appbarcolor,
                        child: count != null && count > 0
                            ? Badge(
                                badgeContent: Text(count.toString(),
                                    style: TextStyle(
                                      color: Theme.of(context).buttonColor,
                                    )),
                                badgeColor: white,
                                position:
                                    BadgePosition.topStart(start: 25, top: 1),
                                child: IconButton(
                                  icon: SvgPicture.asset(
                                    "assets/images/filter.svg",
                                    color: isFilterSelected
                                        ? white
                                        : Theme.of(context).buttonColor,
                                  ),
                                  onPressed: () {
                                    onFilterTap();
                                  },
                                ),
                              )
                            : IconButton(
                                icon: SvgPicture.asset(
                                  "assets/images/filter.svg",
                                  color: isFilterSelected
                                      ? white
                                      : Theme.of(context).buttonColor,
                                ),
                                onPressed: () {
                                  onFilterTap();
                                },
                              ),
                      )
                    : SizedBox(),
                shouldShowSearch
                    ? Container(
                        color: isSearchSelected
                            ? Theme.of(context).buttonColor
                            : appbarcolor,
                        child: IconButton(
                          icon: SvgPicture.asset(
                            "assets/images/searchs.svg",
                            color: isSearchSelected
                                ? white
                                : Theme.of(context).buttonColor,
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
                          color: Theme.of(context).buttonColor,
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
                              viewModel.customerSelected != null
                          ? viewModel.customerSelected.DisplayName != null
                              ? viewModel.customerSelected.DisplayName
                              : viewModel.accountSelected.DisplayName != null
                                  ? viewModel.accountSelected.DisplayName
                                  : ""
                          : viewModel.accountSelected != null &&
                                  viewModel.accountSelected.DisplayName != null
                              ? viewModel.accountSelected.DisplayName
                              : "",
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
      Future.delayed(Duration(seconds: 1), () {
        ProgressDialog.dismiss();
      });
    }
  }
}
