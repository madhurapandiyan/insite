import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/utilization_legends.dart';
import 'package:insite/widgets/smart_widgets/range_selection_widget.dart';
import 'package:insite/widgets/smart_widgets/total_fuel_burned_graph.dart';
import 'package:stacked/stacked.dart';
import 'total_fuel_burned_view_model.dart';

class TotalFuelBurnedView extends StatefulWidget {
  final int? rangeChoice;
  const TotalFuelBurnedView({
    Key? key,
    this.rangeChoice,
  }) : super(key: key);

  @override
  TotalFuelBurnedViewState createState() => TotalFuelBurnedViewState();
}

class TotalFuelBurnedViewState extends State<TotalFuelBurnedView> {
  int rangeChoice = 1;
  List<String> rangeTexts = ['daily', 'weekly', 'monthly'];
  late var viewModel;
  List<bool> shouldShowLabel = [true, true, true];
  @override
  void initState() {
    viewModel = TotalFuelBurnedViewModel();
    super.initState();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  refresh() {
    viewModel.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TotalFuelBurnedViewModel>.reactive(
      builder:
          (BuildContext context, TotalFuelBurnedViewModel viewModel, Widget? _) {
        if (viewModel.loading) return InsiteProgressBar();
        return Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RangeSelectionWidget(
                          label1: 'Day',
                          label2: 'Week',
                          label3: 'month',
                          rangeChoice: (int choice) {
                            setState(() {
                              rangeChoice = choice;
                              viewModel.range = rangeTexts[rangeChoice - 1];
                              viewModel.getTotalFuelBurned();
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: UtilizationLegends(
                          label1: 'Working',
                          label2: 'Idle',
                          label3: 'Runtime',
                          color1: emerald,
                          color2: burntSienna,
                          color3: creamCan,
                          shouldShowLabel: (List<bool> value) {
                            setState(() {
                              shouldShowLabel = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TotalFuelBurnedGraph(
                    rangeSelection: rangeChoice,
                    totalFuelBurned: viewModel.totalFuelBurned,
                    shouldShowLabel: shouldShowLabel,
                  ),
                ),
              ],
            ),
            (viewModel.isRefreshing || viewModel.isSwitching)
                ? InsiteProgressBar()
                : SizedBox()
          ],
        );
      },
      viewModelBuilder: () => viewModel,
    );
  }
}
