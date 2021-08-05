import 'package:flutter/material.dart';
import 'package:insite/core/insite_data_provider.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/home/home_view.dart';
import 'package:insite/views/utilization/tabs/graph_view/utilization_graph_view.dart';
import 'package:insite/views/utilization/tabs/list/utilization_list_view.dart';
import 'package:insite/views/utilization/utilization_view_model.dart';
import 'package:insite/widgets/dumb_widgets/toggle_button.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:stacked/stacked.dart';

class UtilLizationView extends StatefulWidget {
  @override
  _UtilLizationViewState createState() => _UtilLizationViewState();
}

class _UtilLizationViewState extends State<UtilLizationView> {
  bool isListSelected = true;
  int rangeChoice = 1;
  bool isRangeSelectionVisible = false;

  final GlobalKey<UtilizationListViewState> listViewKey = new GlobalKey();
  final GlobalKey<UtilizationGraphViewState> graphViewKey = new GlobalKey();

  void refreshWithFilter() {
    if (isListSelected) {
      listViewKey.currentState.onFilterApplied();
    } else {
      graphViewKey.currentState.onFilterApplied();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UtilLizationViewModel>.reactive(
        builder:
            (BuildContext context, UtilLizationViewModel viewModel, Widget _) {
          return InsiteInheritedDataProvider(
            count: viewModel.appliedFilters.length,
            child: InsiteScaffold(
              screenType: ScreenType.UTILIZATION,
              viewModel: viewModel,
              onFilterApplied: () {
                viewModel.refresh();
                refreshWithFilter();
              },
              body: Container(
                color: bgcolor,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        isListSelected
                            ? Flexible(
                                child: UtilizationListView(
                                  key: listViewKey,
                                ),
                              )
                            : Flexible(
                                child: UtilizationGraphView(
                                  key: graphViewKey,
                                ),
                              ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16),
                      child: Row(
                        children: [
                          ToggleButton(
                              label1: '  list  ',
                              label2: '  graph  ',
                              optionSelected: (bool value) {
                                setState(() {
                                  isListSelected = value;
                                });
                              }),
                          Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        viewModelBuilder: () => UtilLizationViewModel());
  }
}

enum UtilizationGraphType {
  IDLEORWORKING,
  RUNTIMEHOURS,
  DISTANCETRAVELLED,
  CUMULATIVE,
  TOTALHOURS,
  TOTALFUELBURNED,
  IDLETREND,
  FUELBURNRATETREND
}
