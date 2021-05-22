import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/models/asset_utilization.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/detail/tabs/dashboard/asset_dashboard_view_model.dart';
import 'package:insite/widgets/dumb_widgets/asset_details_widget.dart';
import 'package:insite/widgets/smart_widgets/asset_utilization.dart';
import 'package:insite/widgets/smart_widgets/fleet_google_map.dart';
import 'package:insite/widgets/smart_widgets/fuel_level.dart';
import 'package:insite/widgets/smart_widgets/notes.dart';
import 'package:insite/widgets/smart_widgets/notifications.dart';
import 'package:insite/widgets/smart_widgets/ping_device.dart';
import 'package:stacked/stacked.dart';

class AssetDashbaord extends StatefulWidget {
  final AssetDetail detail;

  AssetDashbaord({this.detail});

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
          return Center(child: CircularProgressIndicator());
        } else {
          return SingleChildScrollView(
            child: Container(
              color: mediumgrey,
              padding: EdgeInsets.all(8),
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: ListView(
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: [
                    AssetDetailWidgt(
                      detail: widget.detail,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FuelLevel(
                        liquidColor: mustard,
                        title: "Fuel Level",
                        value: 0.16,
                        lifeTimeFuel: "lifetime fuel :\n 0 liters",
                        percentage: "16",
                        lastReported: "04/25/2019, 10:30 AM"),
                    SizedBox(
                      height: 20,
                    ),
                    viewModel.assetUtilization == null
                        ? CircularProgressIndicator()
                        : AssetUtilizationWidget(
                            assetUtilization: viewModel.assetUtilization,
                          ),
                    SizedBox(
                      height: 20,
                    ),
                    FuelLevel(
                        liquidColor: mustard,
                        value: 0.76,
                        title: "Diesel Exhaust Fuel Level",
                        lifeTimeFuel: "lifetime DEF :\n 1574 liters",
                        percentage: "76",
                        lastReported: "04/25/2019, 10:30 AM"),
                    SizedBox(
                      height: 20,
                    ),
                    Notes(controller: notesController, onTap: () {}),
                    SizedBox(
                      height: 20,
                    ),
                    viewModel.assetDetail != null
                        ? Container(
                            width: 374.04,
                            height: 305.4,
                            color: cardcolor,
                            child: FleetGoogleMap(
                                latitude: viewModel
                                    .assetDetail.lastReportedLocationLatitude,
                                longitude: viewModel
                                    .assetDetail.lastReportedLocationLongitude))
                        : SizedBox(),
                    SizedBox(
                      height: 20.0,
                    ),
                    PingDevice(onTap: () {}),
                    SizedBox(
                      height: 20,
                    ),
                    Notifications()
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
