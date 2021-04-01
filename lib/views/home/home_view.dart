import 'package:flutter/material.dart';
import 'package:insite/assetlist/asset_list.dart';
import 'package:insite/dashboard/homedash.dart';
import 'package:insite/views/customer_selection/customer_selection_view.dart';
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
        return Scaffold(
          appBar: AppBar(
            backgroundColor: appbarcolor,
            leading: IconButton(
                icon: SvgPicture.asset("assets/images/menubar.svg"),
                onPressed: () {
                  print("button is tapped");
                  updateCurrentState(ScreenType.DASHBOARD);
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
        );
      },
      viewModelBuilder: () => HomeViewModel(),
    );
  }

  void updateCurrentState(newState) {
    setState(() {
      currentScreenType = newState;
    });
  }

  Widget getCurrentScreen(ScreenType currentScreenType) {
    if (currentScreenType == ScreenType.ACCOUNT) {
      return CustomerSelectionView(
        onCustomerSelected: () {
          updateCurrentState(ScreenType.DASHBOARD);
        },
      );
    } else if (currentScreenType == ScreenType.ASSETLIST) {
      return AssetList();
    } else if (currentScreenType == ScreenType.DASHBOARD) {
      return HomeDash(
        onDashboardItemSelected: (newState) {
          updateCurrentState(newState);
        },
      );
    } else {
      return HomeDash();
    }
  }
}

enum ScreenType { ACCOUNT, DASHBOARD, ASSETLIST }
