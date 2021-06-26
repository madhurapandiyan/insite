import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/utilization_legends.dart';
import 'package:insite/widgets/smart_widgets/fuel_burn_rate_graph.dart';
import 'package:insite/widgets/smart_widgets/range_selection_widget.dart';
import 'package:stacked/stacked.dart';
import 'fuel_burn_rate_trend_view_model.dart';

class FuelBurnRateTrendView extends StatefulWidget {
  const FuelBurnRateTrendView({
    Key key,
  }) : super(key: key);

  @override
  FuelBurnRateTrendViewState createState() => FuelBurnRateTrendViewState();
}

class FuelBurnRateTrendViewState extends State<FuelBurnRateTrendView> {
  int rangeChoice = 1;
  List<String> rangeTexts = ['daily', 'weekly', 'monthly'];
  var viewModel;

  @override
  void initState() {
    viewModel = FuelBurnRateTrendViewModel();
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
    return ViewModelBuilder<FuelBurnRateTrendViewModel>.reactive(
      builder: (BuildContext context, FuelBurnRateTrendViewModel viewModel,
          Widget _) {
        if (viewModel.loading)
          return Center(child: CircularProgressIndicator());
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
                              viewModel.getFuelBurnRateTrend();
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
                  child: FuelBurnRateGraph(
                      rangeSelection: rangeChoice,
                      fuelBurnRateTrend: viewModel.fuelBurnRateTrend),
                ),
              ],
            ),
            viewModel.isRefreshing
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox()
          ],
        );
      },
      viewModelBuilder: () => viewModel,
    );
  }
}
