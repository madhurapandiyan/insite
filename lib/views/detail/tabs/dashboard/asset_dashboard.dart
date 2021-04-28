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
          double Latitude = viewModel.assetDetail.lastReportedLocationLatitude;
          print('Lati :$Latitude');
          double Longitude =
              viewModel.assetDetail.lastReportedLocationLongitude;
          print('Longi :$Longitude');
          return SingleChildScrollView(
            child: Container(
              color: mediumgrey,
              padding: EdgeInsets.all(8),
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: ListView(
                  // shrinkWrap: true,
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
                    AssetUtilizationWidget(
                      assetUtilization: AssetUtilization.fromJson(jsonDecode(
                          '{"totalDay":{"idleHours":27.292,"runtimeHours":674.473234,"workingHours":24.033},"totalWeek":{"idleHours":139.712,"runtimeHours":3697.337071,"workingHours":201.631},"totalMonth":{"idleHours":659.954,"runtimeHours":18108.287383,"workingHours":1016.107},"averageDay":{"idleHours":0.162452381,"runtimeHours":4.014721631,"workingHours":0.1430535714},"averageWeek":{"idleHours":0.2531014493,"runtimeHours":6.698074404,"workingHours":0.3652735507},"averageMonth":{"idleHours":0.2710283368,"runtimeHours":7.4366683298,"workingHours":0.4172924025}}')),
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
                    Container(
                        width: 374.04,
                        height: 305.4,
                        color: cardcolor,
                        child: FleetGoogleMap(
                            Latitude: Latitude, Longitude: Longitude)),
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
      viewModelBuilder: () => AssetDashboardViewModel(),
    );
  }
}
