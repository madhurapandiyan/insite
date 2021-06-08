import 'package:flutter/material.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/filter/filter_chip_view.dart';
import 'package:insite/views/filter/filter_knob_view.dart';
import 'package:insite/views/home/home_view.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/smart_widgets/fleet_item.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:stacked/stacked.dart';
import 'fleet_view_model.dart';

class FleetView extends StatefulWidget {
  FleetView();

  @override
  _FleetViewState createState() => _FleetViewState();
}

class _FleetViewState extends State<FleetView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FleetViewModel>.reactive(
      builder: (BuildContext context, FleetViewModel viewModel, Widget _) {
        return InsiteScaffold(
          viewModel: viewModel,
          screenType: ScreenType.FLEET,
          onFilterApplied: () {},
          body: Container(
            color: bgcolor,
            child: viewModel.loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : viewModel.assets.isNotEmpty
                    ? Column(
                        children: [
                          viewModel.appliedFilters.isNotEmpty
                              ? FilterChipView(
                                  data: viewModel.appliedFilters,
                                )
                              : SizedBox(),
                          viewModel.appliedFilters.isNotEmpty
                              ? Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.15,
                                  child: FleetKnobView(
                                    data: viewModel.appliedFilters,
                                  ),
                                )
                              : SizedBox(),
                          Expanded(
                            child: ListView.builder(
                                itemCount: viewModel.assets.length,
                                padding: EdgeInsets.all(16),
                                controller: viewModel.scrollController,
                                itemBuilder: (context, index) {
                                  Fleet fleet = viewModel.assets[index];
                                  return FleetListItem(
                                    fleet: fleet,
                                    onCallback: () {
                                      viewModel.onDetailPageSelected(fleet);
                                    },
                                  );
                                }),
                          ),
                          viewModel.loadingMore
                              ? Padding(
                                  padding: EdgeInsets.all(8),
                                  child: CircularProgressIndicator())
                              : SizedBox()
                        ],
                      )
                    : EmptyView(title: "No Results"),
          ),
        );
      },
      viewModelBuilder: () => FleetViewModel(),
    );
  }
}
