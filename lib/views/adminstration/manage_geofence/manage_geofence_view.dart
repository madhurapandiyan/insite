import 'package:flutter/material.dart';
import 'package:insite/views/adminstration/manage_geofence/manage_geofence_widget/manage_geofensewidget.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'manage_geofence_view_model.dart';

class ManageGeofenceView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaquerry = MediaQuery.of(context);
    return ViewModelBuilder<ManageGeofenceViewModel>.reactive(
      builder:
          (BuildContext context, ManageGeofenceViewModel viewModel, Widget _) {
        return InsiteScaffold(
          viewModel: viewModel,
          body: FutureBuilder(
            future: viewModel.getdata(),
            //initialData: InitialData,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return Column(
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
                          height: mediaquerry.size.height * 0.05,
                          width: mediaquerry.size.width * 0.4,
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
                            viewModel, model[i].GeofenceName, model[i].StartDate);
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
      viewModelBuilder: () => ManageGeofenceViewModel(),
    );
  }
}
