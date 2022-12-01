import 'package:flutter/material.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/detail/tabs/dashboard/asset_dashboard_view_model.dart';
import 'package:insite/widgets/dumb_widgets/asset_details_widget.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/smart_widgets/fault_health_dashboard.dart';
import 'package:insite/widgets/smart_widgets/google_map_detail.dart';
import 'package:insite/widgets/smart_widgets/fuel_level.dart';
import 'package:insite/widgets/smart_widgets/maintenance_dashboard.dart';
import 'package:insite/widgets/smart_widgets/notes.dart';
import 'package:insite/widgets/smart_widgets/notifications.dart';
import 'package:insite/widgets/smart_widgets/ping_device.dart';
import 'package:stacked/stacked.dart';

class AssetDashbaord extends StatefulWidget {
  final AssetDetail? detail;
  final ScreenType? screenType;
  final Function(int)? switchTab;

  AssetDashbaord({this.detail, this.switchTab,this.screenType});

  @override
  _AssetDashbaordState createState() => _AssetDashbaordState();
}

class _AssetDashbaordState extends State<AssetDashbaord> {
  TextEditingController? notesController;
  @override
  void initState() {
    super.initState();
    notesController = TextEditingController();
  }

  @override
  void dispose() {
    notesController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AssetDashboardViewModel>.reactive(
      builder:
          (BuildContext context, AssetDashboardViewModel viewModel, Widget? _) {
        if (viewModel.loading) {
          return InsiteProgressBar();
        } else {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              color: Theme.of(context).backgroundColor,
              border: Border.all(
                width: 1,
                color: Theme.of(context).textTheme.bodyText1!.color!,
              ),
              shape: BoxShape.rectangle,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    child: AssetDetailWidgt(
                      dateFormat: viewModel.userPref,
                      timeZone: viewModel.zone,
                      detail: widget.detail,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    child: FuelLevel(
                        liquidColor: Theme.of(context).buttonColor,
                        title: "Fuel Level",
                        value: widget.detail != null &&
                                widget.detail!.fuelLevelLastReported != null
                            ? widget.detail!.fuelLevelLastReported!
                                .roundToDouble()
                            : null,
                        lifeTimeFuel: widget.detail?.lifetimeFuel != null
                            ? "lifetime fuel :\n" +
                                (widget.detail!.lifetimeFuel!.toString()) +
                                " liters"
                            : "lifetime fuel -",
                        percentage: widget.detail != null &&
                                widget.detail!.fuelLevelLastReported != null
                            ? widget.detail!.fuelLevelLastReported.toString()
                            : null,
                        lastReported: widget.detail!.fuelReportedTimeUtc != null
                            ? "Last Reported Time: ".toUpperCase() +
                                Utils.getDateUTC(
                                    widget.detail!.fuelReportedTimeUtc,viewModel.userPref,viewModel.zone)
                            : "No Data Received"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  viewModel.assetUtilization != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                          ),
                          child: SizedBox()
                          // SingleAssetUtilizationWidget(
                          //   assetUtilization:
                          //       viewModel.assetUtilization != null
                          //           ? viewModel.assetUtilization
                          //           : null,
                          //   greatestNumber:
                          //       viewModel.utilizationGreatestValue != null
                          //           ? viewModel.utilizationGreatestValue
                          //           : null,
                          // ),
                          )
                      : SizedBox(),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    child: FuelLevel(
                        liquidColor:widget.detail!.percentDEFRemaining != null? Utils.defColors(double.parse(
                            widget.detail!.percentDEFRemaining.toString())):Colors.red,
                        value: widget.detail != null && widget.detail!.percentDEFRemaining != null
                            ? double.parse(
                                widget.detail!.percentDEFRemaining!.toString())
                            : 0,
                        title: "Diesel Exhaust Fluid (DEF) Level ",
                        lifeTimeFuel: widget.detail!.lifetimeDEFLiters != null
                            ? widget.detail!.lifetimeDEFLiters.runtimeType ==
                                    String
                                ? "Lifetime DEF :\n" +
                                    double.parse(
                                            widget.detail!.lifetimeDEFLiters!)
                                        .round()
                                        .toString() +
                                    " liters"
                                : "Lifetime DEF :\n" +
                                    widget.detail!.lifetimeDEFLiters!
                                        .round()
                                        .toString() +
                                    " liters"
                            : "Lifetime DEF :",
                        percentage: widget.detail != null &&
                                widget.detail!.percentDEFRemaining != null
                            ? widget.detail!.percentDEFRemaining.toString()
                            : "0",
                        lastReported: widget
                                    .detail!.lastPercentDEFRemainingUTC !=
                                null
                            ? "Last Reported Time: ".toUpperCase() +
                                Utils.getDateUTC(
                                    widget.detail!.lastPercentDEFRemainingUTC,viewModel.userPref,viewModel.zone)
                            : "No Data Received"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child:
                     FaultHealthDashboard(
                      
                      screenType: ScreenType.ASSET_DETAIL,
                      countData: viewModel.faultCountDataList != null
                          ? viewModel.faultCountDataList
                          : [],
                      onFilterSelected: (value, dateFilter) async {
                        
                        await viewModel.onDateAndFilterSelected(
                            value, dateFilter);
                        viewModel.gotoFaultPage();
                      },
                      loading: viewModel.faultCountloading,
                      isRefreshing: viewModel.refreshing,
                    )
                   
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  viewModel.assetDetail != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                          ),
                          child: Column(
                            children: [
                              GoogleMapDetailWidget(
                                  isLoading: false,
                                  details: viewModel.assetDetail,
                                  latitude: viewModel.assetDetail!
                                              .lastReportedLocationLatitude !=
                                          null
                                      ? viewModel.assetDetail!
                                          .lastReportedLocationLatitude
                                      : null,
                                  screenType: ScreenType.ASSET_DETAIL,
                                  status: widget.detail!.lastLocationUpdateUtc != null
                                      ? "Last Reported Time: ".toUpperCase() +
                                          Utils.getDateUTC(widget
                                              .detail!.lastLocationUpdateUtc,viewModel.userPref,viewModel.zone)
                                      : "No Data Received",
                                  onMarkerTap: () {
                                    widget.switchTab!(3);
                                  },
                                  initLocation: null,
                                  location: viewModel.assetDetail!
                                              .lastReportedLocation !=
                                          null
                                      ? viewModel
                                          .assetDetail!.lastReportedLocation
                                      : "",
                                  longitude: viewModel.assetDetail!
                                              .lastReportedLocationLongitude !=
                                          null
                                      ? viewModel.assetDetail!
                                          .lastReportedLocationLongitude
                                      : null),
                            ],
                          ),
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    child: Notes(
                      dateFormat: viewModel.userPref,
                      timeZone: viewModel.zone,
                      controller: notesController,
                      onDelete: (value) {
                        viewModel.deletNotes(value);
                      },
                      notes: viewModel.assetNotes,
                      onTap: () {
                        if (notesController!.text.isNotEmpty) {
                          viewModel.postNotes(notesController!.text);
                          notesController!.text = "";
                        }
                      },
                      isLoading: viewModel.postingNote,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    child: PingDevice(
                      onTap: () {},
                      assetDetail: widget.detail,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: NotificationWidget(
                      count: 1,
                      isLoading: viewModel.notificationLoading,
                      notificationType: viewModel.notificationCountDatas,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: MaintenanceDashBoard(
                      countData: viewModel.maintenanceDashboardCount,
                      isLoading: viewModel.maintenanceLoading,
                      onFilterSelected: (val, filterType, count) {
                        viewModel.goToMaintainenceView();
                        // viewModel.onMaintenanceFilterClicked(
                        //     val, filterType, count);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          );
        }
      },
      viewModelBuilder: () => AssetDashboardViewModel(widget.detail),
    );
  }
}
