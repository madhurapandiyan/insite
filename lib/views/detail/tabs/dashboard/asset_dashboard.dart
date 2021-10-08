import 'package:flutter/material.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/detail/tabs/dashboard/asset_dashboard_view_model.dart';
import 'package:insite/widgets/dumb_widgets/asset_details_widget.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/smart_widgets/google_map_detail.dart';
import 'package:insite/widgets/smart_widgets/fuel_level.dart';
import 'package:insite/widgets/smart_widgets/notes.dart';
import 'package:insite/widgets/smart_widgets/ping_device.dart';
import 'package:insite/widgets/smart_widgets/single_asset_utilization.dart';
import 'package:stacked/stacked.dart';

class AssetDashbaord extends StatefulWidget {
  final AssetDetail detail;
  final Function(int) switchTab;
  AssetDashbaord({this.detail, this.switchTab});

  @override
  _AssetDashbaordState createState() => _AssetDashbaordState();
}

class _AssetDashbaordState extends State<AssetDashbaord> {
  TextEditingController notesController;
  @override
  void initState() {
    super.initState();
    notesController = TextEditingController();
  }

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AssetDashboardViewModel>.reactive(
      builder:
          (BuildContext context, AssetDashboardViewModel viewModel, Widget _) {
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
                  width: 1, color: Theme.of(context).textTheme.bodyText1.color),
              shape: BoxShape.rectangle,
            ),
            child: SingleChildScrollView(
              child: Container(
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
                                  widget.detail.fuelLevelLastReported != null
                              ? widget.detail.fuelLevelLastReported
                                  .roundToDouble()
                              : null,
                          lifeTimeFuel: widget.detail.lifetimeFuel != null
                              ? "lifetime fuel :\n" +
                                  widget.detail.lifetimeFuel
                                      .round()
                                      .toString() +
                                  " liters"
                              : "",
                          percentage: widget.detail != null &&
                                  widget.detail.fuelLevelLastReported != null
                              ? widget.detail.fuelLevelLastReported.toString()
                              : null,
                          lastReported:
                              widget.detail.fuelReportedTimeUTC != null
                                  ? "Last Reported Time: ".toUpperCase() +
                                      Utils.getLastReportedDateOneUTC(
                                          widget.detail.fuelReportedTimeUTC)
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
                            child: SingleAssetUtilizationWidget(
                              assetUtilization:
                                  viewModel.assetUtilization != null
                                      ? viewModel.assetUtilization
                                      : null,
                              greatestNumber:
                                  viewModel.utilizationGreatestValue != null
                                      ? viewModel.utilizationGreatestValue
                                      : null,
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
                      child: FuelLevel(
                          liquidColor: tango,
                          value: widget.detail != null &&
                                  widget.detail.percentDEFRemaining != null
                              ? widget.detail.percentDEFRemaining.toDouble()
                              : null,
                          title: "Diesel Exhaust Fluid (DEF) Level ",
                          lifeTimeFuel: widget.detail.lifetimeDEFLiters != null
                              ? "lifetime fuel :\n" +
                                  widget.detail.lifetimeDEFLiters
                                      .round()
                                      .toString() +
                                  " liters"
                              : "",
                          percentage: widget.detail != null &&
                                  widget.detail.percentDEFRemaining != null
                              ? widget.detail.percentDEFRemaining.toString()
                              : null,
                          lastReported: widget
                                      .detail.lastPercentDEFRemainingUTC !=
                                  null
                              ? "Last Reported Time: ".toUpperCase() +
                                  Utils.getLastReportedDateOneUTC(
                                      widget.detail.lastPercentDEFRemainingUTC)
                              : "No Data Received"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    viewModel.assetDetail != null
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: GoogleMapDetailWidget(
                                isLoading: false,
                                latitude: viewModel.assetDetail
                                            .lastReportedLocationLatitude !=
                                        null
                                    ? viewModel.assetDetail
                                        .lastReportedLocationLatitude
                                    : null,
                                screenType: ScreenType.ASSET_DETAIL,
                                status: widget.detail.lastLocationUpdateUTC !=
                                        null
                                    ? "Last Reported Time: ".toUpperCase() +
                                        Utils.getLastReportedDateOneUTC(
                                            widget.detail.lastLocationUpdateUTC)
                                    : "No Data Receiveed",
                                onMarkerTap: () {
                                  widget.switchTab(3);
                                },
                                initLocation: null,
                                location: viewModel
                                            .assetDetail.lastReportedLocation !=
                                        null
                                    ? viewModel.assetDetail.lastReportedLocation
                                    : "",
                                longitude: viewModel.assetDetail
                                            .lastReportedLocationLongitude !=
                                        null
                                    ? viewModel.assetDetail
                                        .lastReportedLocationLongitude
                                    : null),
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
                        controller: notesController,
                        notes: viewModel.assetNotes,
                        onTap: () {
                          if (notesController.text.isNotEmpty) {
                            viewModel.postNotes(notesController.text);
                            notesController.text = "";
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
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //     horizontal: 16.0,
                    //   ),
                    //   child: Notifications(),
                    // ),
                    // SizedBox(
                    //   height: 20.0,
                    // ),
                  ],
                ),
              ),
            ),
          );
        }
      },
      viewModelBuilder: () => AssetDashboardViewModel(widget.detail),
    );
  }
}
