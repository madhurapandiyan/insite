import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/utilization_legends.dart';
import 'package:insite/widgets/smart_widgets/range_selection_widget.dart';
import 'package:insite/widgets/smart_widgets/total_fuel_burned_graph.dart';
import 'package:stacked/stacked.dart';
import 'total_fuel_burned_view_model.dart';

class TotalFuelBurnedView extends StatefulWidget {
  final int rangeChoice;
  final String startDate;
  final String endDate;
  const TotalFuelBurnedView(
      {Key key, this.rangeChoice, this.startDate, this.endDate})
      : super(key: key);

  @override
  _TotalFuelBurnedViewState createState() => _TotalFuelBurnedViewState();
}

class _TotalFuelBurnedViewState extends State<TotalFuelBurnedView> {
  int rangeChoice = 1;
  List<String> rangeTexts = ['daily', 'weekly', 'monthly'];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TotalFuelBurnedViewModel>.reactive(
      builder:
          (BuildContext context, TotalFuelBurnedViewModel viewModel, Widget _) {
        if (viewModel.loading) return CircularProgressIndicator();
        return Column(
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
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TotalFuelBurnedGraph(
                  rangeSelection: rangeChoice,
                  totalFuelBurned: viewModel.totalFuelBurned),
            ),
          ],
        );
      },
      viewModelBuilder: () =>
          TotalFuelBurnedViewModel(widget.startDate, widget.endDate),
    );
  }
}
