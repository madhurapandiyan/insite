import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UtilLizationViewModel>.reactive(
        builder:
            (BuildContext context, UtilLizationViewModel viewModel, Widget _) {
          return InsiteScaffold(
            screenType: ScreenType.UTILIZATION,
            viewModel: viewModel,
            body: Container(
              color: bgcolor,
              child: Container(
                decoration: BoxDecoration(
                  color: mediumgrey,
                  border: Border.all(color: black, width: 0.0),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        isListSelected
                            ? Flexible(
                                child: UtilizationListView(),
                              )
                            : Flexible(
                                child: UtilizationGraphView(),
                              ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          ToggleButton(
                              label1: 'list',
                              label2: 'graph',
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
        viewModelBuilder: () => UtilLizationViewModel(true));
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
