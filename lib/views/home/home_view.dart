import 'package:flutter/material.dart';
import 'package:insite/dashboard/homedash.dart';
import 'package:insite/tab/tabpage.dart';
import 'package:insite/views/asset/asset_view.dart';
import 'package:insite/views/customer_selection/customer_selection_view.dart';
import 'package:insite/views/fleet/fleet_view.dart';
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
  ScreenType currentScreenType;

  @override
  void initState() {
    currentScreenType = ScreenType.ACCOUNT;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (BuildContext context, HomeViewModel viewModel, Widget _) {
        return WillPopScope(
          onWillPop: onBackPressed,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: appbarcolor,
              leading: IconButton(
                  icon: SvgPicture.asset("assets/images/menubar.svg"),
                  onPressed: () {
                    print("button is tapped");
                    updateCurrentState(ScreenType.HOME);
                  }),
              title: InsiteImage(
                height: 65,
                width: 65,
                path: "assets/images/hitachi.png",
              ),
              actions: [
                new IconButton(
                  icon: SvgPicture.asset("assets/images/filter.svg"),
                  onPressed: () => print("button is tapped"),
                ),
                new IconButton(
                  icon: SvgPicture.asset("assets/images/searchs.svg"),
                  onPressed: () => print("button is tapped"),
                ),
              ],
            ),
            body: getCurrentScreen(currentScreenType),
          ),
        );
      },
      viewModelBuilder: () => HomeViewModel(),
    );
  }

  Future<bool> onBackPressed() {
    if (currentScreenType == ScreenType.HOME) {
      updateCurrentState(ScreenType.ACCOUNT);
      return Future.value(false);
    } else if (currentScreenType == ScreenType.ACCOUNT) {
      return Future.value(true);
    } else if (currentScreenType == ScreenType.ASSET_DETAIL) {
      updateCurrentState(ScreenType.ASSET_OPERATION);
      return Future.value(false);
    } else {
      updateCurrentState(ScreenType.HOME);
      return Future.value(false);
    }
  }

  void updateCurrentState(newState) {
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        currentScreenType = newState;
      });
    });
  }

  Widget getCurrentScreen(ScreenType currentScreenType) {
    if (currentScreenType == ScreenType.ACCOUNT) {
      return CustomerSelectionView(
        onCustomerSelected: () {
          updateCurrentState(ScreenType.HOME);
        },
      );
    } else if (currentScreenType == ScreenType.ASSET_OPERATION) {
      return AssetView(
        onDetailPageSelected: () {
          updateCurrentState(ScreenType.ASSET_DETAIL);
        },
      );
    } else if (currentScreenType == ScreenType.ASSET_DETAIL) {
      return TabPage();
    } else if (currentScreenType == ScreenType.FLEET) {
      return FleetView(
        onDetailPageSelected: () {
          updateCurrentState(ScreenType.ASSET_DETAIL);
        },
      );
    } else if (currentScreenType == ScreenType.HOME) {
      return HomeDash(
        onDashboardItemSelected: (newState) {
          updateCurrentState(newState);
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
