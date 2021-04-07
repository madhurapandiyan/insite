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
  @override
  void initState() {
    super.initState();
  }

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
            body: getCurrentScreen(viewModel.currentScreenType, viewModel),
          ),
        );
      },
      viewModelBuilder: () => HomeViewModel(),
    );
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
      return TabPage();
    } else if (currentScreenType == ScreenType.FLEET) {
      return FleetView(
        onDetailPageSelected: () {
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
