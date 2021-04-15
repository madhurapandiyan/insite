import 'package:flutter/material.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/asset_details_widget.dart';
import 'package:insite/widgets/smart_widgets/asset_utilization.dart';
import 'package:insite/widgets/smart_widgets/fuel_level.dart';
import 'package:insite/widgets/smart_widgets/notes.dart';
import 'package:insite/widgets/smart_widgets/notifications.dart';
import 'package:insite/widgets/smart_widgets/ping_device.dart';

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
    return SingleChildScrollView(
      child: Container(
        color: mediumgrey,
        padding: EdgeInsets.all(8),
        child: Column(
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
            AssetUtilizationWidget(),
            SizedBox(
              height: 20,
            ),
            FuelLevel(
                liquidColor: mustard,
                value: 0.76,
                title: "Diesel Exhaust Fuel Level",
                lifeTimeFuel: "lifetime DEF :\n 1574 liters",
                percentage: "16",
                lastReported: "04/25/2019, 10:30 AM"),
            SizedBox(
              height: 20,
            ),
            Notes(controller: notesController, onTap: () {}),
            SizedBox(
              height: 20,
            ),
            PingDevice(onTap: () {}),
            SizedBox(
              height: 20,
            ),
            Notifications()
          ],
        ),
      ),
    );
  }
}
