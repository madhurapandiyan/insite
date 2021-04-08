import 'package:flutter/material.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/fleet_knob.dart';
import 'package:insite/widgets/smart_widgets/fleet_chip_filter.dart';
import 'package:insite/widgets/smart_widgets/fleet_item.dart';
import 'package:stacked/stacked.dart';
import 'fleet_view_model.dart';

class FleetView extends StatefulWidget {
  final Function(Fleet) onDetailPageSelected;
  FleetView({this.onDetailPageSelected});

  @override
  _FleetViewState createState() => _FleetViewState();
}

class _FleetViewState extends State<FleetView> {
  List<String> filters = [];

  @override
  void initState() {
    filters.add("BACKHOE");
    filters.add("EXCAVATORS");
    filters.add("UNASSIGNED");
    filters.add("BACKHOE");
    filters.add("WHEEL");
    super.initState();
  }

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
                  ? Column(
                      children: [
                        FleetFilterView(),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.175,
                          child: ListView.builder(
                            padding: EdgeInsets.all(8),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return FleetKnob(
                                  count: "400", label: filters[index]);
                            },
                            itemCount: filters.length,
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: viewModel.assets.length,
                              padding: EdgeInsets.all(16),
                              itemBuilder: (context, index) {
                                Fleet fleet = viewModel.assets[index];
                                return FleetItem(
                                  fleet: fleet,
                                  onCallback: () {
                                    widget.onDetailPageSelected(fleet);
                                  },
                                );
                              }),
                        ),
                      ],
                    )
                  : EmptyView(title: "No Results"),
        );
      },
      viewModelBuilder: () => FleetViewModel(),
    );
  }
}

class FleetFilterView extends StatelessWidget {
  const FleetFilterView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Wrap(
        runSpacing: 4,
        spacing: 4,
        children: [
          FleetChipFilter(
            label: "BACKHOE LOADERS",
            onClose: () {},
          ),
          FleetChipFilter(
            label: "WHEEL LOADER",
            onClose: () {},
          ),
          FleetChipFilter(
            label: "EXCAVATOR",
            onClose: () {},
          ),
          FleetChipFilter(
            label: "UNASSIGNED",
            onClose: () {},
          ),
        ],
      ),
    );
  }
}
