import 'package:flutter/material.dart';
import 'package:insite/views/adminstration/manage_geofence/manage_geofence_widget/manage_geofensewidget.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:stacked/stacked.dart';
import 'manage_geofence_view_model.dart';

class ManageGeofenceView extends StatefulWidget {
  @override
  _ManageGeofenceViewState createState() => _ManageGeofenceViewState();
}

class _ManageGeofenceViewState extends State<ManageGeofenceView> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return ViewModelBuilder<ManageGeofenceViewModel>.reactive(
      builder:
          (BuildContext context, ManageGeofenceViewModel viewModel, Widget _) {
        return InsiteScaffold(
            viewModel: viewModel,
            body: viewModel.isLoading
                ? Center(child: InsiteProgressBar())
                : Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InsiteText(
                              text: "Manage Geofence",
                              fontWeight: FontWeight.w700,
                              size: 20,
                            ),
                            InsiteButton(
                              title: "ADD GEOFENCE",
                              height: mediaQuery.size.height * 0.05,
                              width: mediaQuery.size.width * 0.4,
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: viewModel.geofence.Geofences.length,
                          itemBuilder: (BuildContext context, int i) {
                            var model = viewModel.geofence.Geofences;

                            return ManageGeofenceWidget(
                                model[i].GeofenceName, model[i].StartDate,
                                (uid, actionutc) {
                              viewModel.deleteGeofence(uid, actionutc);
                            }, model[i].GeofenceUID);
                          },
                        ),
                      ),
                    ],
                  ));
      },
      viewModelBuilder: () => ManageGeofenceViewModel(),
    );
  }
}
