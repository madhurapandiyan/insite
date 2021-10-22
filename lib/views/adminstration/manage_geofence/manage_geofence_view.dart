import 'package:flutter/material.dart';
import 'package:insite/views/adminstration/manage_geofence/manage_geofence_widget/manage_geofensewidget.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:stacked/stacked.dart';
import 'manage_geofence_view_model.dart';

class ManageGeofenceView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ManageGeofenceViewModel>.reactive(
      builder:
          (BuildContext context, ManageGeofenceViewModel viewModel, Widget _) {
        return InsiteScaffold(
          viewModel: viewModel,
          body: ManageGeofenceWidget(viewModel),

        );
      },
      viewModelBuilder: () => ManageGeofenceViewModel(),
    );
  }
}
