import 'package:flutter/material.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/smart_widgets/fleet_item.dart';
import 'package:stacked/stacked.dart';
import 'fleet_view_model.dart';

class FleetView extends StatefulWidget {
  final VoidCallback onDetailPageSelected;
  FleetView({this.onDetailPageSelected});

  @override
  _FleetViewState createState() => _FleetViewState();
}

class _FleetViewState extends State<FleetView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FleetViewModel>.reactive(
      builder: (BuildContext context, FleetViewModel viewModel, Widget _) {
        return Scaffold(
          backgroundColor: bgcolor,
          body: viewModel.loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : viewModel.assets.isNotEmpty
                  ? ListView.builder(
                      itemCount: viewModel.assets.length,
                      padding: EdgeInsets.all(16),
                      itemBuilder: (context, index) {
                        Fleet fleet = viewModel.assets[index];
                        return FleetItem(
                          fleet: fleet,
                          onCallback: () {
                            widget.onDetailPageSelected();
                          },
                        );
                      })
                  : EmptyView(title: "No Results"),
        );
      },
      viewModelBuilder: () => FleetViewModel(),
    );
  }
}
