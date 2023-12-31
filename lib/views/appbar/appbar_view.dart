import 'dart:io';

import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/core/flavor/flavor.dart';
import 'package:insite/core/insite_data_provider.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/appbar/appbar_view_model.dart';
import 'package:insite/widgets/dumb_widgets/insite_dialog.dart';
import 'package:insite/widgets/dumb_widgets/insite_image.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class InsiteAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ScreenType? screenType;
  final double? height;
  final bool? isSearchSelected;
  final bool? isFilterSelected;
  final VoidCallback? onSearchTap;
  final VoidCallback? onFilterTap;
  final VoidCallback? onRefineTap;
  final bool? shouldShowAccount;
  final bool? shouldShowSearch;
  final bool shouldShowTitle;
  final bool? shouldShowFilter;
  final bool shouldShowRefine;
  final bool isRefineSelected;
  final bool? shouldShowLogout;
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
  Size get preferredSize => Size.fromHeight(height!);

  var searchBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(16.0)),
    borderSide: BorderSide(
      color: Colors.transparent,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final count = InsiteInheritedDataProvider.of(context) != null
        ? InsiteInheritedDataProvider.of(context)!.count
        : 0;
    return ViewModelBuilder<AppbarViewModel>.reactive(
      viewModelBuilder: () => AppbarViewModel(screenType),
      builder: (BuildContext context, AppbarViewModel viewModel, Widget? _) {
        return Column(
          children: [
            AppBar(
              titleSpacing: 0,
              leadingWidth: 0,
              // leading: Platform.isAndroid
              //     ? IconButton(
              //         icon: SvgPicture.asset("assets/images/menubar.svg",
              //             color: Theme.of(context).buttonColor),
              //         onPressed: () {
              //           viewModel.onHomePressed();
              //         })
              //     : (screenType == ScreenType.ACCOUNT ||
              //             screenType == ScreenType.HOME)
              //         ? IconButton(
              //             icon: SvgPicture.asset("assets/images/menubar.svg",
              //                 color: Theme.of(context).buttonColor),
              //             onPressed: () {
              //               viewModel.onHomePressed();
              //             })
              //         : BackButton(
              //             color: Theme.of(context).buttonColor,
              //           ),
              title: Row(
                children: [
                  Platform.isAndroid
                      ? IconButton(
                          icon: SvgPicture.asset("assets/images/menubar.svg",
                              color: Theme.of(context).buttonColor),
                          onPressed: () {
                            viewModel.onHomePressed();
                          })
                      : (screenType == ScreenType.ACCOUNT ||
                              screenType == ScreenType.HOME)
                          ? IconButton(
                              icon: SvgPicture.asset(
                                  "assets/images/menubar.svg",
                                  width: 20,
                                  height: 20,
                                  color: Theme.of(context).buttonColor),
                              onPressed: () {
                                viewModel.onHomePressed();
                              })
                          : BackButton(
                              color: Theme.of(context).buttonColor,
                            ),
                  Platform.isIOS &&
                          !(screenType == ScreenType.ACCOUNT ||
                              screenType == ScreenType.HOME)
                      ? IconButton(
                          icon: SvgPicture.asset(
                            "assets/images/menubar.svg",
                            color: Theme.of(context).buttonColor,
                            width: 20,
                            height: 20,
                          ),
                          onPressed: () {
                            viewModel.onHomePressed();
                          })
                      : SizedBox(),

                  AppConfig.instance!.productFlavor == "cummins"
                      ? Image.asset(AppConfig.instance!.iconPath,
                          width: 50, height: 50, color: Colors.black)
                      : AppConfig.instance!.productFlavor == "worksiq"
                          ? Image.asset(AppConfig.instance!.iconPath,
                              width: 85, height: 85)
                          : Image.asset(
                              AppConfig.instance!.iconPath,
                              width: 65,
                              height: 65,
                            ),
                  // InsiteImage(

                  //   height: 65,
                  //   width: 65,
                  //   path: AppConfig.instance!.iconPath,
                  // ),
                  SizedBox(
                    width: 20,
                  ),
                  // InsiteTextOverFlow(
                  //   text: Utils.getPageTitle(screenType),
                  //   color: Theme.of(context).buttonColor,
                  //   overflow: TextOverflow.ellipsis,
                  //   fontWeight: FontWeight.bold,
                  //   size: 16,
                  // )
                ],
              ),
              actions: [
                shouldShowAccount!
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
                                  onRefineTap!();
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
                                  onRefineTap!();
                                },
                              ),
                      )
                    : SizedBox(),
                shouldShowFilter!
                    ? Container(
                        color: isFilterSelected!
                            ? Theme.of(context).buttonColor
                            : appbarcolor,
                        child: count != null && count > 0
                            ? badges.Badge(
                                badgeContent: Text(count.toString(),
                                    style: TextStyle(
                                      color: Theme.of(context).buttonColor,
                                    )),
                                badgeStyle:
                                    badges.BadgeStyle(badgeColor: white),
                                position: badges.BadgePosition.topStart(
                                    start: 25, top: 1),
                                child: IconButton(
                                  icon: SvgPicture.asset(
                                    "assets/images/filter.svg",
                                    color: isFilterSelected!
                                        ? white
                                        : Theme.of(context).buttonColor,
                                  ),
                                  onPressed: () {
                                    onFilterTap!();
                                  },
                                ),
                              )
                            : IconButton(
                                icon: SvgPicture.asset(
                                  "assets/images/filter.svg",
                                  color: isFilterSelected!
                                      ? white
                                      : Theme.of(context).buttonColor,
                                ),
                                onPressed: () {
                                  onFilterTap!();
                                },
                              ),
                      )
                    : SizedBox(),
                shouldShowSearch!
                    ? Container(
                        color: isSearchSelected!
                            ? Theme.of(context).buttonColor
                            : appbarcolor,
                        child: IconButton(
                          icon: SvgPicture.asset(
                            "assets/images/searchs.svg",
                            color: isSearchSelected!
                                ? white
                                : Theme.of(context).buttonColor,
                          ),
                          onPressed: () {
                            onSearchTap!();
                          },
                        ),
                      )
                    : SizedBox(),
                shouldShowLogout!
                    ? IconButton(
                        icon: Icon(
                          Icons.logout,
                          color: Theme.of(context).buttonColor,
                        ),
                        onPressed: () {
                          showLogoutPrompt(viewModel, context);
                        })
                    : SizedBox(),
                shouldShowAccount!
                    ? IconButton(
                        onPressed: () {
                          viewModel.onPreferencePressed();
                        },
                        color: Theme.of(context).buttonColor,
                        icon: Icon(Icons.psychology_outlined))
                    : SizedBox(),
                shouldShowAccount!
                    ? IconButton(
                        color: Theme.of(context).buttonColor,
                        onPressed: () {
                          viewModel.onManageAccountPressed();
                        },
                        icon: Icon(Icons.manage_accounts))
                    : SizedBox()
              ],
            ),
            shouldShowTitle
                ? Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: InsiteTextOverFlow(
                      text: viewModel.accountSelected != null &&
                              viewModel.customerSelected != null
                          ? viewModel.customerSelected!.Name != null
                              ? viewModel.customerSelected!.Name
                              : viewModel.accountSelected!.Name != null
                                  ? viewModel.accountSelected!.Name
                                  : ""
                          : viewModel.accountSelected != null &&
                                  viewModel.accountSelected!.Name != null
                              ? viewModel.accountSelected!.Name
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
    bool? value = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Theme.of(context).backgroundColor,
          child: InsiteDialog(
            title: "Logout",
            message: "Are you sure you want to logout?",
            onNegativeActionClicked: () {
              Navigator.pop(context, false);
            },
            onPositiveActionClicked: () {
              Navigator.pop(context, true);
            },
          ),
        );
      },
    );
    if (value != null && value) {
      // ProgressDialog.show(context);
      await viewModel.logout();
    }
  }
}
