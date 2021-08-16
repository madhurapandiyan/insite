import 'package:flutter/material.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/asset_detail_health.dart';
import 'package:insite/widgets/smart_widgets/fault_health_dashboard.dart';
import 'package:insite/widgets/smart_widgets/google_map_detail.dart';
import 'package:insite/widgets/smart_widgets/notes.dart';
import 'package:insite/widgets/smart_widgets/notifications.dart';
import 'package:insite/widgets/smart_widgets/ping_device.dart';
import 'package:stacked/stacked.dart';
import 'health_dashboard_view_model.dart';

class HealthDashboardView extends StatefulWidget {
  final AssetDetail detail;
  final Function(int) switchTab;

  const HealthDashboardView({this.detail, this.switchTab});
  @override
  _HealthDashboardViewState createState() => _HealthDashboardViewState();
}

class _HealthDashboardViewState extends State<HealthDashboardView> {
  TextEditingController notesController;

  @override
  void initState() {
    notesController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HealthDashboardViewModel>.reactive(
      builder:
          (BuildContext context, HealthDashboardViewModel viewModel, Widget _) {
        if (viewModel.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              color: mediumgrey,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    child: AssetDetailHealth(
                      detail: widget.detail,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  viewModel.faultData != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                          ),
                          child: FaultHealthDashboard(
                            screenType: ScreenType.ASSET_DETAIL,
                            countData: viewModel.faultData != null
                                ? viewModel.faultData
                                : null,
                            loading: viewModel.loading,
                          ),
                        )
                      : SizedBox(),
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
                                  ? viewModel
                                      .assetDetail.lastReportedLocationLatitude
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
                                  ? viewModel
                                      .assetDetail.lastReportedLocationLongitude
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
                    height: 20,
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    child: Notifications(),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
          );
        }
      },
      viewModelBuilder: () => HealthDashboardViewModel(widget.detail),
    );
  }
}
