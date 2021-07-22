import 'package:flutter/material.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/dialog.dart';
import 'package:insite/widgets/smart_widgets/asset_fuel_level.dart';
import 'package:insite/widgets/smart_widgets/asset_status.dart';
import 'package:insite/widgets/smart_widgets/asset_utilization.dart';
import 'package:insite/views/location/home/google_map.dart';
import 'package:insite/widgets/smart_widgets/idling_level.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:stacked/stacked.dart';
import 'home_view_model.dart';

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
        return InsiteScaffold(
          viewModel: viewModel,
          screenType: ScreenType.DASHBOARD,
          onFilterApplied: () {},
          body: SingleChildScrollView(
            child: Container(
              color: bgcolor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  // AssetCountWidget(
                  //   count: "14561",
                  //   title: "ALL ASSETS",
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: AssetStatus(
                        statusChartData: viewModel.statusChartData != null
                            ? viewModel.statusChartData
                            : null,
                        onFilterSelected: (value) {
                          viewModel.onFilterSelected(value);
                        },
                        isLoading: viewModel.assetStatusloading),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: AssetFuelLevel(
                      chartData: viewModel.fuelChartData != null
                          ? viewModel.fuelChartData
                          : null,
                      onFilterSelected: (value) {
                        viewModel.onFilterSelected(value);
                      },
                      isLoading: viewModel.assetFuelloading,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: AssetUtilizationWidget(
                      assetUtilization: viewModel.utilizationSummary != null
                          ? viewModel.utilizationSummary
                          : null,
                      onFilterSelected: (value) {
                        viewModel.gotoUtilizationPage();
                      },
                      totalGreatestNumber:
                          viewModel.utilizationTotalGreatestValue,
                      averageGreatestNumber:
                          viewModel.utilizationAverageGreatestValue,
                      isLoading: viewModel.assetUtilizationLoading,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: IdlingLevel(
                      data: viewModel.idlingLevelData != null
                          ? viewModel.idlingLevelData.countData
                          : null,
                      isLoading: viewModel.idlingLevelDataloading,
                      onFilterSelected: (value) {
                        viewModel.onIdlingLevelFilterSelected(value);
                      },
                      onRangeSelected: (IdlingLevelRange catchedRange) {
                        viewModel.idlingLevelRange = catchedRange;
                        viewModel.getIdlingLevelData(true);
                      },
                      isSwitching: viewModel.isSwitching,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GoogleMapHomeWidget(),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  //For Notification widget we haven't any data for that so we commented
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  //   child: Notifications(),
                  // ),
                  // SizedBox(
                  //   height: 20.0,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  //   child: AssetStatusUsage(
                  //     statusChartData: viewModel.statusChartData != null
                  //         ? viewModel.statusChartData
                  //         : null,
                  //     isLoading: viewModel.assetStatusloading,
                  //   ),
                  // ),
                ],
              ),
            ),
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
                    // style: TextStyle(color: Colors.black),
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
