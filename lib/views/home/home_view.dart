import 'package:flutter/material.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/dashboard/homedash.dart';
import 'package:insite/utils/dialog.dart';
import 'package:insite/views/asset/asset_view.dart';
import 'package:insite/views/customer_selection/customer_selection_view.dart';
import 'package:insite/views/fleet/fleet_view.dart';
import 'package:insite/views/tab_page/tab_page_view.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_image.dart';
import 'package:stacked/stacked.dart';
import 'home_view_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/theme/colors.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
  }

  Fleet selectedFleet;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (BuildContext context, HomeViewModel viewModel, Widget _) {
        return WillPopScope(
          onWillPop: () {
            return onBackPressed(viewModel);
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: appbarcolor,
              leading: IconButton(
                  icon: SvgPicture.asset("assets/images/menubar.svg"),
                  onPressed: () {
                    print("button is tapped");
                    updateCurrentState(ScreenType.HOME, viewModel);
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
                viewModel.currentScreenType != ScreenType.ACCOUNT
                    ? IconButton(
                        icon: Icon(
                          Icons.account_circle_rounded,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          updateCurrentState(ScreenType.ACCOUNT, viewModel);
                        })
                    : SizedBox(),
                IconButton(
                    icon: Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      showLogoutPrompt(viewModel);
                      // updateCurrentState(ScreenType.ACCOUNT, viewModel);
                    })
              ],
            ),
            body: getCurrentScreen(viewModel.currentScreenType, viewModel),
          ),
        );
      },
      viewModelBuilder: () => HomeViewModel(),
    );
  }

  void showLogoutPrompt(HomeViewModel viewModel) async {
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
                  FlatButton(
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
                  FlatButton(
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

  Future<bool> onBackPressed(HomeViewModel model) {
    if (model.currentScreenType == ScreenType.HOME) {
      updateCurrentState(ScreenType.ACCOUNT, model);
      return Future.value(false);
    } else if (model.currentScreenType == ScreenType.ACCOUNT) {
      return Future.value(true);
    } else if (model.currentScreenType == ScreenType.ASSET_DETAIL) {
      updateCurrentState(ScreenType.ASSET_OPERATION, model);
      return Future.value(false);
    } else {
      updateCurrentState(ScreenType.HOME, model);
      return Future.value(false);
    }
  }

  void updateCurrentState(newState, HomeViewModel model) {
    Future.delayed(Duration(milliseconds: 500), () {
      model.updateState(newState);
    });
  }

  Widget getCurrentScreen(ScreenType currentScreenType, HomeViewModel model) {
    if (currentScreenType == ScreenType.ACCOUNT) {
      return CustomerSelectionView(
        onCustomerSelected: () {
          updateCurrentState(ScreenType.HOME, model);
        },
      );
    } else if (currentScreenType == ScreenType.ASSET_OPERATION) {
      return AssetView(
        onDetailPageSelected: () {
          updateCurrentState(ScreenType.ASSET_DETAIL, model);
        },
      );
    } else if (currentScreenType == ScreenType.ASSET_DETAIL) {
      return TabPageView(
        fleet: selectedFleet,
      );
    } else if (currentScreenType == ScreenType.FLEET) {
      return FleetView(
        onDetailPageSelected: (Fleet fleet) {
          selectedFleet = fleet;
          updateCurrentState(ScreenType.ASSET_DETAIL, model);
        },
      );
    } else if (currentScreenType == ScreenType.HOME) {
      return HomeDash(
        onDashboardItemSelected: (newState) {
          updateCurrentState(newState, model);
        },
      );
    } else {
      return EmptyView(
        title: "Coming soon!",
      );
    }
  }
}

enum ScreenType {
  ACCOUNT,
  HOME,
  DASHBOARD,
  FLEET,
  UTILIZATION,
  ASSET_OPERATION,
  ASSET_DETAIL,
  LOCATION,
  HEALTH,
  MAINTENANCE,
  ADMINISTRATION,
  PLANT,
  SUBSCRIPTION,
  NOTIFICATION
}
