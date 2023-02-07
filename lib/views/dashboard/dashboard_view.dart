import 'package:flutter/material.dart';
import 'package:insite/core/insite_data_provider.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/date.dart';
import 'package:insite/utils/dialog.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/location/home/google_map.dart';
import 'package:insite/widgets/dumb_widgets/filter_dropdown_widget.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_dialog.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/asset_fuel_level.dart';
import 'package:insite/widgets/smart_widgets/asset_status.dart';
import 'package:insite/widgets/smart_widgets/asset_utilization.dart';
import 'package:insite/widgets/smart_widgets/fault_dropdown_widget.dart';
import 'package:insite/widgets/smart_widgets/fault_health_dashboard.dart';
import 'package:insite/widgets/smart_widgets/idling_level.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:insite/widgets/smart_widgets/maintenance_dashboard.dart';
import 'package:insite/widgets/smart_widgets/notifications.dart';
import 'package:insite/widgets/smart_widgets/page_header.dart';
import 'package:insite/widgets/smart_widgets/reusable_dropdown_widget.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'dashboard_view_model.dart';

class DashboardView extends StatefulWidget {
  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  void initState() {
    super.initState();
  }

  Fleet? selectedFleet;
  String assetDropDown = "All Assets";
  bool switchDropDownState = false;
  final GlobalKey<GoogleMapHomeWidgetState> filterLocationKey = new GlobalKey();
 final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardViewModel>.reactive(
      builder: (BuildContext context, DashboardViewModel viewModel, Widget? _) {
        return InsiteInheritedDataProvider(
          count: viewModel.appliedFilters!.length,
          child: InsiteScaffold(
            viewModel: viewModel,
            screenType: ScreenType.DASHBOARD,
            onFilterApplied: () {},
            onRefineApplied: () {},
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, top: 16),
                      child: InsiteTextOverFlow(
                        text: Utils.getPageTitle(ScreenType.DASHBOARD),
                        color: Theme.of(context).textTheme.bodyText1!.color,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                        size: 16,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 1,
                          child: PageHeader(
                            isDashboard: true,
                            total: viewModel.totalCount,
                            screenType: ScreenType.HOME,
                            count: 0,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16, right: 16),
                          child: InsiteButton(
                            fontSize: 13,
                            width: 100,
                            height: 40,
                            textColor: white,
                            title: "Refresh",
                            onTap: () {
                              viewModel.onRefereshClicked();
                              if (assetDropDown == "All Assets") {
                                filterLocationKey.currentState!
                                    .getAssetLocationHomeData();
                              } else {
                                filterLocationKey.currentState!
                                    .getAssetLocationHomeFilterData(viewModel
                                        .filterDataProductFamily[0].title);
                              }
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FaultDropDown(
                          value: assetDropDown,
                          items: ["All Assets", "Product Family"],
                          onChanged: (String? value) {
                            Logger().i("all assets dropdown change $value");
                            assetDropDown = value!;

                            if (value != "All Assets") {
                              switchDropDownState = true;
                              // "BACKHOE LOADER"
                              FilterData filterData =
                                  viewModel.filterDataProductFamily[0];
                              viewModel.getFilterDataApplied(filterData, true);
                              filterLocationKey.currentState!
                                  .getAssetLocationHomeFilterData(
                                      filterData.title);
                            } else {
                              switchDropDownState = false;
                              viewModel.notificationFilterTitle = null;
                              viewModel.getData(true);
                              filterLocationKey.currentState!
                                  .getAssetLocationHomeData();
                            }
                          },
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        switchDropDownState
                            ? Flexible(
                                child: viewModel.filterDataProductFamily != null
                                    ? FilterDropDownWidget(
                                        data: viewModel.filterDataProductFamily,
                                        onValueSelected: (value) async {
                                          Logger().i(
                                              "product family dropdown change $value");
                                          // viewModel
                                          //     .getProductFamilyAssetCount();
                                          viewModel.getFilterDataApplied(
                                              value!, true);
                                          filterLocationKey.currentState!
                                              .getAssetLocationHomeFilterData(
                                                  value.title);
                                        },
                                      )
                                    : SizedBox(),
                              )
                            : Flexible(
                                child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.46,
                                    height: MediaQuery.of(context).size.height *
                                        0.062,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color!),
                                      color: Theme.of(context).backgroundColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                    ),
                                    child: ReusableDropDown(
                                      title: viewModel.totalCount.toString(),
                                      name: "All Assets",
                                    )),
                              ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: AssetStatus(
                        statusChartData: viewModel.statusChartData != null
                            ? viewModel.statusChartData
                            : null,
                        onFilterSelected: (value) async {
                          await viewModel.onFilterSelected(value);
                          viewModel.gotoFleetPage();
                        },
                        isLoading: viewModel.assetStatusloading,
                        isRefreshing: viewModel.refreshing,
                      ),
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
                        onFilterSelected: (value) async {
                          await viewModel.onFilterSelected(value);
                          viewModel.gotoFleetPage();
                        },
                        isLoading: viewModel.assetFuelloading,
                        isRefreshing: viewModel.refreshing,
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
                        onFilterSelected: (data) async {
                          await viewModel.updateDateRangeFilter(data);
                          viewModel.gotoUtilizationPage();
                        },
                        totalGreatestNumber:
                            viewModel.utilizationSummary != null
                                ? viewModel.utilizationTotalGreatestValue
                                : 0,
                        averageGreatestNumber:
                            viewModel.utilizationSummary != null
                                ? viewModel.utilizationAverageGreatestValue
                                : 0,
                        isLoading: viewModel.assetUtilizationLoading,
                        isRefreshing: viewModel.refreshing,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: IdlingLevel(
                        data: viewModel.idlingLevelData != null
                            ? viewModel.idlingLevelData!.countData
                            : [],
                        isLoading: viewModel.idlingLevelDataloading,
                        onFilterSelected: (value, dateFilter) async {
                          await viewModel.onDateAndFilterSelected(
                              value, dateFilter);
                          viewModel.gotoUtilizationPage();
                        },
                        onRangeSelected: (IdlingLevelRange catchedRange) {
                          viewModel.idlingLevelRange = catchedRange;
                          viewModel.getIdlingLevelData(true, catchedRange);
                        },
                        isSwitching: viewModel.isSwitching,
                        isRefreshing: viewModel.refreshing,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: FaultHealthDashboard(
                        screenType: ScreenType.DASHBOARD,
                        countData: viewModel.faultCountData != null
                            ? viewModel.faultCountData!.countData
                            : [],
                        onFilterSelected: (value, dateFilter) async {
                          await viewModel.onDateAndFilterSelected(
                              value, dateFilter);
                          viewModel.gotoFaultPage();
                        },
                        loading: viewModel.faultCountloading,
                        isRefreshing: viewModel.refreshing,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: MaintenanceDashBoard(
                        scrollController: controller,
                        countData: viewModel.maintenanceDashboardCount,
                        isLoading: viewModel.maintenanceLoading,
                        onFilterSelected: (val, filterType, count) {
                          viewModel.onMaintenanceFilterClicked(
                              val, filterType, count);
                        },
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    //   child: GoogleMapHomeWidget(
                    //     isRefreshing: viewModel.refreshing,
                    //     key: filterLocationKey,
                    //   ),
                    // ),
                    SizedBox(
                      height: 20.0,
                    ),
                    //For Notification widget we haven't any data for that so we commented
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: NotificationWidget(
                        count: 1,
                        isLoading: viewModel.notificationLoading,
                        notificationType: viewModel.notificationCountDatas,
                        onFilterSelected: 
                        (value) async {
                            await viewModel.onFilterSelected(value);
                          viewModel.onNotificationFilterClicked(value.title.toString());
                        }
                        //  (value) {
                        //   viewModel.onNotificationFilterClicked(value);
                        // },
                      ),
                    ),
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
          ),
        );
      },
      viewModelBuilder: () => DashboardViewModel(),
    );
  }

  void showLogoutPrompt(DashboardViewModel viewModel) async {
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
      ProgressDialog.show(context);
      viewModel.logout();
    }
  }
}
