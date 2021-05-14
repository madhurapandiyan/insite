import 'package:flutter/material.dart';
import 'package:insite/core/models/asset_status.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/dialog.dart';
import 'package:insite/views/asset_operation/asset_list_view.dart';
import 'package:insite/views/customer_selection/customer_selection_view.dart';
import 'package:insite/views/dashboard/dashboard_view.dart';
import 'package:insite/views/detail/asset_detail_view.dart';
import 'package:insite/views/fleet/fleet_view.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/smart_widgets/asset_fuel_level.dart';
import 'package:insite/widgets/smart_widgets/asset_status.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:stacked/stacked.dart';
import 'home_view_model.dart';

class HomeView extends StatefulWidget {
  AssetStatusData assetStatus;
  HomeView();
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
          child: InsiteScaffold(
              viewModel: viewModel,
              screenType: ScreenType.DASHBOARD,
              // appBar: InsiteAppBar(
              //   screenType: ScreenType.HOME,
              //   height: 56,
              // ),
              body: viewModel.loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      child: Container(
                        color: bgcolor,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20.0,
                            ),
                            AssetStatus(
                              AssetcountOf: viewModel
                                  .assetStatusData.countData[0].countOf,
                              AssetcountOn: viewModel
                                  .assetStatusData.countData[1].countOf,
                              AssetAwait: viewModel
                                  .assetStatusData.countData[2].countOf,
                              AssetNotReport: viewModel
                                  .assetStatusData.countData[3].countOf,
                              AssetOfcount:
                                  viewModel.assetStatusData.countData[0].count,
                              AssetOncount:
                                  viewModel.assetStatusData.countData[1].count,
                              AssetAwaitCount:
                                  viewModel.assetStatusData.countData[2].count,
                              AssetNotReportCount:
                                  viewModel.assetStatusData.countData[3].count,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            FuelLevel(),
                            SizedBox(
                              height: 20.0,
                            ),
                            // AssetStatus()
                          ],
                        ),
                      ),
                    )),
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

  Future<bool> onBackPressed(HomeViewModel model) {
    if (model.currentScreenType == ScreenType.HOME) {
      return Future.value(true);
    } else if (model.currentScreenType == ScreenType.ACCOUNT) {
      return Future.value(true);
    } else if (model.currentScreenType == ScreenType.ASSET_DETAIL) {
      if (selectedFleet != null) {
        updateCurrentState(ScreenType.FLEET, model);
        return Future.value(false);
      } else {
        updateCurrentState(ScreenType.ASSET_OPERATION, model);
        return Future.value(false);
      }
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
      return CustomerSelectionView();
    } else if (currentScreenType == ScreenType.ASSET_OPERATION) {
      return AssetListView();
    } else if (currentScreenType == ScreenType.ASSET_DETAIL) {
      return AssetDetailView();
    } else if (currentScreenType == ScreenType.FLEET) {
      return FleetView();
    } else if (currentScreenType == ScreenType.HOME) {
      return DashboardView(
          // onDashboardItemSelected: (newState) {
          // updateCurrentState(newState, model);
          // },

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
