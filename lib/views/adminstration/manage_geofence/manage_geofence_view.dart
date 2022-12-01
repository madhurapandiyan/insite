import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart' as type;
import 'package:insite/views/adminstration/manage_geofence/manage_geofence_widget/manage_geofensewidget.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
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
          (BuildContext context, ManageGeofenceViewModel viewModel, Widget? _) {
        return InsiteScaffold(
            screenType: type.ScreenType.MANAGE_GEOFENCE,
            viewModel: viewModel,
            body: viewModel.isLoading
                ? Center(child: InsiteProgressBar())
                : SingleChildScrollView(
                    child: Column(
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
                                onTap: () {
                                  viewModel.onNavigation(null);
                                },
                                textColor: white,
                                title: "ADD GEOFENCE",
                                height: mediaQuery.size.height * 0.05,
                                width: mediaQuery.size.width * 0.4,
                              )
                            ],
                          ),
                        ),
                        viewModel.geofence!.geofences!.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 300,
                                    ),
                                    InsiteText(
                                      text: "No Geofence found",
                                      size: 20,
                                    ),
                                  ],
                                ),
                              )
                            : Column(
                                children: List.generate(
                                    viewModel.geofence!.geofences!.length, (i) {
                                var model = viewModel.geofence!.geofences!;
                                return Column(
                                  children: [
                                    ManageGeofenceWidget(
                                      dateFormat: viewModel.userPref,
                                      encodedPolyline:
                                          viewModel.listOfEncoded[i],
                                      isFav: model[i].IsFavorite,
                                      onFavourite: (uid) {
                                        viewModel.markFavouriteStatus(uid!, i);
                                      },
                                      onNavigation: () {
                                        viewModel
                                            .onNavigation(model[i].GeofenceUID);
                                      },
                                      ondeleting: (uid, actionutc) {
                                        viewModel.deleteGeofence(
                                            uid, actionutc, i, context);
                                      },
                                      color: model[i].FillColor,
                                      geofenceName: model[i].GeofenceName,
                                      geofenceDate: model[i].EndDate,
                                      geofenceUID: model[i].GeofenceUID,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                );
                              }))
                      ],
                    ),
                  ));
      },
      viewModelBuilder: () => ManageGeofenceViewModel(),
    );
  }
}
